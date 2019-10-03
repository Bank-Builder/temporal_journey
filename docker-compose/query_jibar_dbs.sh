echo "Querying the '_jibar.jibar' table on jibar_db DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-jibar -U postgres -p 5432 -d jibar_db -c 'SELECT * FROM _jibar.jibar;'

echo "Querying the '_jibar.jibar' table on canonical DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _jibar.jibar;'

echo "Querying the '_jibar.jibar_history' table on jibar_db DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-jibar -U postgres -p 5432 -d jibar_db -c 'SELECT * FROM _jibar.jibar_history;'

echo "Querying the '_jibar.jibar_history' table on canonical DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _jibar.jibar_history;'
