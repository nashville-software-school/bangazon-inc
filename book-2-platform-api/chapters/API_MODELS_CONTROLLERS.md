# ASP.NET Web API Controllers

## What is a Controller?

ASP.NET MVC applications use several conventions to help you quickly write an API controller to handle web requests foro the resources you expose from your database. Let's look at an example.

In your browser code, whether you built a React, Angular, Vue, or other JavaScript based application, you often make XHRs to get data from other locations on the Web. Since you are going to be building this "other location" now, your JavaScript application could make a request to your API.

Assume your API is listening to requests on port 5000 of your machine. It exposes kitchen appliances as a resources (e.g. toaster, coffee maker, microwave, etc.)

### JavaScript Request

This code requests the `/appliance` resource from your API.

```js
fetch("http://localhost:5000/appliances")
  .then(res => res.json())
  .then(appliances => {
    appliances.forEach(appliance => {
      document.querySelector(".applianceList").innerHTML += `<p>${
        appliance.name
      }</p>`;
    });
  });
```

### C# Controller Method

This code handles `GET` requests for the `/appliances` request. It established a connection to the database, performs a SQL query to get all appliances and stores the results in an `appliances` variable, and then generates a response using the `Ok(appliances)` method.

ASP.NET will automatically convert the `IEnumerable` into JSON format so that the JavaScript code (see above) that made the request can parse it as JSON.

```cs
[Route("api/[controller]")]
[ApiController]
public class AppliancesController : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Get()
    {
        using (SqlConnection conn = Connection)
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = $"SELECT Id, Manufacturer, Model FROM Appliance";
                SqlDataReader reader = cmd.ExecuteReader();

                List<Appliance> appliances = new List<Appliance>();

                while (reader.Read())
                {
                    Appliance appliance = new appliance
                    {
                        Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        Manufacturer = reader.GetString(reader.GetOrdinal("Manufacturer")),
                        Model = reader.GetString(reader.GetOrdinal("Model"))
                    };
                    appliances.Add(appliance)
                }
                reader.Close();

                /*
                    The Ok() method is an abstraction that constructs
                    a new HTTP response with a 200 status code, and converts
                    your IEnumerable into a JSON string to be sent back to
                    the requessting client application.
                */
                return Ok(appliances);
            }
        }
    }
}
```

You can read the [Handle requests with controllers in ASP.NET Core MVC](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/actions?view=aspnetcore-2.1) article to learn more about using controllers.

## HTTP Verbs Overview

### Create a new Web API via the command line

```sh
mkdir -p ~/workspace/csharp/webapi/coffee
cd ~/workspace/csharp/webapi/coffee
dotnet new sln -n CoffeeShop -o .
dotnet new webapi -n CoffeeShop
dotnet sln add CoffeeShop/CoffeeShop.csproj
cd CoffeeShop
dotnet add package System.Data.SqlClient
dotnet restore
cd ..
start CoffeeShop.sln
```

### Create a new Web API via Visual Studio

1. Click the File menu > New > Project...
1. Type in "api" into the search bar
1. Choose the _ASP .NET Core Web Application_ option
1. Click _Next_
1. Project name: CoffeeShop
1. Choose where you want to create the project
1. Click _Create_
1. Choose _API_ on the next screen
1. Uncheck the _Configure for HTTS_ checkbox
1. Once the project is loaded click the Tools menu > NuGet Package Manager > Manage NuGet Packages for Solution
1. Click the Browse tab at the top
1. Enter "system.data.sqlclient" in the search bar
1. Click that package in the search results
1. Make sure you check the box for your project on the right
1. Click the _Install_ button on the right of the screen
1. Click _Ok_ in the preview window that appears
1. Then you can close the NuGet Package Manager window


The default scaffolding provides you with a `ValuesController`. It's very basic, and your instruction team will discuss HTTP verbs of GET, POST, PUT, DELETE. Then you will construct a simple coffee shop database, some data models, and a more complex controller that handles CRUD actions for coffee.

### Starter SQL

1. Open Azure Data Studio.
1. `ctrl+N` to create a new query window.
1. Click the connect icon at the top of the query window.
1. Choose the `master` data from the list of recent connections.
1. Once the connection is established, paste the following SQL into the query window to create a new database and use it.

```sql
USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'CoffeeShop'
)
CREATE DATABASE CoffeeShop
GO

USE CoffeeShop
GO
```

1. Now you will see `CoffeeShop` as an option in the dropdown menu.
1. Select that database.
1. Remove the SQL in the query window and replace it with the following SQL.
1. `ctrl+A` to select all of the statements and run them with `alt+ENTER` or by clicking the run icon at the top of the query window.

```sql
DROP TABLE IF EXISTS Coffee;

CREATE TABLE Coffee (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Title VARCHAR(50) NOT NULL,
    BeanType VARCHAR(50) NOT NULL
);

INSERT INTO Coffee (Title, BeanType)
VALUES ('Espresso', 'Brazilian');

INSERT INTO Coffee (Title, BeanType)
VALUES ('Cafe Con Leche', 'Costa Rican');

INSERT INTO Coffee (Title, BeanType)
VALUES ('Cappuccino', 'Guatemalan');
```

