# APIs Testing

APIs Testing will use Postman for write test scripts and run via [newman](https://www.npmjs.com/package/newman)

## Table of Contents

- [APIs Testing](#apis-testing)
  - [Table of Contents](#table-of-contents)
  - [Structures](#structures)
  - [Initial Database](#initial-database)
  - [Migration](#migration)
  - [Mountebank](#mountebank)
  - [Postman](#postman)
    - [Naming Rules](#naming-rules)
    - [How does entrypoint work?](#how-does-entrypoint-work)
    - [Newman \& HTML reporter](#newman--html-reporter)
  - [Docker](#docker)
    - [via Docker](#via-docker)
    - [via Makefile](#via-makefile)
  - [Database Admin](#database-admin)
  - [Step to arange data before run test](#step-to-arange-data-before-run-test)

---

## Structures

    ./root
      └──./api-testing
            ├── initial-db                   # Initial Database
            ├── migration                    # Database Migration
            ├── mountebank                   # Mocking 3rd Party
            ├── postman                      # APIs Testing Script
            ├── .env.test
            ├── docker-compose.yml
            ├── Makefile
            └── README.md

---

## Initial Database

Initial database is restore database

---

## Migration

Edit data in database

---

## Mountebank

Create Mocking Services for 3rd Party

---

## Postman

Store the postman collection and environment

    ./postman
      ├── collections         # Postman Collections (Test Scenarios)
      ├── data                # Postman Data for Iteration
      ├── environments        # Postman Envitonments
      ├── files               # Storage Files for Test (Ex. image, pdf etc.)
      ├── reports             # Reports after run Test
      ├── Dockerfile
      └── entrypoint.sh       # newman command

### Naming Rules

In this postman folder Name Naming rules for Collections, Data, Environments:

***Collection***
Collection must contain this word. (.postman_collection.json) is a component after the file name

```Text
NAME.postman_collection.json
```

***Data***
Data must contain this word. (.postman_data.json) is a component after the file name

```Text
NAME.postman_data.json
```

***Environment***
Environment must contain this word. (.postman_environment.json) is a component after the file name

```Text
NAME.postman_environment.json
```

If you want to use the Postman Data file for recursive testing, name it the same as the Collection file. Docker will automatically call that file for you.

Example.

```Text
  Collection: create_learner.postman_collection.json
  Data: create_learner.postman_data.json
  
  # if you want to use environment
  Enviroment: create_learner.postman_environment.json
```

If you want to use an Environment file for testing, name it the same as a Collection file. Docker will automatically call that file. If there is no Environment file, it will use the default file (default.postman_environment.json).

### How does entrypoint work?

to run the test, use Newman to command Run the test by writing the command at entrypoint.sh

Step:

```Text
1. Find Test Scenarios in the collections folder.
2. Find Data in the data folder.
    1. If available, data will be retrieved from that data file
3. Find Environment in the environments folder.
    1. If available, data from that Collection file will be used.
    2. If not available, data from the file will be used. default.postman_environment.json instead
```

### Newman & HTML reporter

[Newman](https://www.npmjs.com/package/newman) is a command-line collection runner for Postman. It allows you to effortlessly run and test a Postman collection directly from the command-line. It is built with extensibility in mind so that you can easily integrate it with your continuous integration servers and build systems.

A [Newman HTML reporter](https://www.npmjs.com/package/newman-reporter-htmlextra) that has been extended to include the separation of the iteration runs so these are no longer aggregated together and also some additional handlebars helpers to enable users to create better custom templates.

This reporter comes with a dashboard style summary landing page and a set of different tabs which contain the detailed request information. There are also a few optional configuration flags available, to tailor the final report in a number of different ways.

install [NodeJS](https://nodejs.org/en) before install newman and newman-reporter-htmlextra

Install newman

```bash
npm install -g newman
```

Install newman-reporter-htmlextra

```
npm install -g newman-reporter-htmlextra
```

Basic Run newman

```bash
  newman run ./api-testing/postman/collections/[Collection File] -e ./api-testing/postman/environments/[environment File] -r htmlextra
```

Run newman with data

```bash
  newman run ./api-testing/postman/collections/[Collection File] -e ./api-testing/postman/environments/[environment File] -d ./api-testing/postman/data/[data File] -r htmlextra
```

---

## Docker

You can use Docker Compose in two ways:

### via Docker

Go to root project

```bash
 cd your_project
```

Run docker (all container)

```bash
docker compose -f ./api-testing/docker-compose.yml up -d

or

docker compose -f ./api-testing/docker-compose.yml up -d --force-recreate
```

Run docker (for lms-api service)

```bash
docker compose -f ./api-testing/docker-compose.yml up api -d
```

Run docker (for api-test all file)

```bash
docker compose -f ./api-testing/docker-compose.yml up api-test -d
```

Stop docker

```bash
docker compose -f ./api-testing/docker-compose.yml down -v
```

---

### via Makefile

```bash
 cd your_project/api-testing
```

Run Container

```bash
make [TARGET_NAME]
```

example

```bash
make start_db
```

---

## Database Admin

Run Databage Admin (pgAdmin): <http://localhost:5050>

Login pgAdmin

```Text
username: admin@admin.com
password: admin
```

Create new Server

1. Click <b>Add New Server</b> that Quick Link.
2. Click <b>Gereral</b> tab > Add Name

   ```Texr
    Name: LMS
   ```

3. Click <b>Connection</b> tab

   ```Text
    Host name/address: host.docker.internal
    Port: 5432
    Maintenance database: app-db
    Username: pguser
    Password: pgpwd
   ```

---

## Step to arange data before run test

1. Create SQL scripts for prepare INSERT/DELETE/UPDATE data in database.
2. Create SQL file and bring SQL script into this file.
3. Save SQL file into folder changelog in migration folder.
4. Go to changelog-root.yml file and write code to run SQL file.
    4.1 id : Cannot duplicate and describe thing to do
    4.2 author : name of writer
    4.3 path : changelogs/{name_of_SQL_file.sql}
