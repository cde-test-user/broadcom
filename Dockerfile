FROM java:8

WORKDIR /
COPY ./target/demo-0.0.1-SNAPSHOT.jar /
EXPOSE 8080
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
