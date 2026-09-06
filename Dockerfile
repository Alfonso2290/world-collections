# ----- Etapa 1: Build -----
FROM maven:3.9.6-eclipse-temurin-17-focal AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -B -e dependency:go-offline

COPY src ./src
RUN mvn -B -e clean package -DskipTests

# ----- Etapa 2: Runtime (Tomcat) -----
FROM tomcat:9.0-jdk17-corretto

# Elimina la aplicación ROOT por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el WAR generado a Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat escucha en 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]