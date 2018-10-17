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
        using (IDbConnection conn = Connection)
        {
            string sql = "SELECT * FROM Exercise";

            IEnumerable<Appliance> appliances = await conn.QueryAsync<Appliance>(sql);
            return Ok(appliances);
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

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using Dapper;
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

        public IDbConnection Connection
        {
            get
            {
                return new SqlConnection(_config.GetConnectionString("DefaultConnection"));
            }
        }

        [HttpGet]
        public async Task<IActionResult> Get(string language)
        {
            using (IDbConnection conn = Connection)
            {
                string sql = "SELECT * FROM Coffee";

                var coffees = await conn.QueryAsync<Exercise>(sql);
                return Ok(coffees);
            }

        }

        [HttpGet("{id}", Name = "GetCoffee")]
        public async Task<IActionResult> Get([FromRoute] int id)
        {
            using (IDbConnection conn = Connection)
            {
                string sql = $"SELECT * FROM Coffee WHERE Id = {id}";

                var singleCoffee = (await conn.QueryAsync<Coffee>(sql)).Single();
                return Ok(singleCoffee);
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Coffee coffee)
        {
            string sql = $@"INSERT INTO Coffee
            (Title, BeanType)
            VALUES
            ('{coffee.Title}', '{coffee.BeanType}');
            select MAX(Id) from Coffee";

            using (IDbConnection conn = Connection)
            {
                var newId = (await conn.QueryAsync<int>(sql)).Single();
                coffee.Id = newId;
                return CreatedAtRoute("GetCoffee", new { id = newId }, coffee);
            }

        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put([FromRoute] int id, [FromBody] Coffee coffee)
        {
            string sql = $@"
            UPDATE Coffee
            SET Title = '{coffee.Title}',
                BeanType = '{coffee.BeanType}'
            WHERE Id = {id}";

            try
            {
                using (IDbConnection conn = Connection)
                {
                    int rowsAffected = await conn.ExecuteAsync(sql);
                    if (rowsAffected > 0)
                    {
                        return new StatusCodeResult(StatusCodes.Status204NoContent);
                    }
                    throw new Exception("No rows affected");
                }
            }
            catch (Exception)
            {
                if (!ExerciseExists(id))
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
            string sql = $@"DELETE FROM Coffee WHERE Id = {id}";

            using (IDbConnection conn = Connection)
            {
                int rowsAffected = await conn.ExecuteAsync(sql);
                if (rowsAffected > 0)
                {
                    return new StatusCodeResult(StatusCodes.Status204NoContent);
                }
                throw new Exception("No rows affected");
            }

        }

        private bool CoffeeExists(int id)
        {
            string sql = $"SELECT Id, Title, BeanType FROM Coffee WHERE Id = {id}";
            using (IDbConnection conn = Connection)
            {
                return conn.Query<Coffee>(sql).Count() > 0;
            }
        }
    }
}
```

## Starting the Student Exercises API

Your instruction team will get you started on converting your student exercises command line app into an API that will respond to HTTP requests.

### Setting up Database

1. Generate a new Web API with `dotnet new webapi -o StudentExercises`
1. Copy the `StudentExercises.db` file from your command line application into the new `StudentExercises` directory that got created in the last step.
1. Use SQL Server Management Studio to create your tables for the student exercises database.
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
            "DefaultConnection": "Server=YourSQLServerName\\SQLEXPRESS;Database=StudentExercises;Trusted_Connection=True;"
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
