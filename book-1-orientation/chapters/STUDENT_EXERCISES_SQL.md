# Student Exercises Database

In this part of building your application, you will be creating the database tables and the data that you will be querying in your application logic later.

You will use `CREATE TABLE` statements and `INSERT` statements to create all the tables necessary for storing information about student exercises in a SQL Server database.

## Setup

### Create the Database Script File

```sh
cd ~/workspace/csharp/StudentExercises
touch StudentExercises.sql
```

## Open the Database Script for Editing

1. Open Azure Data Studio.
1. Connect to your `master` database by double clicking the connection in the Connections window.
1. Click on "New Query" when it connects.

## Create a new Database

1. Start typing in "create" and a menu will appear with helpful snippets you can choose.
1. Choose the `sqlCreateDatabase` snippet and some boilerplate code will appear.
1. Type `StudentExercises` and it will fill in the statement as you type.
1. Press `Escape` key.
1. Then click the Run button at the top and your database will be created.

## Creating Data

In the Query Window, enter the SQL to create all of your tables, columns, and foreign key constraints.

Use `CREATE TABLE` statements to create the tables and columns. Make sure you put in the foreign key `CONSTRAINT` statements where needed.

Then use `INSERT` statements to create data in your tables.

## Instructions

1. Create tables from each entity in the Student Exercises ERD.
1. Populate each table with data. You should have 2-3 cohorts, 5-10 students, 4-8 instructors,  2-5 exercises and each student should be assigned 1-2 exercises.

