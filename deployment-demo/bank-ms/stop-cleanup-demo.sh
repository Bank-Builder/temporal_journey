echo "Shutdown the environment"
docker-compose down --remove-orphans

mv db/sql/canonical/C3__branch_history-table.sql upgrade-version-files/C3__branch_history-table.sql
mv db/sql/ms/V2__add_branch_table.sql upgrade-version-files/V2__add_branch_table.sql
mv db/sql/ms/D2__insert_new_banks.sql upgrade-version-files/D2__insert_new_banks.sql
mv db/sql/ms/D3__add_branch_data.sql upgrade-version-files/D3__add_branch_data.sql
mv db/sql/ms/P2__add_table_to_pub.sql upgrade-version-files/P2__add_table_to_pub.sql
mv src/main/java/za/co/temporal/journey/api/BranchController.java upgrade-version-files/api/BranchController.java
mv src/main/java/za/co/temporal/journey/model/Branch.java upgrade-version-files/model/Branch.java
mv src/main/java/za/co/temporal/journey/model/BranchRespository.java upgrade-version-files/model/BranchRespository.java