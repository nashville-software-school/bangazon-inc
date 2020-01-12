# Object/Relational Mapping and Entity Framework

An Object/Relational Mapper (ORM) is a software tool for automatically connecting C# objects to relational database tables. You've likely noticed that when working with ADO<span>.NET</span> you have to write a lot of SQL and C# code that is largely repetitive. An ORM is a tool that does the repetitive SQL and boilerplate C# for you. An ORM greatly reduces - often eliminates - the need to write SQL in your application.

## Entity Framework

Entity Framework (EF) is a popular ORM created by Microsoft. It allows you to use LINQ methods in conjunction with your data models to interact with your database (e.g. SELECT. INSERT, UPDATE, DELETE data). EF then determines the SQL syntax needed to perform the appropriate action(s).

Here's an example showing the different between EF and ADO<span>.NET</span>. This example selects all of the departments from the Bangazon database.

## Select all Departments

### ADO<span>.NET</span> Example

```cs
public ActionResult Index()
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = "SELECT Id, Name, Budget FROM Department";
            SqlDataReader reader = cmd.ExecuteReader();

            List<Department> departments = new List<Department>();
            while (reader.Read())
            {
                departments.Add(new Department
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                    Name = reader.GetString(reader.GetOrdinal("name")),
                    Budget = reader.GetInt32(reader.GetOrdinal("budget"))
                });
            }
            reader.Close();
            return View(departments);
        }
    }
}

```

### EF Example

```cs
public async Task<IActionResult> Index()
{
    List<Department> departments = await _context.Department.ToListAsync();
    return View(departments);
}
```

## Create New Department

You also create new database entries with other methods that abstract the SQL away from you - the `Add()` and `SaveChangesAsync()` methods.

### ADO<span>.NET</span> Example

```cs
[HttpPost]
[ValidateAntiForgeryToken]
public ActionResult Create(Department department)
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"INSERT INTO Department ([name], budget)
                                     VALUES (@name, @budget)";
            cmd.Parameters.Add(new SqlParameter("@name", department.Name));
            cmd.Parameters.Add(new SqlParameter("@budget", department.Budget));

            cmd.ExecuteReader();

            return RedirectToAction(nameof(Index));
        }
    }
}
```

### EF Example

```cs
[HttpPost]
[ValidateAntiForgeryToken]
public async Task<IActionResult> Create(Department department)
{
    if (ModelState.IsValid)
    {
        _context.Add(department);
        await _context.SaveChangesAsync();
        return RedirectToAction(nameof(Index));
    }
    return View(department);
}
```

### DbContext
In Entity Framework we don't directly use a `SqlConnection` object like we did in ADO.<span>NET</span>. Instead we use an instance of ` Microsoft.EntityFrameworkCore.DbContext`.

In the examples above you'll notice the `_context` variable. This private field is the instance of our `DbContext` that we use in our controller to interact with the database.

The first step in creating a `DbContext` is to make a new class that inherits from it. This class is commonly called `ApplicationDbContext`. Because every database is different, Microsoft could not make a generic `DbContext` to cover everything. The `DbContext` EF provides is a base class that we extend with the specifics of our database.

Here is a partial implementation of an `ApplicationDbContext` for Bangazon's Workforce Application.

```cs
using Bangazon.Models;
using Microsoft.EntityFrameworkCore;

namespace Bangazon.Data {
    public class ApplicationDbContext : DbContext {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<Employee> Employee { get; set; }
        public DbSet<Department> Department { get; set; }
    }
}
```
In order to get an instance of our `ApplicationDbContext` class in our controller, we use dependency injection. By creating a parameter in the controller's constructor, we're telling ASP.<span>NET</span> to give us an instance.

```cs
namespace Bangazon.Controllers {
    public class DepartmentsController : Controller {
        private readonly ApplicationDbContext _context;

        public DepartmentsController(ApplicationDbContext context) {
            _context = context;
        }

        // ...controller actions that use the _context field...
    }
}
```

### DbSet&lt;T&gt;

Notice the `DbSet<T>` properties in `ApplicationDbContext`. `DbSet<T>`s are the link between models and database tables. The `ApplicationDbContext` above implies that we have `Employee` and `Department` model classes AND `Employee` and `Department` database tables.

Take another look at this line from the department query example above:

