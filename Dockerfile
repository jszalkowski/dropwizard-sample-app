FROM joebew42/openjdk8-jre-tiller

COPY target/sample-app-1.0-SNAPSHOT.jar /app
WORKDIR /app

EXPOSE 8080