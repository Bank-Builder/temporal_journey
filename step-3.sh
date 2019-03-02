echo "STEP 3: Alter the Write-Ahead-Log settings for Logical Replication"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "SHOW wal_level;" 
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
sleep 1
docker container restart db-fica
sleep 2
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -c "SHOW wal_level;"

## so lets do the rest in the same way
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -c "ALTER SYSTEM SET wal_level = 'logical';"
sleep 2
docker container restart db-jibar
docker container restart db-canonical

