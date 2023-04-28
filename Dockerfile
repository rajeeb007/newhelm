FROM openjdk
WORKDIR /app
COPY target/helmnew-*.jar /app/
RUN echo "heloo world"
CMD ["java", "-jar","helmnew-1.0-SNAPSHOT.jar"]