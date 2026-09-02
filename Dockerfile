# Stage 1: Build the application
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/DeadlyShop.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8080" protocol="HTTP\/1.1"/port="10000" protocol="HTTP\/1.1"/' /usr/local/tomcat/conf/server.xml

EXPOSE 10000


CMD ["catalina.sh", "run"]
