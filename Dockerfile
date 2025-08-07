# Этап сборки (Maven)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# Этап запуска (Tomcat)
FROM tomcat:10.1.18-jdk17-temurin

# Удаляем ненужные приложения Tomcat
RUN rm -rf /usr/local/tomcat/webapps/manager /usr/local/tomcat/webapps/host-manager

# Копируем собранный WAR как ROOT
COPY --from=build /app/target/TestingPortal.war /usr/local/tomcat/webapps/ROOT.war