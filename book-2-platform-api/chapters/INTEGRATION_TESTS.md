# Automated Testing

## Example Repo

https://github.com/nashville-software-school/csharp-api-integration-testing

The above repository contains a solution with two projects

* An MVC application project
* An integration test project

Pull down the repo, run the application, run the tests, and read through the code. You'll find lots of comments in the Integration Test project that should describe what's going on.

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

Now, you haven't built a React client to interact with this Kennel API, so you can use Postman to do the same operation now.

_insert gif of using Postman here_

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
public async Task Test_Create_Student()
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
        Student helen = new Student
        {
            FirstName = "Helen",
            LastName = "Chalmers",
            CohortId = 1,
            SlackHandle = "Helen Chalmers"
        };

        // Serialize the C# object into a JSON string
        var helenAsJSON = JsonConvert.SerializeObject(helen);


        /*
            ACT
        */

        // Use the client to send the request and store the response
        var response = await client.PostAsync(
            "/api/students",
            new StringContent(helenAsJSON, Encoding.UTF8, "application/json")
        );

        // Store the JSON body of the response
        string responseBody = await response.Content.ReadAsStringAsync();

        // Deserialize the JSON into an instance of Student
        var newHelen = JsonConvert.DeserializeObject<Student>(responseBody);


        /*
            ASSERT
        */

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        Assert.Equal("Helen", newHelen.FirstName);
        Assert.Equal("Chalmers", newHelen.LastName);
        Assert.Equal("Helen Chalmers", newHelen.SlackHandle);
    }
}
```

## Always Run the Tests

Now that you have a test that verifies that your create process works, it becomes trivial to run your test suite once you've built a new feature, or fixed a bug, and ensure that your changes did not break the application. Running the test suite in Visual Studio is as easy as opening the Test Explorer, clicking _Run all_ and seeing if your app still works as expected.

So before you submit a PR for your current feature branch, **always** run your test suite.

_Insert gif for running tests in Test Explorer_