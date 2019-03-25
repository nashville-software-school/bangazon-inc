# Automated Testing

## Overview

How do you know your code does what you think it does?

_You Test It!_

There are two basic approaches to testing.

### Manual Testing

You or _**someone else**_ uses the application and verify that it does what it's supposed to do. Usually a QA person will have a giant checklist of fetures to test and they will click, scroll and type into your app to make sure each feature works.

### Automated Testing

You _**write code**_ that runs your application and verifies that it does what it's supposed to do.

The trend in the industry is toward automated testing.

## Types of Automated Tests

There are two main types of automated testing.
1. Unit Testing - Testing individual classes or methods.
1. Integration Testing - Testing a complete request/response cycle. An integration test will use and literally visit a URL in the web application. It will fill out HTML forms, click buttons and follow links to make things happen in your application. Data will be read from and written to the database.

We will be covering integration tests in this chapter.

## Steps for each Automated Test

* Arrange - Building out the classes and methods needed to make meet the assertion.
* Act - Each test should have the code required to test an action, or feature, of your program.
* Assert - What should be true, or what state should an object be in when code is executed.


## Integration Testing in ASP.NET Core MVC

It's true that a human _could_ open a web browser and manually perform all the steps necessary to test all parts of a web application, but - like with many things - a computer can do it faster, with fewer mistakes, and without complaining about how boring it is to test and retest the same app all the time.


https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-2.1


## Example

Think waaaaaay back to when you learned React and consider the process of creating a new `Animal` resource in your `json-server` API.

First you needed to build a JSON representation of an animal that would be boarded in a kennel. Here's a basic version.

```js
const newAnimal = {
    "name": "Jack",
    "breed": "Cocker Spaniel",
    "age": 4,
    "hasShots": true
}
```

Then you had to perform an HTTP operation of type `POST` in order to save that resource in your API.

```js
fetch("http://localhost:3000/animals", {
    "method": "POST",
    "headers": {
        "Content-Type": "application/json"
    },
    "body": JSON.stringify(newAnimal)
})
```

## Process

What's happening during this process?

1. An HTTP client sends a `POST` request to the `/animal` route.
1. The `Post()` method of the `AnimalController` is called.
1. ADO.NET is used to insert the data into the corresponding Animal table in the database.
1. The primary key is returned from the operation and the `Id` property of the `Animal` object instance is updated with that new value.
1. The `CreatedAtRoute()` method is called in order the generate the new fully qualified URL of the resource that was just created (e.g. `http://localhost:5000/animal/8`).
1. A response is generated with a 200 status code by the `CreatedAtRoute()` method and flung back at the client.

The following test will mimic a client completing the create process and ensure that it works as expected.

```cs
[Fact]
public async Task Test_Create_Animal()
{
    /*
        Generate a new instance of an HttpClient that you can
        use to generate HTTP requests to your API controllers.
        The `using` keyword will automatically dispose of this
        instance of HttpClient once your code is done executing.
    */
    using (var client = new APIClientProvider().Client)
    {
        /*
            ARRANGE
        */

        // Construct a new student object to be sent to the API
        Student jack = new Student
        {
            Name = "Jack",
            Breed = "Cocker Spaniel",
            Age = 4,
            HasShots = true
        };

        // Serialize the C# object into a JSON string
        var jackAsJSON = JsonConvert.SerializeObject(jack);


        /*
            ACT
        */

        // Use the client to send the request and store the response
        var response = await client.PostAsync(
            "/api/animals",
            new StringContent(jackAsJSON, Encoding.UTF8, "application/json")
        );

        // Store the JSON body of the response
        string responseBody = await response.Content.ReadAsStringAsync();

        // Deserialize the JSON into an instance of Animal
        var newJack = JsonConvert.DeserializeObject<Animal>(responseBody);


        /*
            ASSERT
        */

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        Assert.Equal("Jack", newJack.Name);
        Assert.Equal("Cocker Spaniel", newJack.Breed);
        Assert.Equal(4, newJack.Age);
    }
}
```

