# Automated Testing

How do you know your code does what you think it does?

_You Test It!_

There are two basic approaches to testing.
1. Manual Testing - You or _**someone else**_ run the application and verify that it does what it's supposed to do.
1. Automated Testing - You _**write code**_ that runs your application and verifies that it does what it's supposed to do.

The trend in the industry is toward automated testing.

## Types of Automated Tests

There are two main types of automated testing.
1. Unit Testing - Testing individual classes or methods.
1. Integration Testing - Testing a complete request/response cycle. An integration test will use a literally visit a URL in the web application. It will fill out HTML forms, click buttons and follow links to make things happen in your application. Data will be read from and written to the database.

We will be covering integration tests in this chapter.

## Steps for each Automated Test

* Action - Each test should have the code required to test an action, or feature, of your program.
* Assert - What should be true, or what state should an object be in when code is executed.
* Arrange - Building out the classes and methods needed to make meet the assertion.


## Integration Testing in ASP<span></span>.NET Core MVC

https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-2.1


### Example

