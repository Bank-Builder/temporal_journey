echo "-- So we may query this type of date as follows..."

echo "-- SELECT rate from jibar WHERE validity_period @> date '20190202';"
echo "Press ENTER"
read enter
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "SELECT * from jibar WHERE validity_period @> date '20190202';"

echo "-- SELECT * FROM jibar WHERE validity_period && daterange('2019-02-03','2019-02-07', '[)');"
echo "Press ENTER"
read enter
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "SELECT * FROM jibar WHERE validity_period && daterange('2019-02-03','2019-02-07', '[)');"

echo "-- last, a few more the road"
echo "SELECT * FROM jibar WHERE validity_period -|- daterange('2019-02-03','2019-02-07', '[)');"
echo "SELECT * FROM jibar WHERE validity_period >> daterange('2019-02-03','2019-02-07', '[)');"
echo "SELECT * FROM jibar WHERE validity_period &< daterange('2019-02-03','2019-02-07', '[)');"
