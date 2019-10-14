
echo "Moving jibar files"
# mv jibar-ms/upgrade-version-files/C*.sql jibar-ms/db/sql/canonical/
# mv jibar-ms/upgrade-version-files/V*.sql jibar-ms/db/sql/ms/
mv jibar-ms/upgrade-version-files/D*.sql jibar-ms/db/sql/ms/

docker-compose up --build -d