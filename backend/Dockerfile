From openjdk:17-jdk
ARG JAR_FILE=build/libs/*.jar
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-jar", "app.jar"]