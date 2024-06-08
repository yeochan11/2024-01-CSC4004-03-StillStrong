From openjdk:17-jdk
# MySQL 이미지를 기반으로 함
FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=zpalq,123098!@#
COPY init.sql /docker-entrypoint-initdb.d/

ARG JAR_FILE=build/libs/*.jar
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-jar", "app.jar"]