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

1. Create tables for each entity. These should match the dbdiagram ERD you created in [Student Exercises Part 1](./STUDENT_EXERCISES_TYPES.md).
1. Populate each table with data. You should have 2-3 cohorts, 5-10 students, 4-8 instructors,  2-5 exercises and each student should be assigned 1-2 exercises.
1. Write a query to return all student first and last names with their cohort's name.
1. Write a query to return student first and last names with their cohort's name only for a single cohort.
1. Write a query to return all instructors ordered by their last name.
    > **NOTE:** SQL offers the ability to [order by](https://www.w3schools.com/SQL/sql_orderby.asp) columns in a table.
1. Write a query to return a list of unique instructor specialties.
    > **NOTE:** Take a look at [SQL SELECT DISTINCT Statement](https://www.w3schools.com/Sql/sql_distinct.asp) for some guidance.
1. Write a query to return a list of **all** student names along with the names of the exercises they have been assigned. If an exercise has not been assigned, it should **not** be in the result.
    > **NOTE:** sometimes you need to join more than two tables in a query.
1. Return a list of student names along with the count of exercises assigned to each student.
    > **NOTE:** SQL has a [group by](https://www.w3schools.com/sql/sql_groupby.asp) just like LINQ does.

