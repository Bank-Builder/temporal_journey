echo "Shutdown the environment"
docker-compose down --remove-orphans

echo "Moving files"
mv fica-ms/db/sql/canonical/C3__add_title_to_history-table.sql fica-ms/db/sql/upgrade_example/C3__add_title_to_history-table.sql 
mv fica-ms/db/sql/ms/V2__add_title_column.sql fica-ms/db/sql/upgrade_example/V2__add_title_column.sql 
mv fica-ms/db/sql/ms/D2__split_name_and_title.sql fica-ms/db/sql/upgrade_example/D2__split_name_and_title.sql