# PSQL Background
This is a collection psql steps and commands that wil help us understand what is happening in the database once we have temporal data working.

## Temporal Tables
We will use the fork of temporal_tables from Nearform.  This project is an elegant reworking of the pg_temporal_tables plugin in pure SQL using a procedure and triggers.

```bash
git clone git@github.com:GrindrodBank/temporal_tables.git
```
Lets change into the cloned directory and we will also need a postgres container to work with so:
```bash
cd temporal_tables
docker pull postgres
docker run -d -p 5444:5432 --name db postgres
docker ps
```
This will allow us to connect to it on localhost:5444, so lets connect & create a database temporal_test and
import the versioning function used by the trigger we will be creating to enable temporal tables.
```bash
PGPASSWORD=postgres createdb -h localhost -p 5444 -U postgres temporal_test
PGPASSWORD=postgres psql -h localhost -p 5444 -U postgres temporal_test < versioning_function.sql
```
now we can connect and try and get a feel for what temporal tables will do..
```bash
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test
```
First lets create the tables we will be working with
```SQL
CREATE TABLE fica_status ( name text NOT NULL, status text NOT NULL, changed_by text NOT NULL );
ALTER TABLE fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);
CREATE TABLE fica_status_history (LIKE fica_status);
```
So lets see what we have
```SQL
SELECT * from fica_status;
SELECT * FROM fica_status_history;
```
Then we will take a look at the function we imported and create a trigger to use that function
```SQL
select pg_get_functiondef('versioning'::regproc);
CREATE TRIGGER versioning_trigger
BEFORE INSERT OR UPDATE OR DELETE ON fica_status 
FOR EACH ROW EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', true);
```
This will trigger on every insert, update or delete and make a copy into our history table.
Before we try use this we can take a look into postgres to see how it understands what we have done.
```SQL
SELECT action_statement, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_name='versioning_trigger';
```
```                         action_statement                              | event_manipulation | event_object_table 
---------------------------------------------------------------------------+--------------------+--------------------
 EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', 'true') | INSERT             | fica_status
 EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', 'true') | DELETE             | fica_status
 EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', 'true') | UPDATE             | fica_status
(3 rows)

```
We are now ready to take this for a test drive, so lest add some data and perfrom some actions.

```SQL
INSERT INTO fica_status (name, status, changed_by) 
   VALUES ('mr big', 'non-compliant', 'vanessa'),
          ('mr cool', 'frozen', 'tracy'),
          ('mr frugal', 'compliant', 'betty');
UPDATE fica_status SET status = 'compliant', changed_by = 'leona' WHERE name = 'mr big';
UPDATE fica_status SET status = 'expired', changed_by = 'kim' WHERE name = 'mr cool';
DELETE FROM fica_status WHERE name = 'mr frugal';

SELECT * FROM fica_status;
```
And we should have something like this:
```
  name   |  status   | changed_by |             sys_period             
---------+-----------+------------+------------------------------------
 mr big  | compliant | leona      | ["2019-02-26 21:24:13.818859+00",)
 mr cool | expired   | kim        | ["2019-02-26 21:24:20.026798+00",)
(2 rows)
```
and looking at the history
```SQL
SELECT * FROM fica_status_history;
```
We can see the records and when they were in that state within the system
```
   name    |    status     | changed_by |                            sys_period                             
-----------+---------------+------------+-------------------------------------------------------------------
 mr big    | non-compliant | vanessa    | ["2019-02-26 21:24:07.459262+00","2019-02-26 21:24:13.818859+00")
 mr cool   | frozen        | tracy      | ["2019-02-26 21:24:07.459262+00","2019-02-26 21:24:20.026798+00")
 mr frugal | compliant     | betty      | ["2019-02-26 21:24:07.459262+00","2019-02-26 21:24:26.106769+00")
(3 rows)
```
As an aside, the equivalent in MS SQLServer is quite elegant:
```SQL
> CREATE TABLE FicaStatus (
>   ID              int NOT NULL IDENTITY(1,1) PRIMARY KEY,
>   Name            varchar(50) NOT NULL,
>   ChangedBy       int NULL,
>   ValidFrom       datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
>   ValidTo         datetime2 GENERATED ALWAYS AS ROW END   NOT NULL,
>   PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
> )
> WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = FicaStatusHistory))
```
And that is all there is to it.  We can for example easily find out which records where deleted with a query similar to this - lets try it.
```SQL
SELECT DISTINCT fsh.name AS deleted FROM fica_status_history fsh LEFT JOIN fica_status fs ON fs.name=fsh.name WHERE fs.name IS NULL;
```

