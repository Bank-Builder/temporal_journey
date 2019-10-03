echo "Querying the '_fica.fica_status' table on canonical DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _fica.fica_status;'

echo "Querying the '_fica.fica_status_history' table on canonical DB"
docker run --rm -it --network=dockercompose_default postgres:10-alpine psql -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _fica.fica_status_history;'
