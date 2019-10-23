# Student Exercises Database

In this part of building your application, you will be creating the database tables and the data that you will be querying in your application logic later.

You will use `CREATE TABLE` statements and `INSERT` statements to create all the tables necessary for storing information about student exercises in a SQL Server database.

## Setup

### Create a new Database

1. Open Visual Studio
1. Open the SQL Server Object Explorer
1. Right-click the `Databases` node beneath your SQLEXPRESS SQL Server Instance. Select `Add New Database`.
1. Name the database `StudentExercises`.
1. Right-click the new database and select `New Query...`.
1. Click `File` -> `Save SQLQuery1.sql`. Navigate to an approprate directory save the file as `StudentExercises.sql`.

### Creating Data

In the Query Window, enter the SQL to create all of your tables, columns, and foreign key constraints.

Use `CREATE TABLE` statements to create the tables and columns. Make sure you put in the foreign key `CONSTRAINT` statements where needed.

Then use `INSERT` statements to create data in your tables.

## Instructions

1. Create tables from each entity in the Student Exercises ERD.
1. Populate each table with data. You should have 2-3 cohorts, 5-10 students, 4-8 instructors,  2-5 exercises and each student should be assigned 1-2 exercises.

