# Creating a Data Access Layer with Entity Framework

### A Helpful Guide To Using Entity Framework

### GOALS!

Working guide to creating a Data Access Layer for a .NET Application using
 
* Entity Framework
* Code First Migrations 
* the Repository pattern

At the end, you should better understand how all the pieces work together.

## Steps for Creating Your Data Access Layer
1. ERD (entity relationship diagram)
1. Model classes
1. Your app’s context class
1. Use DbSets for each of the models you’ll need in database tables
1. Entity Framework Migrations
1. Repository

## Preface

Building an application is 70% planning and 30% work. The first step for building a Data Access Layer is *not* actually the Entity Relationship Diagram. The first step is understanding the application you need to build: what are the problems you are trying to solve with your application? What are the business needs? After you understand what exactly your app needs to do, you can start on your data access layer.

## Entity Relationship Diagram

Things to Consider

* What does your application need to do?
* What do you need to save in your database?
* What are the relationships present in your data?
* What is the cardinality of the relationships?
    * One to One
    * One to Many
    * Many to Many
* What is the ordinality of the relationships?
    * At least one
    * Can be zero/non-existent

## Your C# Models

> **Models** - in your data access layer, your models are the classes that represent database tables

Make a class for each of the entities in your ERD. Use virtual properties to represent the relationships between your models. For example, in a Cohort class you might see virtual properties that link Cohorts to Students and Instructores. Setting these up in your models allows Entity Framework to make the foreign key relationships in your database that exist in your ERD.

