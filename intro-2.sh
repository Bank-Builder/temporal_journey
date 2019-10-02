echo "-- INTRO-2 Create the tables, and the tstzrange field we need for managing temporal data"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d db < "CREATE TABLE fica_status ( name text NOT NULL, status text NOT NULL, changed_by text NOT NULL );"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d db < "ALTER TABLE fica_status ADD COLUMN sys_period tstzrange NOT NULL DEFAULT tstzrange (current_timestamp, NULL);"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d db < "CREATE TABLE fica_status_history (LIKE fica_status);"
echo "-- Lets see what we have.."
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d db < "SELECT * from fica_status;"
PGPASSWORD=postgres psql -U postgres -p 7432 -h localhost -d db < "SELECT * FROM fica_status_history;"




