###
FROM gradle:8.0.0-jdk17-alpine AS jdk-builder
WORKDIR /usr/local/bin
COPY . .
RUN gradle clean --refresh-dependencies build
FROM openjdk:17-jdk-alpine

COPY --from=jdk-builder /usr/local/bin/build/libs/eumira-empty-app-0.0.1-SNAPSHOT.jar eumira-empty-app-0.0.1-SNAPSHOT.jar
EXPOSE 8080

CMD [ "java", "-jar", "eumira-empty-app-0.0.1-SNAPSHOT.jar" ]

