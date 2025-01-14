#
# Build stage
#
FROM maven:3.8.7-eclipse-temurin-17-alpine AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.skip=true

#
# Package stage
#
FROM openjdk:17-slim-buster
COPY --from=build /home/app/target/k-curry-jib-customer-0.0.1-SNAPSHOT.jar /usr/local/lib/k-curry-jib-customer.jar
EXPOSE 8889
ENTRYPOINT ["java", "-Dspring.profiles.active=docker","-jar","/usr/local/lib/k-curry-jib-customer.jar"]