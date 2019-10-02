echo "STEP2: ..."
echo "'SELECT * FROM fica_status;'"
PGPASSWORD=postgres psql -U postgres -p 9432 -h localhost -d fica_db -c 'SELECT * FROM fica_status;'
echo "'SELECT * FROM jibar ORDER BY valid_from;'"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 8432 -h localhost -d jibar_db -c 'SELECT * FROM jibar ORDER BY valid_from;'
echo "'\dt'"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c '\dt'
echo "Show what is in information_schema.triggers"
PGPASSWORD=postgres psql -P pager=off -U postgres -p 7432 -h localhost -d canonical_db -c "SELECT action_statement, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_name='versioning_trigger';"

