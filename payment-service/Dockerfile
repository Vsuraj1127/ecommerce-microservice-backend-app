FROM openjdk:11
ARG PROJECT_VERSION=0.1.0

# Create application directory
RUN mkdir -p /home/app
WORKDIR /home/app

# Set the active Spring profile
ENV SPRING_PROFILES_ACTIVE dev

# Copy the JAR file directly from the target directory
ADD target/payment-service-v${PROJECT_VERSION}.jar payment-service.jar

# Expose the application port
EXPOSE 8400

# Command to run the application
ENTRYPOINT ["java", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", "-jar", "payment-service.jar"]
