# Repository Pattern  

* “Unit of Work” and “Repository Pattern” are two patterns that you need to know to work with .Net database structures.

* Business logic goes into Repository.
* Controller will change over time.

* http://www.asp.net/mvc/overview/older-versions/getting-started-with-ef-5-using-mvc-4/implementing-the-repository-and-unit-of-work-patterns-in-an-asp-net-mvc-application

'No matter what LINQ expression is run, it will return an IQueryable... What we care about, is what is inside the IQueryable'

GetEnumerator is a kind of iterator, passes each next item, called in succession.

* Repository Pattern:
   * A repository pattern separates the database logic from the business logic of your program. The program logic has really no idea what the database logic is because there is the middle man (the repository) that does the spying and implementation of the database for the program.
   * ORM is Object Relational Mapping. It is the translator mapping between the model and the specific database type so that they are able to talk to each other.
     * You can use LINQ to talk to the ORM which translates the statement so the database can understand what you want it to do.
     * The Entity Framework is a type of ORM and applies the repository pattern to the program.
   * `Events.Load()` loads the initial dataset into memory into EventContext.
   * Using `dbContext.Events.Local` creates an observable collection whereas `dbContext.Events` is actually referring to the dataset itself.
   * When we do `dbContext.Events.Add()`, that means that your local version (or the version in memory) will get updated, but the database itself will not be updated until you tell to save changes with `dbContext.SaveChanges()`
   * You would put a using for a one time connection to the database to open the connection, do a thing such as retrieving data, and then close the connection. If you want a persistent connection you will need something like `db.Context.Load()` and `db.Context.Dispose()`


* Repository pattern and the concept of caching   
  *  The job of a repository is to separate the data layer from the business layer.  The business layer is the portion of the application that performs a task, the data layer is simply the storing of data (or the stored data itself).
  *  The DB is only one type of data store/source.  Caching (the use of the “repo” stored in memory) allows us to have access to data upon the applications startup.  This way we don’t have to manually or programmatically access the Database each time the application starts up, we can store the data we choose within memory, essentially short circuiting the need for the application to talk to the repo (which would then talk to the context → which would talk to the model → which would talk to the Database).  For instance, we could store a “Count” variable within memory upon startup, that gets updated as the model/DB gets updated.  But upon each startup the “Count” variable is accessible from within memory, circumventing the need for the application to query the DB to get the “Count” upon each startup.
  *  This technique of caching information in the abstraction layer is a pretty common technique, and has a name within .NET (which he didn’t mention).
  * Would you have multiple Repositories if you have multiple data structures?
   * Typically you have one repository per project. You can have multiple entities and multiple Contexts, but still have one repository where you had implement these contexts in separate class files here.

* Other notes
   * C# has ability to accept default arguments.
   * When you create your `DBContext`, the connection automatically will look for a database with the same name as its default.
   * You have the ability to set the name of your database regardless of the name of your context class.
   * Your public `ObjectContext()` is actually implicitly saying the same things as:
     * `ObjectContext(string connection = “ProjectName.ObjectContext”)`
   * Now, in your app.config you can add a tag called `<connectionStrings>`
   and you can add your second database here by saying something like:
       * `add name=”TestDB” connectionString=”Server=.\SQLExpress;DatabaseName=TestDB; Trusted_Connection=true”)`
     * Meaning that the database is called "TestDB" and it’s a local trusted connection.
     * Then in your repo tests (ObjectRepositoryTest.cs file),  you can make your repo instance:
       * `repo = new ObjectRepository(“Name=TestDB”);`




### Useful Documentation from MSDN

#### `DbContext` Class
* `https://msdn.microsoft.com/en-us/library/system.data.entity.dbcontext(v=vs.113).aspx`

#### `DbSet`
* https://msdn.microsoft.com/en-us/library/system.data.entity.dbset_properties%28v=vs.113%29.aspx

#### `DbSet<TEntity>`
* https://msdn.microsoft.com/en-us/library/gg696460%28v=vs.113%29.aspx

#### `IQueryable`
* https://msdn.microsoft.com/library/bb351562%28v=vs.100%29.aspx

#### `IComparable.CompareTo`
* https://msdn.microsoft.com/en-us/library/system.icomparable.compareto%28v=vs.110%29.aspx

#### `ObservableCollection<T>`
* https://msdn.microsoft.com/en-us/library/ms668604(v=vs.113).aspx
   * Presents a local view of all Added, Unchanged, and Modified entities in this set.
   * This local view will stay in sync as entities are added or removed from the context.
   * Likewise, entities added to or removed from the local view will automatically be added to or removed from the context.