
# This example shows how
We can add a table
- reason this works is that on the canonical DB we always runing the `afterMigrate__refresh_subscription.sql` which runs SQL `ALTER SUBSCRIPTION bank_db REFRESH PUBLICATION;`

# Steps to run this example, from bank-ms folder
Initial application with just one table `_bank.bank`
```bash
docker-compose up --build -d
```

Create a new version with branches table  `_bank.branches`
```bash
./write_flyway_add_table_scripts_for_bank.sh
```

See whats happening on the canonial db
```bash
./query_banks_dbs.sh 
```

Run some updates against the bacnhes table
```bash
curl -X PUT localhost:8183/branches/2 -H "Content-type:application/json" -d "{\"bankId\":\"2\",\"name\":\"ABSA 3\",\"code\":\"wrong-again-321\",\"updatedBy\":\"rest api call 1\"}" | jq '.'
curl -X PUT localhost:8183/branches/2 -H "Content-type:application/json" -d "{\"bankId\":\"2\",\"name\":\"ABSA 3\",\"code\":\"321\",\"updatedBy\":\"rest api call 2\"}" | jq '.'
```