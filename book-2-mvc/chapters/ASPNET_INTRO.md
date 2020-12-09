# Introduction to ASP.NET MVC Web Application

In this chapter you'll create a new MVC project to start the Nashville dog walking application, DogGo.

## Getting Started

1. Create new project in Visual Studio
1. Choose the _ASP.NET Core Web Application_
1. Specify project name of _DogGo_
1. Click _Ok_
1. Choose _Web Application (Model-View-Controller)_
1. Click _Ok_
1. Add the Nuget package for `Microsoft.Data.SqlClient`

Take a look around at the project files that come out of the box with a new ASP.NET MVC project. It already has folders for Models, Views, and Controllers. It has a `wwwroot` folder which contains some static assets like javascript and css files. It has a `Startup.cs` file where we can configure certain things about our web application if we choose.

## Database

Run the [dog walker sql script](./assets/DogWalker.sql) to create database. Take a moment and look through the tables that get created.

## Configuration

Open the `appsettings.json` file and add your connection string. The file should look like this

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=DogWalkerMVC;Trusted_Connection=True;"
  }
}
```

## Models

Create a `Neighborhood.cs` and `Walker.cs` file in the Models folder and add the following code

> Neighborhood.cs
```csharp
namespace DogGo.Models
{
    public class Neighborhood
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
```

> Walker.cs
```csharp
namespace DogGo.Models
{
    public class Walker
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int NeighborhoodId { get; set; }
        public string ImageUrl { get; set; }
        public Neighborhood Neighborhood { get; set; }
    }
}
```

Let's also create a repository for walkers. For now we'll just give it methods for getting all walkers and getting a single walker by their Id.

Create a new folder at root of the project called Repositories and create a `WalkerRepository.cs` file inside it. Add the following code

```csharp
using DogGo.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;

namespace DogGo.Repositories
{
    public class WalkerRepository
    {
        private readonly IConfiguration _config;

        // The constructor accepts an IConfiguration object as a parameter. This class comes from the ASP.NET framework and is useful for retrieving things out of the appsettings.json file like connection strings.
        public WalkerRepository(IConfiguration config)
        {
            _config = config;
        }

        public SqlConnection Connection
        {
            get
            {
                return new SqlConnection(_config.GetConnectionString("DefaultConnection"));
            }
        }

        public List<Walker> GetAllWalkers()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT Id, [Name], ImageUrl, NeighborhoodId
                        FROM Walker
                    ";

                    SqlDataReader reader = cmd.ExecuteReader();

                    List<Walker> walkers = new List<Walker>();
                    while (reader.Read())
                    {
                        Walker walker = new Walker
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                            NeighborhoodId = reader.GetInt32(reader.GetOrdinal("NeighborhoodId"))
                        };

                        walkers.Add(walker);
                    }

                    reader.Close();

                    return walkers;
                }
            }
        }

        public Walker GetWalkerById(int id)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT Id, [Name], ImageUrl, NeighborhoodId
                        FROM Walker
                        WHERE Id = @id
                    ";

                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Walker walker = new Walker
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                            NeighborhoodId = reader.GetInt32(reader.GetOrdinal("NeighborhoodId"))
                        };

                        reader.Close();
                        return walker;
                    }
                    else
                    {
                        reader.Close();
                        return null;
                    }
                }
            }
        }
    }
}
```

## Controller

We can use Visual Studio to scaffold us the skeleton of a controller. Right click on the Controllers folder in Solution Explorer and click Add > Controller > MVC Controller with Read/Write actions. Give it the name `WalkersController`

Visual Studio kindly just created a whole bunch of code for us.

Add a private field for `WalkerRepository` and a constructor

```csharp
private readonly WalkerRepository _walkerRepo;

