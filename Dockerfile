FROM openjdk:21-jdk
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-jar", "app.jar"]