That is all there is to it.  

## Range Data (Time in particular)
Postgres comes with several built-in range types, we are interested in tstzrange, daterange and int4range- a range of integers.  You can define your own range types using the keyword RANGE but that is out of scope of thsi journey.

We try out a few examples to get our head in the game:
```SQL
SELECT '[3,7)'::int4range;
SELECT numrange(1.0, 14.0, '(]');

```

We will look at using GIST indexes on columns of range types.
```SQL
CREATE INDEX <new_idx> ON <my_table> USING GIST (<my_column);
```
We can no use the operators :

|*Operator* |*Description* |*Example* |*Result*|
|= |equal |int4range(1,5) = '[1,4]'::int4range |t|
|<> |not equal |numrange(1.1,2.2) <> numrange(1.1,2.3) |t|
|< |less than |int4range(1,10) < int4range(2,3) |t|
|> |greater than |int4range(1,10) > int4range(1,5) |t|
|<= |less than or equal |numrange(1.1,2.2) <= numrange(1.1,2.2) |t|
|>= |greater than or equal |numrange(1.1,2.2) >= numrange(1.1,2.0) |t|
|@> |contains range |int4range(2,4) @> int4range(2,3) |t|
|@> |contains element |'[2011-01-01,2011-03-01)'::tsrange @> '2011-01-10'::timestamp |t|
|<@ |range is contained by |int4range(2,4) <@ int4range(1,7) |t|
|<@ |element is contained by |42 <@ int4range(1,7) |f|
|&& |overlap (have points in common) |int8range(3,7) && int8range(4,12) |t|
|<< |strictly left of |int8range(1,10) << int8range(100,110) |t|
|>> |strictly right of |int8range(50,60) >> int8range(20,30) |t|
|&< |does not extend to the right of |int8range(1,20) &< int8range(18,20) |t|
|&> |does not extend to the left of |int8range(7,20) &> int8range(5,10) |t|
|-\|- |is adjacent to |numrange(1.1,2.2) -|- numrange(2.2,3.3) |t|
|+ |union |numrange(5,15) + numrange(10,20) |[5,20)|
|* |intersection |int8range(5,15) * int8range(10,20) |[10,15)|
|- |difference |int8range(5,15) - int8range(10,20) |[5,10)|

to create constraints
```
example
```



Working with time data should make more sense now that we have gone through that lobg temporal journey. 
"""" This section is under construction

```
--- put some amazing example queries here ...
SELECT * FROM currency_prices WHERE sys_period && tsrange(t1,t2, ‘[]’)


--- for rates table constraint
ALTER TABLE currency_price ADD CONSTRAINT validity_overlap EXCLUDE using GIST (currency_symbol with =, sys_period with &&);

--- bi-temporal representation allows distinguishing between natural changes and corrections.
https://tapoueh.org/blog/2018/04/postgresql-data-types-ranges/
```



"""" want to show &&, @> and <@ operators in queries, and how to setup a GIST index on range data etc

## Logical Replication

### Pre-conditions
We need to perform a few precursory steps before we can establish logical replication
so we run our docker-compose.yml with detach (-d) which will use our default [docker-compose.yml](docker-compose.yml)

```
docker-compose up -d
```

and now for convenience we use our pre-configured scripts:
* [db-fica.sql](db-fica.sql) to create the FICA (Financial Intelligence Centre Act) table in fica_db,
* [db-jibar.sql](db-jibar.sql) to create the JIBAR (Johannesburg Interbank Agreed Rate) table in jibar_db,
and populate both with historic/demo data.
* [versioning_funtion.sql](versioning_function.sql) forked from nearform/temporal_tables into git@github.com:GrindrodBank/temporal_tables.git
* [canonical_db.sql ](db-canonical.sql) for creating the various tables & triggers needed in the canonical_db

