echo "Querying the '_reference.title' table on canonical DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _reference.title;'

echo "Querying the '_reference.title_history' table on canonical DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c ' select * from _reference.title_history;'