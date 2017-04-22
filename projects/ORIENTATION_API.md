# Bangazon Orientation API

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [PowerUps](#powerups)

## Prerequisites

* [Visual Studio Community Edition](https://www.visualstudio.com/vs/community/) installed for existing Windows users.


## What You Will Be Learning

### ERD

Entity Relationship Diagrams are visual representations of your database structure, and relationships between data. You will build an ERD that represents the first version of your database.

### Attribute Routing

ASP.NET makes heavy use of [attribute routing](https://docs.microsoft.com/en-us/aspnet/web-api/overview/web-api-routing-and-actions/attribute-routing-in-web-api-2) to abstract away much of the heavy lifting that is required to build an API. By using these Magical Abstractions, far less coding and configuration is needed from an API developer.

### Dependency Injection / Inversion of Control

Dependency Injection allows you to depend solely on abstractions in your classes.  This enhances testability and lets you focus on writing the code for just the class you're currently working on.  It also allows you to abstract away a lot of the configuration of how to build things.  You will use [StructureMap](http://structuremap.github.io/documentation/) to inject dependencies into all your classes.  

Install the StructureMap.WebApi2 package to get started.

### Models

You will define models, which are abstractions to the actual database. The model reflects the underlying table's columns and structure

### WebApi Controllers

You will learn about what role a controller has in an API, how it uses models and validates a request against the model, and an introduction to LINQ to get data from your database.


## Requirements

1. Create an empty Web API project.
1. Define tables, models and controllers for the following resources.
    1. Customer
    1. Order
    1. Product
    1. LineItem
1. Ensure that you have annotations on your models to verify the model is valid when it comes into the API.
1. Create repositories for data access.

## Powerups

### Use Dapper for Data Access

[Dapper](https://github.com/StackExchange/Dapper/blob/master/Readme.md) is a Micro ORM that allows you to interact more directly with the database than Entity Framework, but still will map your query results into objects for you, saving you from a lot of ExecuteReader madness.  Use Dapper by taking a dependency on an IDbConnection and using the Dapper extension methods.
