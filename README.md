# Temporal Journey
This journey into (& through) time is an exploration of time range data (& other important side-tracks) with the intention to make dealing with history tables easy in a scenario where developers each working on their own micro-service (each with it's own postgresql database) replicating (via event bus or logical dB replication) back to an eventually consistent canonical database (we assume each micro-service has it's own schema(s) ).  The desired solution would allow for history tables to be automatically dealt with in the canonical database through temporal_tables &amp; database plugins and trigger magic.

Something like this:

![Micro-Services Logical Replication](/images/micro-services_logical_replication.png)

Micro-service developers have enough on their plate as it is than to have to worry about how they are going to manage temporal data, and this problem is made even more complex in that what most regulated environments require is actually bi-temporal data (validity & change history) to comply with Regulator demands for immutable records of transactions, whilst business needs the ability to make corrections even to historic "immutable" data.

Thus the journey depicted in the graphic:

![Temporal Journey](/images/temporal_journey.png)

- [Getting to UTC](getting_to_UTC.md)
- [PSQL Used](psql_used.md)


and just in case ...
- [Tools Used](tools_used.md)

[Final Word](final_word.md)

The end of this journey, is just the beginning of another for others, for .e.g. to look into large temporal table problems with database sharding, or using external tables to distribute the data etc.

---
**Temporal Journey, Copyright &copy; 2019, Bank-Builder**

Temporal Journey is licensed under a [Creative Commons Attribution 3.0](http://creativecommons.org/licenses/by/3.0/) Unported License.

---
