echo "-- INTRO-2 Create the tables, and the tstzrange field we need for managing temporal data"
echo " -- CREATE TABLE fica_status"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "CREATE TABLE fica_status ( name text NOT NULL, status text NOT NULL, changed_by text NOT NULL );"
echo " -- ADD COLUMN sys_period"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "ALTER TABLE fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);"
echo "-- CREATE TABLE fica_status_history"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "CREATE TABLE fica_status_history (LIKE fica_status);"
echo ""
echo "-- SELECT * from fica_status;"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT * from fica_status;"
echo "-- SELECT * FROM fica_status_history;"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT * FROM fica_status_history;"




