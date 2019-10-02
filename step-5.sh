clear
echo "STEP 5: Take a look at what happens when we change data"
echo "-- SELECT * FROM fica_status"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM fica_status;'
echo "-- SELECT * FROM fica_status_history"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM fica_status_history;'
echo ""
echo "-- Change some data in the fica_db.fica_status table"
echo "-- UPDATE fica_status SET status = 'compliant', changed_by = 'leona' WHERE name = 'mr big'"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 9432 -h localhost -d fica_db -c "UPDATE fica_status SET status = 'compliant', changed_by = 'leona' WHERE name = 'mr big';"

#PGPASSWORD=postgres psql -P pager=off -U postgres -p 9432 -h localhost -d fica_db -c 'SELECT * FROM fica_status;'
#echo "look at the canonical db"
#PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM fica_status;'
echo "-- In the canonical_db"
echo "-- SELECT * FROM fica_status_history"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM fica_status_history;'
echo "-- Press ENTER"
read enter
clear


#PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM jibar;'
echo "-- And the changes made in jibar_db are reflected in the canonical_db"
echo "-- SELECT * FROM jibar_history"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM jibar_history;'
echo "-- Press ENTER"
read enter
clear

echo "-- For interest sake take alook at how jibar is defined in each database"
echo "-- jibar_db:jibar"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 8432 -h localhost -d jibar_db -c '\d jibar;'
echo ""
echo "-- canonical:jibar"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c '\d jibar;'

