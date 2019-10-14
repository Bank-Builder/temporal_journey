echo "Shutdown the environment"
docker-compose down --remove-orphans

echo "Moving files"
mv fica-ms/db/sql/canonical/C3__add_title_to_history-table.sql fica-ms/upgrade-version-files/C3__add_title_to_history-table.sql 
mv fica-ms/db/sql/ms/V2__add_title_column.sql fica-ms/upgrade-version-files/V2__add_title_column.sql 
mv fica-ms/db/sql/ms/D2__split_name_and_title.sql fica-ms/upgrade-version-files/D2__split_name_and_title.sql
mv fica-ms/src/main/java/za/co/temporal/journey/api/FicaStatusController2.java fica-ms/upgrade-version-files/api/FicaStatusController2.java
mv fica-ms/src/main/java/za/co/temporal/journey/model/FicaStatus2.java fica-ms/upgrade-version-files/model/FicaStatus2.java
mv fica-ms/src/main/java/za/co/temporal/journey/model/FicaStatusRespository2.java fica-ms/upgrade-version-files/model/FicaStatusRespository2.java

mv jibar-ms/db/sql/ms/D2__update_jibar_rates.sql jibar-ms/upgrade-version-files/D2__update_jibar_rates.sql
