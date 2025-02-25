FROM public.ecr.aws/docker/library/openjdk:17.0-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy the application JAR file
COPY target/spring-boot-web.jar app.jar

# Expose the application's port
EXPOSE 80

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
