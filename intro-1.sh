echo "-- INTRO-1 Create a postgres container called db using docker"
echo "-- Assumes psql client libs locally installed are same version as docker image of psql server"
echo "-- and demonstrate the basics of temporal tables"
echo "-- Press ENTER"
read enter
echo "-- Create docker instance of postgres"
docker pull postgres:10
docker run -d -p 5444:5432 --name db postgres:10
docker ps
echo "-- wait a few seconds before proceeding to allow container to start psql"
read enter
echo "-- Create a database called temporal_test to work with"
PGPASSWORD=postgres createdb -h localhost -p 5444 -U postgres temporal_test
echo ""
echo "-- Use the following to connect manually to our database: "
echo "-- -- PGPASSWORD=postgres psql -h localhost -p 5444 -U postgres temporal_test"




