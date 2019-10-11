echo "Shutdown the environment"
docker-compose down --remove-orphans

mv db/sql/canonical/C4__branch_history-table.sql   					upgrade-version-files/C4__branch_history-table.sql
mv db/sql/canonical/C6__add-afrikaans-column-to-title_history.sql   upgrade-version-files/C6__add-afrikaans-column-to-title_history.sql
mv db/sql/ms/D3__add_branch_data.sql               					upgrade-version-files/D3__add_branch_data.sql
mv db/sql/ms/D4__insert_new_banks.sql           					upgrade-version-files/D4__insert_new_banks.sql
mv db/sql/ms/D5__afrikaans-titles.sql           					upgrade-version-files/D5__afrikaans-titles.sql
mv db/sql/ms/P4__add_table_to_pub.sql              					upgrade-version-files/P4__add_table_to_pub.sql
mv db/sql/ms/V3__add_branch_table.sql             					upgrade-version-files/V3__add_branch_table.sql
mv db/sql/ms/V4__add-afrikaans-column-to-title.sql         			upgrade-version-files/V4__add-afrikaans-column-to-title.sql

mv src/main/java/za/co/temporal/journey/api/BranchController.java upgrade-version-files/api/BranchController.java
mv src/main/java/za/co/temporal/journey/model/Branch.java upgrade-version-files/model/Branch.java
mv src/main/java/za/co/temporal/journey/model/BranchRespository.java upgrade-version-files/model/BranchRespository.java