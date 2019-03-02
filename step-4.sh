echo "STEP 4: Publish and Subscribe for Logical Replication"
# fica_status publication
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "CREATE ROLE logical_user WITH LOGIN PASSWORD 'password' REPLICATION;"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "GRANT SELECT ON fica_status TO logical_user;"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c "CREATE PUBLICATION pub_fica_status FOR TABLE fica_status;"

# jibar publication
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db -c "CREATE ROLE logical_user WITH LOGIN PASSWORD 'password' REPLICATION;"
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db -c "GRANT SELECT ON jibar TO logical_user;"
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db -c "CREATE PUBLICATION pub_jibar FOR TABLE jibar;"

# canonical subscription
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "CREATE SUBSCRIPTION sub_fica_status CONNECTION 'host=db-fica dbname=fica_db user=logical_user password=password port=5432' PUBLICATION pub_fica_status;"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db -c "CREATE SUBSCRIPTION sub_jibar CONNECTION 'host=db-jibar dbname=jibar_db user=logical_user password=password port=5432' PUBLICATION pub_jibar;"

