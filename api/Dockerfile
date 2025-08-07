FROM tcr.ap.toyota-asia.com/hubdocker/library/openjdk:21-slim

LABEL \
  org.opencontainers.image.title="stupid-app-api" \
  org.opencontainers.image.version="0.0.1-SNAPSHOT" \
  org.opencontainers.image.authors="stupid-app-api-team"

WORKDIR /app
COPY target/*.jar app.jar

RUN useradd -ms /bin/bash springuser
USER springuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
