# Employee CRUD — Jersey + Hibernate

<p align="center">
  <img src="./assets/banner.svg" alt="Employee CRUD banner" width="100%">
</p>

<p align="center">
  A Java web application demonstrating CRUD operations with Jersey, Hibernate and MySQL.
</p>

<div align="center">

![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Jersey](https://img.shields.io/badge/Jersey-2.39-2C5AA0?style=for-the-badge)
![Hibernate](https://img.shields.io/badge/Hibernate-5.6-59666C?style=for-the-badge&logo=hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

</div>

## Overview

This project demonstrates an employee-management web application using **Java 17**, **Jersey MVC**, **Hibernate ORM** and **MySQL**.

It focuses on practical backend architecture, persistence, validation, JSON handling and CRUD workflows.

## Core Technologies

- Java 17
- Jersey 2.39
- Jersey MVC / JSP
- Hibernate 5.6
- Hibernate Validator
- MySQL Connector/J
- Jackson JSON
- Maven
- JUnit

## Key Concepts

- Create, read, update and delete employee records
- ORM-based database persistence
- REST / MVC application structure
- Role-based endpoint protection with `@RolesAllowed`
- Bean validation
- JSON serialisation
- Maven dependency management

## API Surface

| Method | Resource | Access |
|---|---|---|
| `GET` | Employee collection | `USER`, `ADMIN` |
| `POST` | Employee collection | `ADMIN` |
| `PUT` | Employee by ID | `ADMIN` |
| `DELETE` | Employee by ID | `ADMIN` |

The exact base path is defined by the Jersey resource configuration in the application.

## Run Locally

Make sure Java 17, Maven, MySQL and a compatible servlet container are available.

```bash
mvn clean verify
mvn clean package
```

Configure the database connection used by the application, deploy the generated WAR to your servlet container, and start the application.

## Quality & CI

The repository includes a GitHub Actions workflow that verifies the Maven build on pushes and pull requests. Database credentials and runtime configuration should remain outside source control.

## Learning Focus

This repository is part of my Java and backend development learning journey, with an emphasis on **OOP, REST-style services, persistence and enterprise Java patterns**.

## Author

**Chanul Dewdisa**

[GitHub](https://github.com/DewdisaC) • [Portfolio](https://chanul-portfolio-2027.vercel.app/)
