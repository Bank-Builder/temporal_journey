echo "STEP 1: Create the three databases and populate the schemas"
PGPASSWORD=postgres createdb -U postgres -p 9432 -h localhost fica_db
PGPASSWORD=postgres createdb -U postgres -p 8432 -h localhost jibar_db
PGPASSWORD=postgres createdb -U postgres -p 7432 -h localhost canonical_db
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db < db-fica.sql
PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db < db-jibar.sql
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db < versioning_function.sql
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d canonical_db < db-canonical.sql
