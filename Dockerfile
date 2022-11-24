FROM maven:3.8.6-openjdk-18 AS builder
WORKDIR /tmp
COPY ./src ./src
COPY ./pom.xml .
RUN mvn package
FROM openjdk:18.0.1.1-jdk
COPY --from=builder /tmp/target/app.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
#ENV MAVEN_ALLOW_SUPERUSER 1
#ENV MAVEN_HOME /maven
#ENV PATH $PATH:/maven/vendor/bin