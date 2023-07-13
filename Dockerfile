# Use a base image with Java and Maven pre-installed
FROM maven:3.9.3-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application
RUN mvn package

# Use a lightweight base image for the final image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/Lab2-Q3_DevOps.jar .

# Expose the port your web application listens on
EXPOSE 8080

# Define the command to run your application
CMD ["java", "-jar", "Lab2-Q3_DevOps.jar"]