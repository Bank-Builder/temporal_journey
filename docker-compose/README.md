# Docker Compose example
This shows a deployment example of the theory ..  

# Pre-requisites
This example uses:
- [docker](https://www.docker.com)
- [docker-compose](https://docs.docker.com/compose/)
- [curl](https://github.com/curl/curl) (a handy command line client to do HTTP requests) 
- [jq](https://stedolan.github.io/jq/) (a nice command line JSON processor)

# Steps
From the `docker-compose` folder: 

- Spin up the environment using:
```bash
docker-compose up --build -d
```
- Wait a little, whilst each of the containers within the environment start up
- Check if the API is up by running: 
```bash
curl localhost:8181/actuator/health | jq '.'
```
ensure that you get a valid up status as below before continuing
```json
{
  "status": "UP"
}
```

- Call the API to see all fica-status data: 
```bash
curl localhost:8181/fica/v1 | jq '.'
```
- Query the canonical DB tables (*NOTICE:* we have rows in the fica_status table, and nothing in fica_status_history table yet.)
```bash
./query_canonical_db.sh
```
- Use the API to add a new fica-status record: 
```bash
curl -X POST localhost:8181/fica/v1 -H "Content-type:application/json" -d "{\"name\":\"miss thrifty\",\"status\":\"non-compliant\",\"changedBy\":\"rest api call\"}" | jq '.'
```
- Query the canonical DB again (This time *NOTICE:* we have a new row (id 4) in the fica_status table, and nothing in fica_status_history table yet.)
```bash
./query_canonical_db.sh
```
- Use the API to update the fica-status of record 4: 
```bash
curl -X PUT localhost:8181/fica/v1/4 -H "Content-type:application/json" -d "{\"name\":\"miss thrifty\",\"status\":\"compliant\",\"changedBy\":\"rest api call2\"}" | jq '.'
```
- Query the canonical DB again (This time *NOTICE:* fica_status (id 4) is now compliant, and change_by updated, we also have a record of this change in the history.)
```bash
./query_canonical_db.sh
```

# Now lets do a DB change via flyway to add a title column and then migrate the data to align. 
We have scripts .. 
- Move these scripts into the correct location by running
```bash
./write_flyway_migration_scripts_for_version2.sh
```
- Deploy new version of the API (and run its flyway migration scripts to its DB and Canonical DB):
```bash
docker-compose up --build -d
```
- Query the canonical DB again 
-- This time *NOTICE:* we have a new column title on both fica_status and fica_status_history
-- the data in fica_status has been updated to split out title from name column
-- and fica_status_history has recorded that each of the names used to include title, and title was default value assigned to fica_status column when adding the column via ALTER table
```bash
./query_canonical_db.sh
```

# We can now use version2 of the API to run through simlar steps and see the audit tables functioning as expected
- Call the API to see all fica-status data: 
```bash
curl localhost:8181/fica/v2 | jq '.'
```
- Use the API to add a new fica-status record: 
```bash
curl -X POST localhost:8181/fica/v2 -H "Content-type:application/json" -d "{\"title\":\"mrs\",\"name\":\"economical\",\"status\":\"non-compliant\",\"changedBy\":\"rest api call\"}" | jq '.'
```
- Query the canonical DB again (This time *NOTICE:* we have a new row (id 4) in the fica_status table, and nothing in fica_status_history table yet.)
```bash
./query_canonical_db.sh
```
- Use the API to update the fica-status of record 4: 
```bash
curl -X PUT localhost:8181/fica/v2/5 -H "Content-type:application/json" -d "{\"title\":\"dr\",\"name\":\"economical\",\"status\":\"compliant\",\"changedBy\":\"rest api call2\"}" | jq '.'
```
- Query the canonical DB again (This time *NOTICE:* fica_status (id 4) is now compliant, and change_by updated, we also have a record of this change in the history.)
```bash
./query_canonical_db.sh
```
- For good measure you can run deletes via the API to check audit of delete is in place
```bash
curl -X DELETE localhost:8181/fica/v1/4
curl -X DELETE localhost:8181/fica/v2/5
```
- Query the canonical DB again (This time *NOTICE:* fica_status (id 4) is now compliant, and change_by updated, we also have a record of this change in the history.)
```bash
./query_canonical_db.sh
```

# Lastly stop and run the clean up scripts to put this demo back in its original state
```bash
./stop-cleanup-demo.sh
```

You can also use docker compose command (there will be some files used in above demo out of place)
```bash
docker-compose down --remove-orphans
```

# References
- https://www.onwerk.de/2019/06/07/automatic-database-schema-upgrading-in-dockerized-projects/
- https://pgdash.io/blog/postgres-replication-gotchas.html



docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT action_statement, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_name='fica_status_versioning_trigger';'


