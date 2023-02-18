# ASP<span>.NET</span> Core Web API

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Compare and contrast ASP<span>.</span>NET Core Web API with ASP<span>.</span>NET Core MVC.
1. Describe the HTTP method and the URL associated with each method in a Web API Controller.
1. Describe the C# `var` keyword.
1. Give a high-level definition of CORS.
1. Write an ASP<span>.</span>NET Core Web API that will perform all CRUD operations on a simple entity.
1. Write a simple HTML/JavaScript client application that will communicate with a Web API.
1. Test a Web API using Postman.
1. Translate (rewrite) code that uses the `var` keyword into code that does not use it.
1. Disable CORS for an ASP<span>.</span>NET running in a Development environment.

---

In this chapter we'll walk through creating a "Coffee Shop" Web API in ASP<span>.NET</span> Core. When it's complete our API will expose resources for `Coffee` and `BeanVariety`.

* Coffee - https://localhost:5001/api/coffee
* BeanVariety - https://localhost:5001/api/beanvariety

## Project Setup

1. Open Visual Studio
1. Select "Create a new project"
1. Choose the C# "ASP<span>.NET</span> Core Web API" option
1. Name the project "CoffeeShop"
1. Select ".NET 6.0" for the "Target Framework" and click "Create"

You now have an ASP<span>.NET</span> Core Web API project. Spend some time looking around the code that Visual Studio generated. You'll find several familiar items.

## Models

In this chapter we'll be focused on the `BeanVariety` entity and you'll work with the `Coffee` entity in the exercise.

Models (a,k.a _data models_) in Web API are simple classes containing properties that correspond to columns in a database table.

Create a `Models` folder and add a `BeanVariety` class.

> Models/BeanVariety.cs

```cs
using System.ComponentModel.DataAnnotations;

namespace CoffeeShop.Models
{
    public class BeanVariety
    {
        public int Id { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Name { get; set; }

        [Required]
        [StringLength(255, MinimumLength = 3)]
        public string Region { get; set; }

        public string Notes { get; set; }
    }
}
```

## Repositories

