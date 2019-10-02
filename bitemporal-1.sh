echo "-- BI-TEMPORAL-1 Create a postgres container called bitemporal using docker"
echo "-- Press ENTER"
read enter
echo "-- Create docker instance of postgres"
docker pull postgres:10
docker run -d -p 5443:5432 --name bitemporal postgres:10
docker ps
echo "-- wait a few seconds before proceeding to allow container to start psql"
echo "-- Press ENTER"
read enter
echo "-- Create a database called temporal_test to work with"
PGPASSWORD=postgres createdb -h localhost -p 5443 -U postgres bitemporal
echo "-- Add the original Jibar data, notice the zero rows"
PGPASSWORD=postgres psql -U postgres -p 5443 -h localhost -d bitemporal < db-jibar.sql
echo "-- we remove the rows with zero as a rate value"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "DELETE FROM jibar WHERE rate = '0.000';"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c 'SELECT * FROM jibar ORDER BY valid_from;'
echo ""
echo "-- Now we can convert this into bi-temporal data"
echo "-- Press ENTER"
read enter

echo "-- we want to use the gist index type"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "CREATE EXTENSION btree_gist;"

echo "-- we need to alter our table to be bi-temporal in structure"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "ALTER TABLE jibar ADD COLUMN validity_period daterange;"

PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "ALTER TABLE jibar ADD CONSTRAINT no_overlap EXCLUDE USING gist  (validity_period WITH && );"



echo "-- we now create a range by using the valid_from date till the next non-missing row by date"
echo "Press ENTER"
read enter
validity_range="SELECT id, rate, daterange(valid_from::DATE, lead (valid_from::DATE) 
         OVER (PARTITION BY 'jibar' ORDER BY valid_from) , '[)' ) FROM jibar;"
echo $validity_range | PGPASSWORD=postgres psql -U postgres -p 5443 -h localhost -d bitemporal  

echo "-- and we need into insert this into out validity_range field we added"
echo "Press ENTER"
read enter
validity_data="WITH r AS (
    SELECT id, rate, daterange(valid_from::DATE, lead (valid_from::DATE) 
    OVER (PARTITION BY 'jibar' ORDER BY valid_from) , '[)' ) AS validity_period FROM jibar
    )                                                                    
UPDATE jibar SET validity_period = r.validity_period 
FROM r WHERE jibar.id = r.id ;"
echo $validity_data
echo $validity_data | PGPASSWORD=postgres psql -U postgres -p 5443 -h localhost -d bitemporal  
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "SELECT * FROM jibar ORDER BY valid_from;"


echo "-- we nolonger need the valid_from column so we drop it"
echo "Press ENTER"
read enter
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "ALTER TABLE jibar DROP COLUMN valid_from;"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 5443 -h localhost -d bitemporal -c "SELECT * FROM jibar ORDER BY validity_period;"


echo "-- Use the following to connect manually to our database: "
echo "-- -- PGPASSWORD=postgres psql -h localhost -p 5443 -U postgres bitemporal"