```cs
List<Department> departments = await _context.Department.ToListAsync();
```
We are accessing the `Department` property on the instance of our `ApplicationDbContext` in order to query the `Department` database table.

### CRUD with Entity Framework

#### Create

To insert a record into a database table use the context's `Add()` method followed by `SaveChangesAsync()`

```cs
Department dept = new Department() {
    Name = "Public Relations",
    Budget = 500_000
};
_context.Add(dept);
await _context.SaveChangesAsync();
```

> **NOTE:** the `Add` method only "stages" the insert action. The database is not updated until `SaveChangesAsync()` is called.

> **NOTE:** We do NOT set the department's `Id` property. The database will provide the new department id.

#### Read

To query a database table use LINQ queries on the appropriate `DbSet<T>`. In EF we have the full power of LINQ along with some additional capabilities that LINQ does not provide.

```cs
// Get all Employees
await _context.Employee.ToListAsync();

// Get an individual Employee by id
await _context.Employee.FindAsync(id);
// or
await _context.Employee.FirstOrDefaultAsync(e => e.id == id);

// Get all Employees with the last name of Garcia
// ordered by their first name
await _context.Employee
              .Where(e => e.LastName == 'Garcia')
              .OrderBy(e => e.FirstName)
              .ToListAsync();

// Get All supervisors and their departments
// "Include()" is the way to do simple SQL JOINS
await _context.Employee
              .Include(e => e.Department)
              .Where(e => e.IsSupervisor)
              .ToListAsync();
```

> **NOTE:** The query is not executed in the database until one of the "Async" methods is called. (e.g. `ToListAsync(), FindAsync(), FirstOrDefaultAsync()`)

#### Update

Update a record with the `Update()` method.

```cs
Employee emp = await _context.Employee.FirstOrDefaultAsync(e => e.FirstName == "Betty");

emp.FirstName = "Liz";

_context.Update(emp);
await _context.SaveChangesAsync();
```

#### Delete

Delete a record with the `Remove()` method.

```cs
Department dept = _context.Department.FindAsync(id);
_context.Remove(dept);
await _context.SaveChangesAsync();
```

## Project Setup

### Create a new project:
1. Select ASP.NET Core Web Application
1. Name your project and hit "Create"
1. Select "Web Application Model-View-Controller"
    - On the right, under "Authentication", select "Change" and then select "Individual User Accounts"
1. Go into `appsettings.json` and change the connection of your database to point toward the SQL Server database you want to use in this project.

### Nuget Package References

When you add authentication, ASP<span>.Net</span> installs the packages you need to use Identity Framework and SQL Server. You need to install the following package manually:

* **Microsoft.EntityFrameworkCore**
    * The foundational EF library



### ApplicationDbContext

Once you create your models, you will need to add them to your `ApplicationDBContext`.

```cs
using DepartmentsEmployeesEF.Models;
using Microsoft.EntityFrameworkCore;

namespace MyProjectName.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        // TODO: Add "DbSet<T>"s here...
    }
}
```

## The Cost of Convenience

While the simpler syntax may seem like a breath of fresh air, and much easier to read (_once you get used to it_), you pay for it with poorer performance. The SQL generated by EF is a sore spot by many developers because there are cases where it is not as fast and optimized as it would be if written out in long-form by the developer.

* [Dapper vs Entity Framework vs ADO.NET Performance Benchmarking](https://www.exceptionnotfound.net/dapper-vs-entity-framework-vs-ado-net-performance-benchmarking/)
* [Performance: Entity Framework 7 vs. Dapper.net vs. raw ADO.NET](https://ppanyukov.github.io/2015/05/20/entity-framework-7-performance.html)

> **NOTE:** [Dapper](https://github.com/StackExchange/Dapper) is a popular "light-weight" ORM. It's an alternative to EF and ADO<span>.NET</span>. We won't be discussing Dapper in this course.

## Supplemental Tutorial

You may find the first four parts of this tutorial helpful. [ASP.NET Core MVC with Entity Framework Core](https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/?view=aspnetcore-2.2).

> **NOTE:** This tutorial is challenging and will include new concepts beyond those specifically related to Entity Framework, but stick with it. It's an important part of your education to practice learning from online documentation. This will not be the last time you find yourself needing to learn something from docs.

> **NOTE:** It is easy race through the tutorial without reading and understanding what is being discussed. Do NOT make this mistake. Read the text don't just copy and paste the code.