We can use the [Repository Pattern](https://www.c-sharpcorner.com/article/repository-pattern-with-ado-net-in-mvc/) when building a Web API just as we did with MVC and console applications.

Create a `Repositories` directory and a `BeanVarietyRepository` class.

> Repositories/BeanVarietyRepository.cs

```cs
using CoffeeShop.Models;

namespace CoffeeShop.Repositories
{
    public class BeanVarietyRepository
{
    private static List<BeanVariety> _beanVarieties = new List<BeanVariety>() 
    { 
        new BeanVariety() {Id = 1, Name = "Arusha", Region = "Mount Meru in Tanzania, and Papua New Guinea", Notes = null},
        new BeanVariety() {Id = 2, Name = "Benguet", Region = "Philippines", Notes = "Typica variety grown in Benguet in the Cordillera highlands of the northern Philippines since 1875."},
        new BeanVariety() {Id = 3, Name = "Catuai", Region = "Latin America", Notes = "This is a hybrid of Mundo Novo and Caturra bred in Brazil in the late 1940s."},
        new BeanVariety() {Id = 4, Name = "Typica", Region = "Worldwide", Notes = " 	Typica originated from Yemeni stock, taken first to Malabar, India, and later to Indonesia by the Dutch, and the Philippines by the Spanish"},
        new BeanVariety() {Id = 5, Name = "Ruiru 11", Region = "Kenya", Notes = "Ruiru 11 was released in 1985 by the Kenyan Coffee Research Station. While the variety is generally disease resistant, it produces a lower cup quality than K7, SL28 and 34"},
    };

    public List<BeanVariety> GetAll()
    {
        return _beanVarieties;
    }

    public BeanVariety Get(int id)
    {
        return _beanVarieties.Find(x => x.Id == id);
    }

    public void Add(BeanVariety variety)
    {
         var newId = GetNextId(); 
        variety.Id = newId;
        _beanVarieties.Add(variety);
    }

    public void Update(BeanVariety variety)
    {
       var foundBeanVariety = _beanVarieties.Find(b => b.Id == variety.Id);
        if (foundBeanVariety != null)
        {
            _beanVarieties.Remove(foundBeanVariety);
            _beanVarieties.Add(variety);
        }
    }

    public void Delete(int id)
    {
        _beanVarieties.Remove(Get(id));
    }
    
    private int GetNextId()
    {
        return _beanVarieties.Max(x => x.Id) + 1;
    }
}
}
```

> **NOTE:** Look closely at the code above. Do you notice anything different? Yes, we're using the ["var" keyword](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/implicitly-typed-local-variables). Happy day!

### `IBeanVarietyRepository`

1. Use the `Extract Interface...` feature of Visual Studio to create the `IBeanVarietyRepository` interface.  Do this by right-clicking on the name of the `BeanVarietyRepository` class, choosing `Quick Actions and Refactoring` (the lightbulb option), and then choosing `Extract Interface...`.  Choose `OK` on the dialog that pops up.
2. Update `Program.cs` class to register your new repository with ASP<span>.</span>NET. Add this line of code in the same area with other lines starting `builder.Services`, before the line of code `var app = builder.Build()`.

    ```cs
    builder.Services.AddTransient<IBeanVarietyRepository, BeanVarietyRepository>();
    ```
Registering a service in your application means that the instantiation of that registered Type will be automatically handled and you don't need to 'new up' any repositories yourself.  Trust us, it's a good thing and it makes your app run better.


## Controllers

Controllers in Web API contain methods to respond to HTTP requests.  The job of the controller is to construct and return a response to an HTTP request.  It's the basic logic of your API.

Create a `BeanVarietyController` class in the `Controllers` directory.

1. Right-click on the `Controllers` folder in the Solution Explorer and select `Add` -> `Controller...`.
1. In the dialog box that appears, select `API` on the left panel.
1. Next select `API Controller - Empty` in the center panel.
1. Name it `BeanVarietyController`
1. Finally click the `Add` button

> Controllers/BeanVarietyController.cs

```cs
using Microsoft.AspNetCore.Mvc;
using CoffeeShop.Models;
using CoffeeShop.Repositories;

namespace CoffeeShop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeanVarietyController : ControllerBase
    {
        private readonly IBeanVarietyRepository _beanVarietyRepository;
        public BeanVarietyController(IBeanVarietyRepository beanVarietyRepository)
        {
            _beanVarietyRepository = beanVarietyRepository;
        }

        // https://localhost:5001/api/beanvariety/
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(_beanVarietyRepository.GetAll());
        }

        // https://localhost:5001/api/beanvariety/5
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var variety = _beanVarietyRepository.Get(id);
            if (variety == null)
            {
                return NotFound();
            }
            return Ok(variety);
        }

        // https://localhost:5001/api/beanvariety/
        [HttpPost]
        public IActionResult Post(BeanVariety beanVariety)
        {
            _beanVarietyRepository.Add(beanVariety);
            return CreatedAtAction("Get", new { id = beanVariety.Id }, beanVariety);
        }

        // https://localhost:5001/api/beanvariety/5
        [HttpPut("{id}")]
        public IActionResult Put(int id, BeanVariety beanVariety)
        {
            if (id != beanVariety.Id)
            {
                return BadRequest();
            }

            _beanVarietyRepository.Update(beanVariety);
            return NoContent();
        }

        // https://localhost:5001/api/beanvariety/5
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _beanVarietyRepository.Delete(id);
            return NoContent();
        }
    }
}
```

One key difference is a Web API controller uses all the familiar HTTP verbs that `json-server` used.

* `GET` for retrieving one or more entities
* `POST` for creating a new entity
* `PUT` for updating an entity
* `DELETE` for removing an entity

In the controller above note that we decorate each method (a.k.a. _controller action_) with an attribute that denotes the HTTP verb that method responds to.

```cs
// https://localhost:5001/api/beanvariety/
[HttpGet]
public IActionResult Get() { /* omitted */ }

// https://localhost:5001/api/beanvariety/5
[HttpGet("{id}")]
public IActionResult Get(int id) { /* omitted */ }

// https://localhost:5001/api/beanvariety/
[HttpPost]
public IActionResult Post(BeanVariety beanVariety) { /* omitted */ }

// https://localhost:5001/api/beanvariety/5
[HttpPut("{id}")]
public IActionResult Put(int id, BeanVariety beanVariety) { /* omitted */ }

// https://localhost:5001/api/beanvariety/5
[HttpDelete("{id}")]
public IActionResult Delete(int id) { /* omitted */ }
```

Some of the `[HttpXXX]`attributes refer to `{id}`. The `id` in this case says this method expects the URL to contain a _route parameter_ with the bean variety's `id`. For example in order to delete the bean variety with an `id` of `42` we would make a `DELETE` request to this URl:

> https://localhost:5001/api/beanvariety/42

Two common methods are `Ok()` and `NoContent()`. `Ok()` is used when we want to return data. `NoContent()` is used to indicate that the action was successful, but we don't have any data to return.

## Invoking a Web API

### Postman

To test a Web API we use the popular [Postman](https://www.postman.com/) tool.

![Postman](./images/postman_web_api.gif)

### JavaScript

The whole point of building an API is to provide an _interface_ for other code to call into, so it makes perfect sense that we'd want to call our web API from JavaScript.

Create a directory called `js-app` in the root directory of your solution (the directory that contains the `CoffeeShop.sln` file). Add the following HTML and JavaScript files to the `js-app` directory.

> **NOTE:** While it's technically true that Visual Studio will let you edit JavaScript, HTML and CSS, it's not really the best tool for front-end development. For front-end work you should switch back to Visual Studio Code.

> js-app/index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Coffee Shop</title>
</head>
<body>
   <button id="run-button">Run It!</button>
   <script src="main.js"></script>
</body>
</html>
```

> js-app/main.js

```js
const url = "https://localhost:5001/api/beanvariety/";

const button = document.querySelector("#run-button");
button.addEventListener("click", () => {
    getAllBeanVarieties()
        .then(beanVarieties => {
            console.log(beanVarieties);
        })
});

function getAllBeanVarieties() {
    return fetch(url).then(resp => resp.json());
}
```

Run the app with `serve`

```sh
npx serve -l 3000 .
```

> **NOTE:** The default port for `serve` is `5000`, but our an ASP<span>.NET</span> app is already running on ports `5000` and `5001`, so we use the `-l` (a.k.a. _listen_) flag to tell `serve` to use port `3000`.

Open the console and then click the `Run It!` button. What do you see?

That's right...a "CORS" error.

```txt
Access to fetch at 'https://localhost:5001/api/beanvariety/' from origin 'http://localhost:3000' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource. If an opaque response serves your needs, set the request's mode to 'no-cors' to fetch the resource with CORS disabled.
```

[CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/Errors) is a browser security feature that prevents JavaScript from talking to APIs without the web server's consent. CORS is extremely important for production applications, but in development we can afford to be a bit more lax. Update `Program.cs` to call `app.UseCors()` to configure CORS behavior.

```cs
using CoffeeShopAPI.Repository;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddTransient<IBeanVarietyRepository, BeanVarietyRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    
    // Do not block requests while in development
    app.UseCors(options =>
    {
        options.AllowAnyOrigin();
        options.AllowAnyMethod();
        options.AllowAnyHeader();
    });
    
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

        
```

Return to the test web page and click the button again. You should see bean variety data print in the console.

---

## Exercises

1. Create the CoffeeShop project outlined in this chapter.
1. Create the necessary classes (model, repository and controller) to implement full CRUD functionality for the `/api/coffee` endpoint. Use Postman or Swagger to test the endpoint.
    * **NOTE:** Your `Coffee` model should contain both `BeanVarietyId` and `BeanVariety` properties.
1. Update the JavaScript and HTML to display all bean varieties in the DOM when the "Run It!" button is clicked.
1. Update the JavaScript and HTML with a form for adding a new bean variety to the database.

### Challenge

1. Update the JavaScript and HTML to allow a user to perform full CRUD functionality for the Coffee resource.
