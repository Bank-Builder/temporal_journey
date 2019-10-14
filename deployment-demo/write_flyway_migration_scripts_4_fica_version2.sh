
echo "Moving fica files"
mv fica-ms/upgrade-version-files/C*.sql fica-ms/db/sql/canonical/
mv fica-ms/upgrade-version-files/V*.sql fica-ms/db/sql/ms/
mv fica-ms/upgrade-version-files/D*.sql fica-ms/db/sql/ms/

mv fica-ms/upgrade-version-files/api/FicaStatusController2.java fica-ms/src/main/java/za/co/temporal/journey/api/FicaStatusController2.java
mv fica-ms/upgrade-version-files/model/FicaStatus2.java fica-ms/src/main/java/za/co/temporal/journey/model/FicaStatus2.java 
mv fica-ms/upgrade-version-files/model/FicaStatusRespository2.java fica-ms/src/main/java/za/co/temporal/journey/model/FicaStatusRespository2.java
