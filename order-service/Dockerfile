FROM openjdk:11
ARG PROJECT_VERSION=0.1.0

# Create application directory
RUN mkdir -p /home/app
WORKDIR /home/app

# Set active Spring profile
ENV SPRING_PROFILES_ACTIVE dev

# Copy the JAR file directly from the target directory
ADD target/order-service-v${PROJECT_VERSION}.jar order-service.jar

# Expose the application port
EXPOSE 8300

# Command to run the application
ENTRYPOINT ["java", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", "-jar", "order-service.jar"]
