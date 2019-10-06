
echo "Moving bank files"
mv upgrade-version-files/C*.sql db/sql/canonical/
mv upgrade-version-files/P*.sql db/sql/ms/
mv upgrade-version-files/V*.sql db/sql/ms/
mv upgrade-version-files/D*.sql db/sql/ms/

mv upgrade-version-files/api/BranchController.java src/main/java/za/co/temporal/journey/api/BranchController.java
mv upgrade-version-files/model/Branch.java src/main/java/za/co/temporal/journey/model/Branch.java 
mv upgrade-version-files/model/BranchRespository.java src/main/java/za/co/temporal/journey/model/BranchRespository.java


docker-compose up --build -d