# Entity Framework

* http://www.tutorialspoint.com/entity_framework/entity_framework_overview.htm
* http://tektutorialshub.com/introduction-to-entity-framework/
* http://stackoverflow.com/questions/1279613/what-is-an-orm-and-where-can-i-learn-more-about-it
* https://msdn.microsoft.com/en-us/data/jj729737.aspx

### What is an ORM (Object Relational Mapper)
* ORMS solve the problem of mismatch between relational data and objects found in code.
* There are many ORMS but Entity Framework is frequently used in .NET applications.
* ORMS connect to databases and manage communication between the database and your C# code that will be querying, updating, creating, deleting records int he database.
* ORMs save developers from having to embed sql in their programs as strings or called stored procedures.
* Embedded sql strings and stored procedures are difficult to debug but using Entity Framework or other ORMS gives developers objects they can query and debug. Having access to intellisence while developing is an additional feature. 
* ORMS map to tables allowing developers to easily create objects that will have the matching properties making inserting new data easier since there are classes often called models that directly reflect the database table they represent. 

*![Entity Framework](http://www.entityframeworktutorial.net/Images/ORM.png)

### What is Entity Framework?:
* Popular ORM used in .NET applications
* There are many techniques for using it so looking for specific examples can be tricky
* It is typically added to your .NET app via Nuget Package Manager. 

### Why use and ORM (Object Relation Mapper) like Entity Framework:
* Promotes a consistent way for a team to access data
* Takes away plumbing related to opening and closing database connections. You are using a single object to connect to the database rather that having connections spread throughout your code base. 
* Can use LINQ vs embedded sql or calling stored procedures
* Can use objects to represent data which makes querying and manipulating data much easier. 
* Using objects enables developers to debug in a way that embedded sql or stored procedures cannot.
* Promotes a cleaner code base by allowing developers to develop against common objects that represent relational data.
* Not as much looping though code to get results or resorting to creating various classes and collections to work with and display data. 

### How It Works
* An application that uses Entity Framework will have what is called "DBContext", DBContext is used to not only to make a connection to to a database but also directly maps tables in the database to objects often called "domain objects" or "models". 
* The code sample below shows a typical example of a DBContext. You can see that the model called "Employee" is being directly associated with a table in the database called "Employee".
```
namespace MyDatabase.Models
{
    public class MyStoreContext: DbContext
    {
        public DbSet<Employee> Employee { get; set; }
        public DbSet<Department> Department { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Employee>()
                .ToTable("Employee")
                .HasKey(e => e.EmployeeId);

            modelBuilder.Entity<Department>()
              .ToTable("Department")
              .HasKey(d => d.DepartmentId);
        }
    }
}
```
* Notice that this instance of the DBContext is named "MyStoreContext". Below you will see the actual connection string associated with this database connection. Usually the database connection string is stored in the Web.Config for a web project or the App.Config file for other types of projects. 
```
 <connectionStrings>
    <add name="MyStoreContext" connectionString="Data Source=Alienware-PC\sqlexpress;Initial Catalog=MyStore;Integrated Security=True"  providerName="System.Data.SqlClient" />
  </connectionStrings>
```
* This code shows the model that represents the "Employee" table in the database.
```
namespace MyDatabase.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public int DepartmentId { get; set; }
        public string City { get; set; }
        public string Description { get; set; }
    }
}
```
* This is an example of the models being used to join data from the relational database using a LINQ join. Note that the DBContext object is being used to connect to two tables in the database, in this case a table called "Employee" and another table called "Department".
```
public ActionResult Index()
        {
            MyStoreContext _myStoreContext = new MyStoreContext();
            var employeeDetails = (from emp in _myStoreContext.Employee
                                   join dept in _myStoreContext.Department
                                   on emp.DepartmentId equals dept.DepartmentId
                                   orderby dept.Name
                                   select new EmployeeDetailsViewModel
                                   {
                                       Name = emp.Name,
                                       Description = emp.Description,
                                       DepartmentName = dept.Name
                                   }).ToList();

```

