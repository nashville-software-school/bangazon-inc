# Automated Testing

## Example Repo

https://github.com/nashville-software-school/csharp-mvc-integration-tessting

The above repository contains a solution with two projects
* An MVC application project
* An integration test project

Pull down the repo, run th epp, run the tests, and read through the code. You'll find lots of comments in the Integration Test project that should describe what's going on.

## Overview

How do you know your code does what you think it does?

_You Test It!_

There are two basic approaches to testing.
1. Manual Testing - You or _**someone else**_ uses the application and verify that it does what it's supposed to do.
1. Automated Testing - You _**write code**_ that runs your application and verifies that it does what it's supposed to do.

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


## Integration Testing in ASP<span></span>.NET Core MVC

It's true that a human _could_ open a web browser and manually perform all the steps necessary to test all parts of a web application, but - like with many things - a computer can do it faster, with fewer mistakes, and without complaining about how boring it is to test and retest the same app all the time.


https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests


## Example

Consider the process of creating a new student.

1. Navigate to the create page at `/comedian/create`
1. Enter the first and last names, and the birth and death dates.
1. Select a group from the "Member of" dropdown.
1. Click the `Create` button.
1. Wait for the index page to appear and note the new comedian in the list.

![Create Comedian](./images/CreateComedian.gif)

What's happening during this process?
1. An HTTP client sends a `GET` request to `/comedian/create`.
1. The `Create()` method of the `ComedianController` is called. This method creates a ViewModel that contains the list of Groups for the Create view's "Member of" dropdown, and passes that ViewModel to the Create view.
1. The Create view, `create.cshtml`, uses the ViewModel to generate HTML that is sent to the client.
1. A user fills out the HTML form and clicks the `Create` button.
1. The HTTP client sends a `POST` request to `/comedian/create`.
1. The `Create(ComedianCreateViewModel model)` method of the `ComedianController` is called. This method inserts a new Student into the database, then redirects the HTTP client to the `/comedian` URL.
1. The request to `/comedian` causes the `Index()` method of the `ComedianController` to be called. This method gets all comedians from the database, makes and instance of a `ComedianListViewModel` for each comedian, and passes that list to the Index view.
1. The Index view `index.cshtml` uses the list of `ComedianListViewModel`s to generate HTML that is sent to the client.
1. The user sees that the comedian they added is in the list of all comedians.

> **NOTE:** The above process is clearly a **lot**, but it's worth taking some time to read through it. Once you grasp this process, you'll have a solid foundation for understanding web applications.

The following test will mimic a user completing thc create process and ensure that it works as expected.

```cs
[Fact]
public async Task Post_CreateMakesNewComeidan()
{
    // Arrange

    // Get a group from the database
    //  This will be the new comedian's group.
    Group group = Database.GetAllGroups().First();

    // Create variables containing the new comedian's data.
    // NOTE: all of the variables MUST be strings

    // We use Guids in order to ensure that the first and last names will be
    //  unique in the database. A Guid is a "globally unique identifier".
    string firstName = "firstname-" + Guid.NewGuid().ToString();
    string lastName = "lastname-" + Guid.NewGuid().ToString();

    // For dates we use the .ToString("s") to create "sortable" DateTime strings.
    //  This is the format that the AngleSharp library expects and may be different
    //  from the format you use when manually filling out the form.
    //  The DateTime string will be something like: "1918-11-23T00:00:00"
    string birthDate = DateTime.Today.AddYears(-100).ToString("s");
    string deathDate = DateTime.Today.AddYears(-20).ToString("s");

    // String representation of the group's id.
    string groupId = group.Id.ToString();
    // We'll use the group name in our assertions below.
    string groupName = group.Name;

    // Make a GET request to get the page that contains the Create form.
    //  We must have the create form in order to make the POST request later.
    string url = "/Comedian/Create";
    HttpResponseMessage createResponse = await _client.GetAsync(url);
    IHtmlDocument createDom = await HtmlHelpers.GetDocumentAsync(createResponse);


    // Act

    // Make the POST request providing the create form and the values for the form inputs.
    //  The values for the form inputs are passed in as a Dictionary whose keys and values
    //   are strings.
    //  The keys of the dictionary are the HTML IDs of the input. Use your browser's 
    //   developer tools to find the ID for each input.
    HttpResponseMessage response = await _client.SendAsync(
        createDom,
        new Dictionary<string, string> {
            { "Comedian_FirstName", firstName },
            { "Comedian_LastName", lastName },
            { "Comedian_BirthDate", birthDate },
            { "Comedian_DeathDate", deathDate },
            { "Comedian_GroupId", groupId },
        }
    );

    // The response object above should be the comedian's index page.

    // Assert
    // Convert the repose to the index page DOM-like object.
    IHtmlDocument indexDom = await HtmlHelpers.GetDocumentAsync(response);

    // Verify that there is a <td> on the page that contains the data for the
    //  newly inserted comedian.
    Assert.Contains(
        indexDom.QuerySelectorAll("td"),
        td => td.TextContent.Contains(firstName));
    Assert.Contains(
        indexDom.QuerySelectorAll("td"),
        td => td.TextContent.Contains(lastName));
    Assert.Contains(
        indexDom.QuerySelectorAll("td"),
        td => td.TextContent.Contains(groupName));
}
```
