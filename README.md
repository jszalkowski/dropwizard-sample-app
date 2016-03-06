# Sample App

A sample application built with [Dropwizard.io](http://dropwizard.io)

Requirements for run this app:

* Java 7
* Maven 3.2.x

## How to run unit tests

```
mvn test
```

## How to run integration tests

MySQL database setup (with Docker):

```
docker run --name=test_db -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql
docker exec test_db mysql -u root -proot -e "create database db_notes_test;"
```

Run migrations:

```
mvn package
java -jar target/sample-app-1.0-SNAPSHOT.jar db migrate src/test/resources/configuration-integration-test.yml
```

Run integration-test:

```
mvn mvn failsafe:integration-test
```

## Run the application

Create the package

```
mvn package
```

MySQL database setup (with Docker):

```
docker run --name=test_db -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql
docker exec test_db mysql -u root -proot -e "create database db_notes;"
```

Run migrations:

```
mvn package
java -jar target/sample-app-1.0-SNAPSHOT.jar db migrate configuration.yml
```

Run application:

```
java -jar target/sample-app-1.0-SNAPSHOT.jar server configuration.yml
```

## Do some calls

```
curl -X POST http://localhost:8080/notes --data "Hello world"
curl -X POST http://localhost:8080/notes --data "This is a sample application"
curl http://127.0.0.1:8080/notes/
curl http://127.0.0.1:8080/notes/1
curl http://127.0.0.1:8080/notes/2
```
