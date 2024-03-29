FROM maven:3.9.3-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install package -DskipTests

FROM eclipse-temurin:17.0.6_10-jre-alpine
WORKDIR /app
COPY --from=build /app/target/ecommerce-backend-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "app.jar"]