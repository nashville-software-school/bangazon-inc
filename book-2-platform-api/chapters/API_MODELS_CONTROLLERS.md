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
            document.querySelector(".applianceList").innerHTML += `<p>${appliance.name}</p>`
        })
    })
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

                IEnumerable<Appliance> appliances = new IEnumerable<Appliance>();

                if (reader.Read())
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

When you generate a new Web API with the following command...

```sh
dotnet new webapi -n CoffeeShop
```

The default scaffolding provides you with a `ValuesController`. It's very basic, and your instruction team will discuss HTTP verbs of GET, POST, PUT, DELETE. Then you will construct a simple coffee shop database, some data models, and a more complex controller that handles CRUD actions for coffee.

### Starter SQL

```sql
DROP TABLE IF EXISTS Coffee;

CREATE TABLE Coffee (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Title VARCHAR(50) NOT NULL
    BeanType VARCHAR(50) NOT NULL
);

INSERT INTO Coffee (Title, BeanType)
VALUES ('Espresso', 'Brazilian');

INSERT INTO Coffee (Title, BeanType)
VALUES ('Cafe Con Leche', 'Costa Rican');

INSERT INTO Coffee (Title, BeanType)
VALUES ('Cappuccino', 'Guatemalan');
```

### App Settings

```json
{
    "Logging": {
        "LogLevel": {
            "Default": "Warning"
        }
    },
    "AllowedHosts": "*",
    "ConnectionStrings": {
        "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=Coffee;Trusted_Connection=True;"
    }
}
```

### Coffee Controller

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
                        Coffee coffee = new coffee
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
                        coffee = new coffee
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
                                        VALUES (@title, @beanType);
                                        select MAX(Id) from Coffee";
                    cmd.Parameters.Add(new SqlParameter("@title", coffee.Title));
                    cmd.Parameters.Add(new SqlParameter("@beanType", coffee.BeanType));
                    cmd.Parameters.Add(new SqlParameter("@id", id));

                    cmd.ExecuteNonQuery();
                    int newId = (int) cmd.ExecuteScalar();
                    coffee.Id = newId;
                }
            }
            return CreatedAtRoute("GetCoffee", new { id = newId }, coffee);
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

                        int rowsAffected = await cmd.ExecuteNonQuery();
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

                        int rowsAffected = await cmd.ExecuteNonQuery();
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

### Setting up Database

1. Generate a new Web API with `dotnet new webapi -o StudentExercises`
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