// The constructor accepts an IConfiguration object as a parameter. This class comes from the ASP.NET framework and is useful for retrieving things out of the appsettings.json file like connection strings.
public WalkersController(IConfiguration config)
{
    _walkerRepo = new WalkerRepository(config);
}
```

### The power of ASP<span>.NET</span> Controllers

In the context of ASP<span>.NET</span>, each of the public methods in the controllers is considered an **Action**. When our application receives incoming HTTP requests, The ASP<span>.NET</span> framework is smart enough to know which controller Action to invoke.  

How does it do this? Take a look at the bottom of the `Startup.cs` class

```csharp
endpoints.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
```

ASPNET will inspect the parts of the url route. If a request comes in at `localhost:5001/Walkers/Index`, the framework will look for an `Index` action on the `Walker` controller and invoke it. If a request comes in at `localhost:5001/Walkers/Details/5`, The framework will look for a `Details` action in the `Walkers` controller and invoke it while passing in the parameter `5`. You'll also notice in the code above that some defaults have been set up in the routes. If the url of the request does not contain an action, the framework will invoke the Index action by default--meaning `localhost:5001/Walkers` would still trigger the `Index` action in the `Walkers` controller. Likewise, if the url doesn't contain a controller, i.e. `localhost:5001/`, the framework will assume the `Home` controller and the `Index` action. You are of course welcome to change these defaults.

### Get All Walkers

When a user is on `localhost:5001/Walkers`, we want to show them a view that contains a list of all the walkers in our system. Update the `Index` method to look like the following

```csharp
// GET: Walkers
public ActionResult Index()
{
    List<Walker> walkers = _walkerRepo.GetAllWalkers();

    return View(walkers);
}
```

This code will get all the walkers in the Walker table, convert it to a List and pass it off to the view. 



### Viewing the list of walkers

Currently, we're passing data into a view that doesn't exist. Let's fix that. Right click the method name `Index` in your controller and click "Add View". In the dialog box that appears, leave the view name "Index", for template select "List", and for Model class select "Walker". Then click the Add button. 

The generated view creates an html table and iterates over each walker in the list and creates a new row for each one.

##### Razor Templates

You'll notice a couple things about the code in the view. For one, it's not in an html file--it's in a cshtml file. This is called a _razor template_. With razor we can write a mix of C# and html code. It's similar to JSX in that it can dynamically create html. Once data gets passed into the view, the razor engine will convert it to an html page that can be returned to the browser. Here's an example of what razor code might look like

```html+razor
<h1>@Model.Name</h1>
```

And here is what the dynamically outputted html might look like

```html
<h1>Mo Silvera<h1>
```

We can also do things in our razor templates like make `if` statements or `foreach` loops to dynamically create html. Notice that any C# code that we want evaluated in the views starts with the `@` symbol. Also notice that the `Model` keyword is a reference to whatever object that the view receives from the controller. Assume in the example below that a controller has just passed the view a `List<Walker>`

```html+razor
<ul>
    @foreach (Walker walker in Model)
    {
        <li>@walker.Name</li>
    }
</ul>
```

Run the application and go to `/walkers/index`. You should see your data driven page.

The view that Visual Studio scaffolded for us is a decent start, but it has a number of flaws with it. For now, lets take care of the image urls. Instead of seeing the actual url, lets replace that with an actual image. Replace the code that say `@Html.DisplayFor(modelItem => item.ImageUrl)` with the following

```html
<img src="@item.ImageUrl" alt="avatar" />
```

Finally, uncomment the the code at the bottom of the view, and instead of using `item.PrimaryKey`, change the code to say `item.Id` on each of the action links.

```html+razor
<td>
    @Html.ActionLink("Edit", "Edit", new { id=item.Id }) |
    @Html.ActionLink("Details", "Details", new { id=item.Id }) |
    @Html.ActionLink("Delete", "Delete", new { id=item.Id })
</td>
```

These action links will generate `<a>` tags at runtime. The first one, for example, is saying that we want an `<a>` tag whose text content says the word "Edit", and we also want it to link to the `Edit` action in the controller. Lastly, it's saying that we want to include whatever `item.Id` is as a route parameter. The genereated anchor tag would look something like this

```html
<a href="/Walkers/Edit/5">Edit</a>
```

### Getting A single walker

When our users go to `/walkers/details/3` we want to take them to a page that has the details of the walker with the ID 3. To do this, we need to implement the `Details` action in the `Walkers` controller.

```csharp
// GET: Walkers/Details/5
public ActionResult Details(int id)
{
    Walker walker = _walkerRepo.GetWalkerById(id);

    if (walker == null)
    {
        return NotFound();
    }

    return View(walker);
}
```

Notice that this method accepts an `id` parameter. When the ASP<span>.NET</span> framework invokes this method for us, it will take whatever value is in the url and pass it to the `Details` method. For example, if the url is `walkers/details/2`, the framework will invoke the Details method and pass in the value `2`. The code looks in the database for a walker with the id of 2. If it finds one, it will return it to the view. If it doesn't the user will be given a 404 Not Found page.

Right click the Details method and select Add View. Keep the name "Details", select "Details" for the Template dropdown, and select "Walker" for the model class. Make the same changes in the view as before and replace the image url with the image tag

```html
<img class="bg-info" src="@Model.ImageUrl" alt="avatar" />
```

Run the application and go to `/walkers/details/1`. Then go to `/walkers/details/999` to see that we get a 404 response back.


## Exercise

1. Create an `OwnerRepository` and an `OwnersController` file and implement the `Index` and `Details` methods.
1. Go into the `Shared` folder in the `_Layout.cshtml` file. Add links for "Walkers" and "Owners" in the navbar. If you finish, try changing the views and the styling to your liking.
1. **Challenge**: When viewing the details page of an owner, list all the dogs for that owner as well.
