# Exploring Student Exercises in the database using Dapper

## Instructions

1. Add packages for Dapper and Sqlite to your Student Exercises project
    ```
    dotnet add package Dapper
    dotnet add package Microsoft.Data.Sqlite
    dotnet restore
    ```
1. Create a `DatabaseInterface` class to interact with your `StudentExercises.db` database.
1. Query the database for all the Exercises.
1. Fnd all the exercises in the database where the language is JavaScript.
1. Insert a new exercise into the database.
1. Find all instructors in the database. Include each instructor's cohort.
1. Insert a new instructor into the database. Assign the instructor to an existing cohort.
1. Assign an existing exercise to an existing student.
1. **Challenge** - Find all the students in the database. Include each student's cohort AND each student's list of exercises.