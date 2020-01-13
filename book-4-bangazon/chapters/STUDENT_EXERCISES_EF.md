# Student Exercises with Entity Framework


## Setting up your project
1. Create a new database. Call it `StudentExercises-EF`.
1. In Visual Studio, create a new MVC Web App with ASP.NET. Make sure you select "Individual User Accounts" for Authentication.

## Building your database
1. Copy your models from your previous Student Exercise project. You'll want to go through your models again before you do anything else and make sure that they represent every relationship in the database.
1. Add each `DbSet` to your `ApplicationDbContext` file.
1. Once your models are in order, open the Package Manager Console in Visual Studio.
1. Run `Add-Migration` and enter a name for your first migration.
1. Run `Update-Database` to build your database.

## Building your application (CRUD)
1. Scaffold controllers and views with Entity for Students, Cohorts, Instructors, and Exercises.
1. Your Entity scaffolding uses `ViewData` to render the dropdowns of related data in create forms. Anywhere you see `ViewData` in your scaffolding, you should refactor it and create a view model instead.

## Viewing Related Data
### Cohort Detail View
1. When the user navigates to the detail view for a cohort, they should see a list of all students and all instructors currently in that cohort.

### Students Detail View
1. When the user navigates to the detail view for a student, they should see all exercises currently assigned to that student.

### Instructor Detail View
1. When the user navigates to the detail view for an instructor, they should see a list of all students currently in that instructor's class.
1. Each student's name should be a hyperlink to that student's details view.

### Searching
Read over the [segment of your tutorial on search functionality](https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/sort-filter-page?view=aspnetcore-2.2)
1. Implement a search bar in your student index view. The user should be able to search by first or last name. Searches should not be case sensitive.

# Challenges

### Assigning Exercises to Students
1. Add a multi-select to the student edit view. Users should be able to assign one or many exercises to each student. Exercises that are already assigned should be pre-selected when the edit form renders.


### Complete Exercises
1. Add a property to the student-exercise join table called `isComplete`. You'll use this property to keep track of whether or not a student has completed the exercise.
        * To do this with Entity, just add the property of `isComplete` to your `StudentExercise` model. Then run `Add-Migration` and `Update-Database` to migrate the changes from your model to the database.
1. For right now, just seed your database with SQL so that you have some completed exercises. You can work on building checkboxes to mark them as completed in your app later if you'd like.


### Cohort Reports
1. Add a new item to your nav bar called "Reports".
1. When the user navigates to this view, they should see a dropdown of all cohorts.
1. When the user selects a cohort, they should see a report with the following data about that cohort:
    - *Top Three In Progress Exercises*- this should be exercises that are assigned to students in that cohort but not completed
     - *Top Three Busiest Students* - students with the most completed exercises
    - *Top Three Laziest Students* - students with the most incomplete exercises
