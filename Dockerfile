###
FROM amazoncorretto:18-alpine AS jre-builder
###
RUN apk add --no-cache binutils
###
WORKDIR /usr/local/bin
###
COPY /build/libs/eumira-empty-app-0.0.1-SNAPSHOT.jar .
###
RUN jar xfv eumira-empty-app-0.0.1-SNAPSHOT.jar
###
RUN jdeps \
    --ignore-missing-deps -q \
    --recursive \
    --multi-release 17 \
    --print-module-deps \
    --class-path "./BOOT-INF/lib/*" \
    --module-path "./BOOT-INF/lib/*" \
    eumira-empty-app-0.0.1-SNAPSHOT.jar > jre-deps.info
###
# build small JRE image
RUN jlink \
    --verbose \
    --add-modules $(cat jre-deps.info) \
    --strip-debug \
    --compress 2 \
    --no-header-files \
    --no-man-pages \
    --output jre
###
FROM alpine:latest
###
WORKDIR /usr/local/bin
###
COPY --from=jre-builder /usr/local/bin/jre jre
###
COPY --from=jre-builder /usr/local/bin/eumira-empty-app-0.0.1-SNAPSHOT.jar .
###
EXPOSE 8080
###
ENTRYPOINT [ "jre/bin/java", "-jar", "eumira-empty-app-0.0.1-SNAPSHOT.jar" ]