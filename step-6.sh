echo "STEP6: - lets try one approach to cleaning up the Jibar data"
remove_zeros="WITH r AS ( 
  SELECT jn.valid_from as new_valid_from, jn.rate as now_rate, jo.rate as new_rate
    FROM jibar jn LEFT JOIN jibar jo ON jo.valid_from + INTERVAL '1 day' = jn.valid_from 
    WHERE jn.rate = '0.000') 
  UPDATE jibar SET rate = r.new_rate, updated_by ='system correction' 
  FROM r WHERE valid_from = r.new_valid_from;"

echo $remove_zeros | PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db
echo $remove_zeros | PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db
echo $remove_zeros | PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db
echo $remove_zeros | PGPASSWORD=postgres psql -U postgres -p 8432 -h localhost -d jibar_db
echo ""
echo "-- SELECT * FROM jibar; in jibar_db"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 8432 -h localhost -d jibar_db -c 'SELECT * FROM jibar ORDER BY id;'

echo ""
echo "-- SELECT * FROM jibar_history; in canonical_db"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c 'SELECT * FROM jibar_history ORDER BY id;'