Data Annotations are used to add additional restraints and validation to your database. You can set your primary key, make a field required, give maximum and minimum values, etc. For a look into what you can do with data annotations, check out the documentation [here](https://msdn.microsoft.com/en-us/library/jj591583(v=vs.113).aspx).

```c#
using System.ComponentModel.DataAnnotations;

namespace CohortBuilder 
{
    public class Cohort 
    {
        [Key] //table’s primary key
        public int Id { get; set; } 

        [Required] //table column will not allow null entries
        public string CohortName { get; set; } 

        //NOTE: Never use [Required] on properties with virtual keyword.
        public virtual List<Student> Students {get;set;}
        public virtual Instructor PrimaryInstructor {get;set;}
    }
}
```

> **Warning:** 
> When you are working with Web API or JSON serialization in your apps, be careful when setting up many-to-many relationships in your entities. A serialization error can occur when the serializer ends up in a loop. This usually manifests in a 500 Internal Server Error that you have a hard time debugging to find. If you are planning a many-to-many relationship in your Web API app or need to JSON serialization in any app, add this to your Startup.cs (or something similar depending on your version of .NET):
>`GlobalConfiguration.Configuration.Formatters.JsonFormatter. SerializerSettings.Re‌ferenceLoopHandling = ReferenceLoopHandling.Ignore;`

## Your Application's Database Context

### Wait! Let's Make Sure You Have Entity Framework in Your Project

**Installing Entity Framework (.NET Framework)**

Right click on the solution, and click on Manage NuGet Packages for the Solution
Go to the Browse tab, and find the Entity Framework package (it’s authored by Microsoft)
Install the package into the projects containing your DAL and your test project.

**Installing Entity Framework (.NET Core)**

Tools ‣ NuGet Package Manager ‣ Package Manager Console
Run `Install-Package Microsoft.EntityFrameworkCore.SqlServer`
Run `Install-Package Microsoft.EntityFrameworkCore.Tools –Pre`
Run `Install-Package Microsoft.EntityFrameworkCore.Design`
Open project.json and locate the tools section and add the Microsoft.EntityFrameworkCore.Tools.DotNet package as shown below:

"tools": {    "Microsoft.EntityFrameworkCore.Tools.DotNet": "1.0.0-preview3-final",    "Microsoft.AspNetCore.Razor.Tools": "1.0.0-preview2-final",    "Microsoft.AspNetCore.Server.IISIntegration.Tools": "1.0.0-preview2-final"  },

> Note for .NET Core - the implementation of .NET Core and Entity Framework Core are constantly changing. If you have version errors setting up Entity Framework, please refer to the most up to date documentation!

Ok, you’ve got Entity Framework, so let's start on to your application’s database context

**Application Context**
Your application’s context class should inherit from DbContext, and you'll need a using statement for `System.Data.Entity`. Inside the class, make a public virtual DbSet<YourModel> for each of your models that represent database tables. These are the classes mentioned in your ERD. 
NOTE: Other types of classes like helper classes and services, controllers, and ViewModels are NOT a part of a DbSet!

```c#
using System.Data.Entity;

namespace CohortBuilder 
{
    public class CohortBuilderContext : DbContext //hooks in Entity Framework
    {
        //all of these will end up being database tables
        public virtual List<Student> Students { get;set; }
        public virtual List<Cohort> Cohorts { get;set; }
        public virtual List<Instructor> Instructors { get;set; }
        public virtual List<Classroom> Classrooms { get;set; }
        public virtual List<Staff> Staff { get;set; }
    }
}
```

Think of your Context as the C# representation of your database. Once your database is created with code first migrations, the DbSets in your Context and your Tables in your Database will be very similar. Some differences will occur as Entity Framework builds the Database structure needed for the data relationships between classes (your virtual properties). While in your code, when you think Database, you need to think Context. When you think Tables, you need to think of the DbSet properties on your Context.


## Entity Framework Code First Migrations

When you run a migration in Entity Framework, you are creating and changing the structure of your database. Every migration is built with a step of set up and tear down instructions that are applied to the database as necessary with the Update-Database command. If you make a migration you need to roll back, don't panic. You'll just need to update your database back to a previous migrations. Entity Framework migrations are a powerful tool.

**Database Migrations for .NET 4.6.1**
In your package manager console: 
```c#
/* This command is only used once! */
Enable-Migrations -ContextTypeName {YOUR_CONTEXT} // your context is the name of your context class 

/* These commands are run every time you need a migration: 
your initial migration and every time you model changes. */
Add-Migration {MIGRATION_NAME} //name it whatever you want, but keep it relevant to what changes you are making
Update-Database //applies your migration
```

**Database Migrations for .NET Core**
In your package manager console:
```c#
/* You don't need to Enable Migrations in .NET Core */

/* These commands are run every time you need a migration: 
your initial migration and every time you model changes. */
Add-Migration {MIGRATION_NAME} //name it whatever you want, but keep it relevant to what changes you are making
Update-Database //applies your migration
```

If you make changes to your data models after your initial migration, you can easily run the Add Migrations and Update Database commands again in your package manager console. Just Add-Migration

## Your Repository Class

Make a class in your data access layer for your repository. We use our repository to handle all the database actions in our application. Think back to your planning stage. What are all the database actions you need to do for your app? Create, Read, Update, and Delete for all your models? Chances are you don't need to do everything, so taking the extra time to plan here will actually save you time! 

You interact with your Context's DbSets in your repository to talk to your database.

**Some Methods on Your Entity Framework DbSet**

Adds:
```c#
 cohortBuilderContext.Students.Add(johnSmith);
 myContext.SaveChanges();
 /* ~ or ~ */
 //if cohort4.Students below is a List<Student> the AddRange will add the whole group at once
 cohortBuilderContext.Students.AddRange(cohort4.Students); 
 myContext.SaveChanges();
```

Deletes:
```c#
    cohortBuilderContext.Students.Remove(johnSmith);
    myContext.SaveChanges();
    /* ~ or ~ */
    //if cohort4.Students below is a List<Student> the RemoveRange will delete the whole group at once
    cohortBuilderContext.Students.RemoveRange(cohort4.Students); 
    myContext.SaveChanges();
 ```

Updates (two ways):
```c#
    /* if you want granular control of what is updated */
    //you can use a .Find() instead of first or default, too
    var exisitingStudent = cohortBuilderContext.Students.FirstOrDefault(student => student.id == 4); 
    if (existingStudent != null) {
        existingStudent.Address = "123 NewAddress St. Nashville, TN 37024";
    }
    cohortBuilderContext.SaveChanges();

    /* ~ or ~ */

    /* if you want to swap out all the properties in one step
       this relies on Entity Framework to determine what has changed.  */
    cohortBuilderContext.Students.Attach(johnSmith);
    cohortBuilderContext.SaveChanges();
```

Gets
```c#
    /* Get all with your DbSet. 
        A DbSet implements IEnumerable, so it's easy to turn into a list or use with LINQ */
    var allStudent = cohortBuilderContext.Students;

    //using LINQ
    var exisitingStudent = cohortBuilderContext.Students.FirstOrDefault(student => student.id == 4);
    //using DbSet's Find method
    var exisitingStudent = cohortBuilderContext.Students.Find(4);

    //using LINQ to limit results
    var studentsInCohort = cohortBuilderContext.Students.Where(student => student.Cohort.Name == "Evening Cohort 17");
```

In order for your repository to use your dbcontext,your repository class will need an instance of your Context to work with. The best practice is to use dependency injection to get your context instance through your class's constructor. No matter how you do it, getting access to an instance of your context is the most important part of the setup for your repository.

> **Dependency Injection -** A software design pattern that implements inversion of control for resolving dependencies. A dependency is an object that can be used (your dbcontext). An injection is the passing of a dependency to a dependent object (your repository) that would use it. Your repository only needs to know how to USE your dbcontext - not how to CREATE one. Dependency injection makes the creation of objects on which a class depends another class's problem and keeps your classes concise and cohesive.
>
> **Why is this important? -**
> Injecting dependencies like your dbcontext into your class in the constructor allows you to be flexible. You may want to unit test your repository, so you would want to be able to use a mock context object. You may want to change contexts based on the development en Understanding the usage of a dependency injection framework (whether built in .NET Core or an external package in .NET 4.6.1) is an important part of building a large .NET Application in a maintainable way.

### Unit Testing Note

Fully unit testing a repository with Entity Framework is difficult and requires a good knowledge of a mocking framework like Moq. However, your goal in unit testing is to only test the code you write, and your repositories rely on code you didn't write and don't need to test. If you use the .Add and .SaveChanges methods, you don't need to check that they work (because you didn't implement those methods). You do need to check that the appropriate methods are called and that any of *your* code is tested.