Now you have a new database with one table that contains three rows of data.

### App Settings

In order for your Web API to connect to this database, you are going to put the connection string in the `appsettings.json` file in your project. Open that file and replace the contents with the following configuration.

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=CoffeeShop;Trusted_Connection=True;"
  }
}
```

### Coffee Controller

Create a new controller file named `CoffeesController.cs` in the **`Controllers`** directory in your project. Replace the contents of that new file with the code below.

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using CoffeeShop.Models;
using Microsoft.AspNetCore.Http;

namespace CoffeeShop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CoffeesController : ControllerBase
    {
        private readonly IConfiguration _config;

        public CoffeesController(IConfiguration config)
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

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT Id, Title, BeanType FROM Coffee";
                    SqlDataReader reader = cmd.ExecuteReader();
                    List<Coffee> coffees = new List<Coffee>();

                    while (reader.Read())
                    {
                        Coffee coffee = new Coffee
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Title = reader.GetString(reader.GetOrdinal("Title")),
                            BeanType = reader.GetString(reader.GetOrdinal("BeanType"))
                        };

                        coffees.Add(coffee);
                    }
                    reader.Close();

                    return Ok(coffees);
                }
            }
        }

        [HttpGet("{id}", Name = "GetCoffee")]
        public async Task<IActionResult> Get([FromRoute] int id)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT
                            Id, Title, BeanType
                        FROM Coffee
                        WHERE Id = @id";
                    cmd.Parameters.Add(new SqlParameter("@id", id));
                    SqlDataReader reader = cmd.ExecuteReader();

                    Coffee coffee = null;

                    if (reader.Read())
                    {
                        coffee = new Coffee
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Title = reader.GetString(reader.GetOrdinal("Title")),
                            BeanType = reader.GetString(reader.GetOrdinal("BeanType"))
                        };
                    }
                    reader.Close();

                    return Ok(coffee);
                }
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Coffee coffee)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"INSERT INTO Coffee (Title, BeanType)
                                        OUTPUT INSERTED.Id
                                        VALUES (@title, @beanType)";
                    cmd.Parameters.Add(new SqlParameter("@title", coffee.Title));
                    cmd.Parameters.Add(new SqlParameter("@beanType", coffee.BeanType));

                    int newId = (int) cmd.ExecuteScalar();
                    coffee.Id = newId;
                    return CreatedAtRoute("GetCoffee", new { id = newId }, coffee);
                }
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put([FromRoute] int id, [FromBody] Coffee coffee)
        {
            try
            {
                using (SqlConnection conn = Connection)
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandText = @"UPDATE Coffee
                                            SET Title = @title,
                                                BeanType = @beanType
                                            WHERE Id = @id";
                        cmd.Parameters.Add(new SqlParameter("@title", coffee.Title));
                        cmd.Parameters.Add(new SqlParameter("@beanType", coffee.BeanType));
                        cmd.Parameters.Add(new SqlParameter("@id", id));

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            return new StatusCodeResult(StatusCodes.Status204NoContent);
                        }
                        throw new Exception("No rows affected");
                    }
                }
            }
            catch (Exception)
            {
                if (!CoffeeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            try
            {
                using (SqlConnection conn = Connection)
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandText = @"DELETE FROM Coffee WHERE Id = @id";
                        cmd.Parameters.Add(new SqlParameter("@id", id));

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            return new StatusCodeResult(StatusCodes.Status204NoContent);
                        }
                        throw new Exception("No rows affected");
                    }
                }
            }
            catch (Exception)
            {
                if (!CoffeeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
        }

        private bool CoffeeExists(int id)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT Id, Title, BeanType
                        FROM Coffee
                        WHERE Id = @id";
                    cmd.Parameters.Add(new SqlParameter("@id", id));

                    SqlDataReader reader = cmd.ExecuteReader();
                    return reader.Read();
                }
            }
        }
    }
}
```

## Starting the Student Exercises API

Your instruction team will get you started on converting your student exercises command line app into an API that will respond to HTTP requests.

### Create the Project

Follow the steps from the beginning of the lesson to start a new Web API project from Visual Studio or the command line - whichever is your preference. Name the project `StudentExercisesAPI`.

### Connecting to Database

1. Update `appsettings.json`
   ```json
   {
     "Logging": {
       "LogLevel": {
         "Default": "Warning"
       }
     },
     "AllowedHosts": "*",
     "ConnectionStrings": {
       "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=StudentExercises;Trusted_Connection=True;"
     }
   }
   ```

### Exercise Model

Copy the `Models/Exercise.cs` file from the CLI application into the `Models` directory of your new API project.

### Controller Methods

1. Create `ExercisesController`
1. Code for getting a list of exercises
1. Code for getting a single exercise
1. Code for creating an exercise
1. Code for editing an exercise
1. Code for deleting an exercise
