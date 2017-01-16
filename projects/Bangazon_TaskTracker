# Bangazon TaskTracker

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [Resources](#resources)

## Prerequisites

### .NET Core

* .NET Core [installed](https://www.microsoft.com/net/core#macos).
* [Visual Studio Code](https://code.visualstudio.com/), or [Visual Studio Community Edition](https://www.visualstudio.com/vs/community/) installed for existing Windows users.
* For Code users, [install the C# extension](#installing-c-extension-for-code).
* Yeoman, and the ASP.NET generator, [installed](#installing-yeoman-and-the-aspnet-generator) 

### .Net 4.5+

* [Visual Studio Community Edition](https://www.visualstudio.com/vs/community/) installed

## What You Will Be Learning

### Annotations, Routing and DI

ASP.NET makes heavy use of [annotations](https://docs.asp.net/en/latest/data/ef-mvc/complex-data-model.html?highlight=annotation), [routing](https://docs.asp.net/en/latest/mvc/controllers/routing.html) and [dependency injection](https://docs.asp.net/en/latest/mvc/controllers/dependency-injection.html) to abstract away much of the heavy lifting that is required to build an API. By using these Magical Abstractions, far less coding and configuration is needed from an API developer.

### Models

You will define models, which are abstractions to the actual database. The model defines a table, validations on the columns in the table, and also the relationship between tables.

### Migrations

You will be using [migrations](https://docs.asp.net/en/latest/data/ef-mvc/migrations.html#migrations) in Entity Framework to handle changes and updates to your database.

### Controllers

You will learn about what role a controller has in an API, how it uses models and validates a request against the model, and how to use LINQ to get data from your database.

## Requirements

### API

1. Scaffold a basic WebAPI project.
1. Define a model and API controller for a Task.  The model should have at least the following fields:

    | Field       | Data Type                         | Required |
    |-------------|-----------------------------------|----------|
    | Id          | number                            |     ✓    |
    | Name        | text                              |     ✓    |
    | Description | text                              |          |
    | Status      | enum (ToDo, InProgress, Complete) |     ✓    |
    | CompletedOn | date                              |          |

1. Controllers may not return a view.
1. API Consumers should be able to create a new task.
1. API Consumers should be able to update a task's Name, Description and Status.
1. Validation should be performed.  Requests that fail validation should return the appropriate [HTTP Status Code](http://httpstatusrappers.com/).
1. The CompletedOn date should be updated to the current date when Status is set to complete.
1. API Consumers should be able to request a list of tasks by priority.
1. Generate API documentation with enough detail for a teammate to build a UI without any other knowledge.

### UI

1. Create a simple Angular frontend.
1. Users should be able to create a new task.
1. Users should be able to update a task's Name, Description and Status.
1. Validation should be performed.
1. Users should be able to view a list of tasks by Priority.
1. Users should be able to view a list of tasks by Status.
1. Users should be able to view a list of tasks by CompletedOn.

## Resources

### Installing C# Extension for Code

You install this extension by pressing `F1` to open the VS Code palette. Type `ext install` to see the list of extensions. Select the C# extension.

### Installing Yeoman and the ASPNET Generator

Both of these are `npm` packages, and global installations at that, so run this command in your terminal.

```
npm install -g yo generator-aspnet
```
