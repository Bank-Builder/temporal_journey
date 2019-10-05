
echo "Moving bank files"
mv upgrade-version-files/C*.sql db/sql/canonical/
mv upgrade-version-files/P*.sql db/sql/ms/
mv upgrade-version-files/V*.sql db/sql/ms/
mv upgrade-version-files/D*.sql db/sql/ms/

docker-compose up --build -d