> **To save yourself frustration, consider keeping as much non-database logic out of your repository as possible**

Beyond that note, it's totally possible to fully unit test your repo. If you have a working knowledge of unit testing and Moq, this is a guide for setting up the mock `DbSet`, the most tricky part of the process.

**Mocking Your DbSets With Moq**

In order to setup your mock context, you need to cast the `DbSet`s as `IQueryable`s.

> Note: Casting is changing one type to another.

You need “borrow” the parts of the IQueryable you need for the Mock `DbSet` to work: the `IQueryable`’s query provider, expression tree, type, and its ability to enumerate. All of these properties and methods of an `IQueryable` will allow you to treat your Mock `DbSet` like a real DbSet. 

```c#
var mockContext = new Mock<CohortBuilderContext>(); //your mock context
var Students = new Mock<DbSet<Student>>(); //mock dbset
/* Set up the Mock DbSet as IQueryable*/
IQueryable<Student> studentQueryable = new List<Student>();
Students.As<IQueryable<Student>>().Setup(x => x.Provider).Returns(studentQueryable.Provider);
Students.As<IQueryable<Student>>().Setup(x => x.Expression).Returns(studentQueryable.Expression);
Students.As<IQueryable<Student>>().Setup(x => x.ElementType).Returns(studentQueryable.ElementType);
Students.As<IQueryable<Student>>().Setup(x => x.GetEnumerator()).Returns(() => studentQueryable.GetEnumerator());
mockContext.Students.Returns(Students); //make your mock context use your mock dbset
```
The setup here says that whenever you use a method on your Students Mock `DbSet`, the application should use the methods that are on your studentQueryable `IQueryable` instead.

A *huge* caveat to this is that you are now only able to use the methods on your `DbSet` that are part of an `IQueryable` (your LINQ expressions are about all that's there), so for your other methods, you should just test that they are called, not that the actions were performed. Otherwise, you can add implementation for individual methods using Moq.