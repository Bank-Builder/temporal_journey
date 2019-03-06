# Final Word

We started this journey by taking some time to understand time, time-zones [(Getting to UTC)](getting_to_UTC.md) & understanding range data (such as used in tstzrange data), temporal tables & logical replication [(PSQL Used)](psql_used.md)

The files step-1.sh through step-5.sh will take you through the entire demonstration of setting up two faux micro-services (db's only) & a canonical db, setting up temporal_tables in the canonical db and replication publishing from the micro-services to the canonical db.  INSERT's, UPDATE's & DELETE's in the micro-service db's are replicated and a temporal history is kept via the versioning trigger in the associated history tables.


## Bi-Temporal Data
So what is meant by Temporal data, and in particular bi-temporal data?

* Temporal Data is simply data that changes over time [from-a-time, to-a-time) and the inclusive "[" and exclusive ")" notion is used by postgres.

* bi-temporal data is simple dealing with two set of temporal data - which allows us to know is “what we knew/had” and “when we knew/had it”.  One set of data for when a row was changed - we called this sys-period in our examples.  Another set of range data can be added which indicates for when the data was valid.  Change integrity and Validity are requirements for both auditing and risk management respectively in regulated industries such as the financial services industry, but it is also arguably applicable in any enterprise that relies on historical information.

Lets see how we can take our *jibar* data which has a valid_from column and turn it into bi-temporal data with a valid_period range column and the sys_period column we now are familair with. We will use the existing db-jibar.sql script for this exercise. We use bi-temporal_db for our db name.

```
docker run -d -p 5444:5432 --name bitemporal postgres
PGPASSWORD=postgres createdb -h localhost -p 5444 -U postgres bitemporal_db
PGPASSWORD=postgres psql -h localhost -p 5444 -U postgres bitemporal_db < db-jibar.sql
PGPASSWORD=postgres psql -h localhost -p 5444 -U postgres -d bitemporal_db
```

and manually run through the steps to understand what is happening
```SQL
-- we want to use the gist index type
CREATE EXTENSION btree_gist;
--- we need to alter our table to be bi-temporal instructure
ALTER TABLE jibar 
  ADD COLUMN validity_period daterange;
ALTER TABLE jibar
  ADD CONSTRAINT no_overlap   
  EXCLUDE USING gist  (validity_period WITH && );
--- if we were managing multiple rates I would add their code into the gist 
--- (rate_code WITH = ) to ensure non overlapping by rate code for example...  
---
--- we now need to remove the rows with zero as a rate value
DELETE FROM jibar WHERE rate = '0.000';
--- we now create a range by using the valid_from date till the next non-missing row by date
SELECT id, rate, daterange(valid_from::DATE, lead (valid_from::DATE) OVER (PARTITION BY 'jibar' ORDER BY valid_from) , '[)' ) FROM jibar;
--- and we need into insert this into out validity_range field we added
WITH r AS (
    SELECT id, rate, daterange(valid_from::DATE, lead (valid_from::DATE) 
    OVER (PARTITION BY 'jibar' ORDER BY valid_from) , '[)' ) AS validity_period FROM jibar
    )                                                                    
UPDATE jibar SET validity_period = r.validity_period 
FROM r WHERE jibar.id = r.id ;
--- we nolonger need the valid_from column so we drop it
ALTER TABLE jibar
   DROP COLUMN valid_from;
```
note: The GiST index type does not support one-dimensional data types which is why we use the btree_gist extension

Back to our jibar data - although there is no row with a rate for the '2019-02-02' we can find the valid rate for the 2nd Feb using the "contains @> operator"
```SQL
SELECT rate from jibar WHERE validity_period @> date '20190202';
```
and if we wanted the jibare rates for a range of dates we could do the following
```SQL
SELECT * FROM jibar WHERE validity_period && daterange('2019-02-03','2019-02-07', '[)');
--- play with the '[)' excluding vs '[]' inclusion of the 7th and see how it works
---
--- last, a few more the road
SELECT * FROM jibar WHERE validity_period -|- daterange('2019-02-03','2019-02-07', '[)');
SELECT * FROM jibar WHERE validity_period >> daterange('2019-02-03','2019-02-07', '[)');
SELECT * FROM jibar WHERE validity_period &< daterange('2019-02-03','2019-02-07', '[)');
```
and a neat example of a function that works with date ranges
```SQL
--- source: wiki.postgres.org
CREATE OR REPLACE FUNCTION extract_days (TSRANGE) RETURNS INTEGER AS
$func$
  SELECT (date_trunc('day', UPPER($1))::DATE - date_trunc('day', LOWER($1))::DATE) + 1;
$func$ LANGUAGE SQL;
--- and we use it something like this ...
SELECT extract_days(tsrange( lower(validity_period), upper(validity_period))) as validity_days, rate, validity_period FROM jibar;
```

*SELF EXERCISE*
> As an exercise you can DISABLE the subscription in the canonical_db, 
> apply the DDL changes to the jibar table in both the jibar_db and the
> canonical_db, and then reENABLE the subscription in the canonical_db. 
> Playing around like this will allow you to see what survives DDL changes 
> and when logical replication breaks because of DDL changes.


'FINIS'


References:
======
```
https://www.youtube.com/watch?t=28&v=n29Gtit3lMU
https://tapoueh.org/blog/2018/04/postgresql-data-types-ranges/


FX Rates table with validity Ranges and use GIST index to search etc
http://www.histdata.com/download-free-forex-historical-data/?/ascii/1-minute-bar-quotes/usdzar/2018/12

    Row Fields:
    DateTime Stamp;Bar OPEN Bid Quote;Bar HIGH Bid Quote;Bar LOW Bid Quote;Bar CLOSE Bid Quote;Volume

    DateTime Stamp Format:
    YYYYMMDD HHMMSS

    Legend:
    YYYY – Year
    MM – Month (01 to 12)
    DD – Day of the Month
    HH – Hour of the day (in 24h format)
    MM – Minute
    SS – Second, in this case it will be allways 00
```





