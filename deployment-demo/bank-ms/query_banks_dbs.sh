echo "Querying the '_bank.bank' table on bank DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _bank.bank;'

echo "Querying the '_bank.branches' table on bank DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c 'SELECT * FROM _bank.branches;'

echo "Querying the '_bank.bank_history' table on bank DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c ' select * from _bank.bank_history;'

echo "Querying the '_bank.branches_history' table on bank DB"
docker exec -it db-bank psql -P pager=off  -h db-canonical -U postgres -p 5432 -d canonical_db -c ' select * from _bank.branches_history;'