## What is that ClientProvider?

Since these tests are being created and executed by Visual Studio, you need a client in order to make an HTTP request. Normally this is done via Chrome or Postman - both clients for an API. ASP.NET and C# provides some classes that allow you to create a client that can perform HTTP requests.

The following class should be added to your integration testing project for use in your testing classes.

> APIClientProvider.cs

```cs
using Microsoft.AspNetCore.Mvc.Testing;
using StudentExercisesAPI;
using System.Net.Http;
using Xunit;

namespace TestStudentExercisesAPI
{
    class APIClientProvider : IClassFixture<WebApplicationFactory<Startup>>
    {
        public HttpClient Client { get; private set; }
        private readonly WebApplicationFactory<Startup> _factory = new WebApplicationFactory<Startup>();

        public APIClientProvider()
        {
            Client = _factory.CreateClient();
        }

        public void Dispose()
        {
            _factory?.Dispose();
            Client?.Dispose();
        }
    }
}
```

## Required Packages

The following packages are needed to run integration tests with this code. You can use the command line (e.g. `dotnet add package Microsoft.AspNetCore.HttpsPolicy`) or use the Visual Studio window for managing packages.

```sh
Microsoft.AspNetCore
Microsoft.AspNetCore.HttpsPolicy
Microsoft.AspNetCore.Mvc
Microsoft.AspNetCore.Mvc.Testing
```

## Get All Animals

Testing GET operations are more straightforward. Perform a `GetAsync()` request to a resource URL, convert the response to C# and write a corresponding assertion

```cs
[Fact]
public async Task Test_Get_All_Animals()
{

    using (var client = new APIClientProvider().Client)
    {
        /*
            ARRANGE
        */


        /*
            ACT
        */
        var response = await client.GetAsync("/api/animals");


        string responseBody = await response.Content.ReadAsStringAsync();
        var animalList = JsonConvert.DeserializeObject<List<Animal>>(responseBody);

        /*
            ASSERT
        */
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.True(animalList.Count > 0);
    }
}
```

## Modify an Animal

To modify a resource with a PUT operation, you need to construct a new object instance that has the modified properties. Then you must convert that object into JSON and invoke the `PutAsync()` method to make the change.

In the example code below, the PUT operation is followed by a GET operation to ensure that the change was made.

```cs
[Fact]
public async Task Test_Modify_Animal()
{
    // New last name to change to and test
    int newAge = 5;

    using (var client = new APIClientProvider().Client)
    {
        /*
            PUT section
        */
        Animal modifiedJack = new Animal
        {
            Name = "Jack",
            Breed = "Cocker Spaniel",
            Age = newAge,
            HasShots = true
        };
        var modifiedJackAsJSON = JsonConvert.SerializeObject(modifiedJack);

        var response = await client.PutAsync(
            "/api/animals/1",
            new StringContent(modifiedJackAsJSON, Encoding.UTF8, "application/json")
        );
        string responseBody = await response.Content.ReadAsStringAsync();

        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);


        /*
            GET section
            Verify that the PUT operation was successful
        */
        var getJack = await client.GetAsync("/api/animals/1");
        getJack.EnsureSuccessStatusCode();

        string getJackBody = await getJack.Content.ReadAsStringAsync();
        Student newJack = JsonConvert.DeserializeObject<Animal>(getJackBody);

        Assert.Equal(HttpStatusCode.OK, getJack.StatusCode);
        Assert.Equal(newAge, newJack.Age);
    }
}
```


## Always Run the Tests

Now that you have a test that verifies that your create process works, it becomes trivial to run your test suite once you've built a new feature, or fixed a bug, and ensure that your changes did not break the application. Running the test suite in Visual Studio is as easy as opening the Test Explorer, clicking _Run all_ and seeing if your app still works as expected.

So before you submit a PR for your current feature branch, **always** run your test suite.
