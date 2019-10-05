echo "Shutdown the environment"
docker-compose down --remove-orphans

mv db/sql/canonical/C3__branches_history-table.sql upgrade-version-files/C3__branches_history-table.sql
mv db/sql/ms/V2__add_branches_table.sql upgrade-version-files/V2__add_branches_table.sql
mv db/sql/ms/D2__add_branches_data.sql upgrade-version-files/D2__add_branches_data.sql
mv db/sql/ms/P2__add_table_to_pub.sql upgrade-version-files/P2__add_table_to_pub.sql
