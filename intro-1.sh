echo "-- INTRO-1 Create the a database using docker"
echo "-- Assumes psql client libs locally installed - no local postgres server required"
echo "-- and demonstrate the basics of temporal tables"
echo "-- "
read enter
echo "-- Create docker instance of postgres"
docker pull postgres
docker run -d -p 5444:5432 --name db postgres
docker ps
echo "-- Create a database schema called temporal_test to work with"
PGPASSWORD=postgres createdb -h localhost -p 5444 -U postgres temporal_test
echo "-- That is the setup"
echo "-- Use the following to connect manually t our schema: "
echo "-- -- PGPASSWORD=postgres psql -h localhost -p 5444 -U postgres temporal_test"




