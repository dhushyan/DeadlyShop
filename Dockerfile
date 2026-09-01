FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/DeadlyShop.war /usr/local/tomcat/webapps/DeadlyShop.war

EXPOSE 8080

CMD ["catalina.sh", "run"]