```bash
PGPASSWORD=postgres createdb -U postgres -p 9432 -h localhost fica_db
PGPASSWORD=postgres createdb -U postgres -p 8432 -h localhost jibar_db
PGPASSWORD=postgres createdb -U postgres -p 7432 -h localhost canonical_db
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db < db-fica.sql
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db < db-jibar.sql
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db < versioning_function.sql
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db < db-canonical.sql

```
We take a look at our data in jibar_db and fica_db quickly and lastly check up on our canonical_db.
```
PGPASSWORD=postgres psql -P pager off -U postgres -p 9432 -h localhost -d fica_db -c 'SELECT * FROM fica_status;'
PGPASSWORD=postgres psql -P pager off -U postgres -p 8432 -h localhost -d jibar_db -c 'SELECT * FROM jibar ORDER BY valid_from;'
PGPASSWORD=postgres psql -P pager off -U postgres -p 7432 -h localhost -d canonical_db -c '\dt'
PGPASSWORD=postgres psql -P pager off -U postgres -p 7432 -h localhost -d canonical_db -c "SELECT action_statement, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_name='versioning_trigger';"

```
### Setup Logical Replication
Logical Replication, which requires a direct database to database connection, replicates the DML commands through a mechanism of PUBLISH and SUBSCRIBE on a table by table basis.  We already have our three databases:
* fica_db which will PUBLISH fica_status table events
* jibar_db which will publish jibar table events, and
* canonical_db which will SUBSCRIBE to events from both these sources, and which will in turn trigger row level temporal record keeping for each.

We will do this manually to get a feel for what is happening.
We will start by setting the wal_level=logical and restarting each container.
```
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "SHOW wal_level;" 
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
docker container restart db-fica
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "SHOW wal_level;"

## so lets do the rest in the same way
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
docker container restart db-jibar
docker container restart db-canonical

```

Then  we setup the PUBLCATIONS and SUBSCRIPTIONS required

```SQL
--- fica_status publication
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "CREATE ROLE logical_user WITH LOGIN PASSWORD 'password' REPLICATION;"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "GRANT SELECT ON fica_status TO logical_user;"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "CREATE PUBLICATION pub_fica_status FOR TABLE fica_status;"

--- jibar publication
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db -c "CREATE ROLE logical_user WITH LOGIN PASSWORD 'password' REPLICATION;"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d jibar_db -c "GRANT SELECT ON jibar TO logical_user;"
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db -c "CREATE PUBLICATION pub_jibar FOR TABLE jibar;"

--- canonical subscription
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "CREATE SUBSCRIPTION sub_fica_status CONNECTION 'host=db-fica dbname=fica_db user=logical_user password=password port=5432' PUBLICATION pub_fica_status;"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "CREATE SUBSCRIPTION sub_jibar CONNECTION 'host=db-jibar dbname=jibar_db user=logical_user password=password port=5432' PUBLICATION pub_jibar;"

```

### Demonstrate Logical Replication with Temporal Data
```SQL
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "ALTER SUBSCRIPTION sub_fica_status DISABLE;"
--- do a transaction on the microservice
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "ALTER SUBSCRIPTION sub_fica_status ENABLE;"
--- see that it replicates and enters the history tables
```
---
#### Cleaning up Jibar data
The JSE (Johannesburg Stock Exchange) data imported for the JIBAR demo has missing rate data, so we will run a query to just take the previous row's rate and insert it into the current row if the current row's rate data is 0.000.  We run it a few time as there is more than one consecutive row with 0.000 needing replacing.  This assumes the first row is never 0.000.
```
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db                     \
-c "WITH r AS (                                                                           \
  SELECT jn.valid_from as new_valid_from, jn.rate as now_rate, jo.rate as new_rate        \
  FROM jibar jn                                                                           \
  LEFT JOIN jibar jo ON jo.valid_from + INTERVAL '1 day' = jn.valid_from                  \
  WHERE jn.rate = '0.000')                                                                \
UPDATE jibar SET rate = r.new_rate, updated_by ='system correction'                       \
FROM r                                                                                    \
WHERE valid_from = r.new_valid_from;"                                                    
```
And we can take a look at what happened:
```
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM jibar;'
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM jibar_history;'
```
References:
```
https://blog.raveland.org/post/postgresql_lr_en/
```


