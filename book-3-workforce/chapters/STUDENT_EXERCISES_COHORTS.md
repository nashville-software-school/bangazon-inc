# Displaying a List of Cohorts

Your first task for this chapter is to start a new Visual Studio Web Application (MVC) project named `StudentExercisesMVC`. Once the project is created, you will need to install Dapper as a dependency. You can use the Package Manager console in Visual Studio, or you can do it from the command line with `dotnet add package Dapper`. If you do it from the command line, make sure you execute `dotnet restore` to enable it for your project.

Now you need to make a controller and a Razor template in order to manage the cohorts for your database.

Use scaffolding to...

1. Create a `CohortsController` in your controllers directory.
1. Create a `Views > Cohorts` directory and use the scaffolding to the create the `Index`, `Details`, `Create`, `Edit`, and `Delete` views.
1. In your controller, use Dapper to execute SQL statements for all of those actions.
