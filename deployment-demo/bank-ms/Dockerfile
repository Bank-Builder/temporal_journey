# Step : Build image
FROM maven:3.5.3-jdk-8-alpine as BUILD
WORKDIR /build
COPY pom.xml .
# get all the downloads out of the way
RUN mvn clean
RUN mvn dependency:go-offline -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn

COPY src/ /build/src/

RUN mvn package -Dmaven.test.skip=true

FROM boxfuse/flyway:latest-alpine AS flywayinstall
# Copy docker scripts
COPY ./docker-container-scripts/*.sh /
RUN chmod +x /*.sh


# Step : Package image
FROM openjdk:8-jre-alpine as APP

# Patch image
RUN apk update
RUN apk upgrade
RUN apk add curl 

EXPOSE 8080
COPY --from=BUILD /build/target/bank-ms.jar app.jar
COPY db/sql /sql/migrations
COPY --from=flywayinstall / /

# To reduce Tomcat startup time we added a system property pointing to "/dev/urandom" as a source of entropy.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Duser.timezone=UTC -jar /app.jar

ENTRYPOINT [ "/docker-entrypoint.sh" ]


