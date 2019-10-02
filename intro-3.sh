echo "Add the versioning_function, the history trigger on update & delete and see what what we have"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test < versioning_function.sql
echo "-- use SELECT pg_get_functiondef('versioning'::regproc) if you wish take a look at versioning_function"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "CREATE TRIGGER versioning_trigger
BEFORE UPDATE OR DELETE ON fica_status FOR EACH ROW EXECUTE PROCEDURE versioning('sys_period', 'fica_status_history', true);"
echo ""
echo "SELECT * FROM information_schema.triggers"
PGPASSWORD=postgres psql -U postgres -p 5444 -h localhost -d temporal_test -c "SELECT action_statement, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_name='versioning_trigger';"

