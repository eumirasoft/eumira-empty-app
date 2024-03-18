###
FROM openjdk:17

LABEL Author="Gerardo Jaramillo"

WORKDIR /usr/local/bin

COPY ./build/libs/*.jar .

EXPOSE 8080

CMD [ "java", "-jar", "eumira-empty-app-0.0.1-SNAPSHOT.jar" ]

