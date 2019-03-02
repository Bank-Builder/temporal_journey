# Final Word

We started this journey by taking some time to understand time, time-zones [(Getting to UTC)](getting_to_UTC.md) & understanding range data (such as used in tstzrange data), temporal tables & logical replication [(PSQL Used)](psql_used.md)

The files step-1.sh through step-5.sh will take you through the entire demonstration of setting up two faux micro-services (db's only) & a canonical db, setting up temporal_tables in the canonical db and replication publishing from the micro-services to the canonical db.  INSERT's, UPDATE's & DELETE's in the micro-service db's are replicated and a temporal history is kept via the versioning trigger in the associated history tables.


## Bi-Temporal Data
So what is meant by Temporal data, and in particular bi-temporal data?

* Temporal Data is simply data that changes over time [from-a-time, to-a-time) and the inclusive "[" and exclusive ")" notion is used by postgres.

* bi-temporal data is simple dealing with two set of temporal data - which allows us to know is “what we knew/had” and “when we knew/had it”.  One set of data for when a row was changed - we called this sys-period in our examples.  Another set of range data can be added which indicates for when the data was valid.  Change integrity and Validity are requirements for both auditing and risk management respectively in regulated industries such as the financial services industry, but it is also arguably applicable in any enterprise that relies on historical information.


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





