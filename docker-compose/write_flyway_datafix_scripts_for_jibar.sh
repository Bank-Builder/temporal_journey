
echo "Moving jibar files"
# mv jibar-ms/db/sql/upgrade_example/C*.sql jibar-ms/db/sql/canonical/
# mv jibar-ms/db/sql/upgrade_example/V*.sql jibar-ms/db/sql/ms/
mv jibar-ms/db/sql/upgrade_example/D*.sql jibar-ms/db/sql/ms/

docker-compose up --build -d