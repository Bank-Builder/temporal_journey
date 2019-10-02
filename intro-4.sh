clear
echo "-- Now let us add some data to start with"
add_data="INSERT INTO fica_status (name, status, changed_by) VALUES ('mr big', 'non-compliant', 'vanessa'),('mr cool', 'frozen', 'tracy'), ('mr frugal', 'compliant', 'betty');"

echo $add_data | PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT * from fica_status;"

echo "-- Make some changes to the fica_status data"
change1="UPDATE fica_status SET status = 'compliant', changed_by = 'leona' WHERE name = 'mr big';"
change2="UPDATE fica_status SET status = 'expired', changed_by = 'kim' WHERE name = 'mr cool';"
delete1="DELETE FROM fica_status WHERE name = 'mr frugal';"

echo $change1 | PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test
echo $change2 | PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test
echo $delete1 | PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test

echo "-- See what changed in fica_status_history"
echo "-- SELECT * from fica_status;"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT * from fica_status;"
echo "-- SELECT * FROM fica_status_history;"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT * FROM fica_status_history;"

echo "-- To see what was deleted left join fica_status ON fica_status_history"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT DISTINCT fsh.name AS deleted FROM fica_status_history fsh LEFT JOIN fica_status fs ON fs.name=fsh.name WHERE fs.name IS NULL;"


