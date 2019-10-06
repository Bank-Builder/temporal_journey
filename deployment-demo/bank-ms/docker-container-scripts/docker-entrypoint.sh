#!/bin/sh

# fail on first error
set -e

echo "========================================================================="
echo " Flyway Migrations First  "
echo "========================================================================="
echo ""

echo "> Wait for database on $DATABASE_SERVER to be ready..."
/wait-for.sh $DATABASE_SERVER:5432
/wait-for.sh $CANONICAL_DB_SERVER:5432
echo "> Done waiting..."

echo "> Creating flyway config file..."

cd /flyway/conf/
touch microservicedb.conf && rm microservicedb.conf && touch microservicedb.conf
echo "flyway.url=jdbc:postgresql://$DATABASE_SERVER:5432/bank_db" >> microservicedb.conf
echo "flyway.user=$FLYWAY_USER" >> microservicedb.conf
echo "flyway.password=$FLYWAY_PASSWORD" >> microservicedb.conf
echo "flyway.baselineOnMigrate=true" >> microservicedb.conf
echo "flyway.baselineVersion=0" >> microservicedb.conf
echo "flyway.connectRetries=60" >> microservicedb.conf
echo "flyway.locations=filesystem:/sql/migrations/ms" >> microservicedb.conf
echo "flyway.schemas=_flyway" >> microservicedb.conf

touch canonicaldb.conf && rm canonicaldb.conf && touch canonicaldb.conf
echo "flyway.url=jdbc:postgresql://$CANONICAL_DB_SERVER:5432/canonical_db" >> canonicaldb.conf
echo "flyway.user=$FLYWAY_USER" >> canonicaldb.conf
echo "flyway.password=$FLYWAY_PASSWORD" >> canonicaldb.conf
echo "flyway.baselineOnMigrate=true" >> canonicaldb.conf
echo "flyway.baselineVersion=0" >> canonicaldb.conf
echo "flyway.connectRetries=60" >> canonicaldb.conf
echo "flyway.schemas=_flyway" >> canonicaldb.conf

echo "========================================================================="
echo " V__ to micro-service  "
echo "========================================================================="
flyway -configFiles=microservicedb.conf -table=bank_schema_versions -sqlMigrationPrefix=V migrate
echo "========================================================================="
echo " P__ to micro-service  "
echo "========================================================================="
flyway -configFiles=microservicedb.conf -table=bank_publications_versions -sqlMigrationPrefix=P migrate
                                         
echo "========================================================================="
echo " V__ to canonical  "
echo "========================================================================="
flyway -configFiles=canonicaldb.conf    -table=bank_schema_versions -sqlMigrationPrefix=V -locations=filesystem:/sql/migrations/ms migrate
echo "========================================================================="
echo " C__ to canonical  "
echo "========================================================================="
flyway -configFiles=canonicaldb.conf    -table=bank_canonial_versions -sqlMigrationPrefix=C -locations=filesystem:/sql/migrations/canonical migrate

sleep 5

echo "========================================================================="
echo " D__ to micro-service  "
echo "========================================================================="
                                         
flyway -configFiles=microservicedb.conf -table=bank_data_versions -sqlMigrationPrefix=D migrate

echo "========================================================================="
echo ""
echo " start app  "
echo ""
echo "========================================================================="
echo ""

java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Duser.timezone=UTC -jar /app.jar

