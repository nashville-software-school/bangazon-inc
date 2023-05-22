# Web APIs

---

## Objectives

After completing this lesson you should be able to:

1. Define the terms Web API, API and UI. amd compare and contrast them.
1. Give examples of Web APIs, APIs that are not web-based and UIs.
1. Give a one sentence definition of ASP<span>.</span>NET Core Web API.

---

Before we talk about building Web APIs in ASP<span>.NET</span> Core, let's take a moment to talk about APIs more generally.

An API is an "Application Programming Interface". An API can be compared to a UI (User Interface). A UI consists of components such as textboxes, buttons, menus, paragraphs of information, etc... that a human uses to interact with software. For example, in a Dog Walking MVC application a user may enter dog information into a form and click a submit button in order to save a new dog to the database.

An API, in contrast, is a software interface that _other software uses to interact with a system_. In this course we focus on Web APIs. These are APIs that are accessible via HTTP requests. For example, imagine a Dog Walker application written in React. In such an app, we might build a form using React components that use JavaScript code to make a `fetch()` call to a Web API to save a Dog. In this case we write JavaScript code that interacts with a Web API.

> **NOTE:** An example of a "non-web" API is ADO<span>.NET</span>. ADO<span>.NET</span> gives us an API for interacting with a database from our C# code.

## `json-server`

In the client side course, you learned how to create a JSON based Web API using `json-server`.

Let's consider `json-server` for a moment. It's a pretty impressive application, isn't it? It reads a JSON file and dynamically generates Web API _endpoints_ for the resources in that file. All we have to do to use it is create a JSON file and run `json-server` from the command line. The code in the `json-server` application handles responding to `GET`, `POST`, `PUT`, `PATCH` and `DELETE` requests and performing the appropriate CRUD operations in the JSON file.

As impressive as `json-server` is, however, it has limitations. Firstly, it does not allow us to store our data in a real database. Storing data in a JSON file is great if your app is only going to be used by one person at a time and doesn't have a lot of data, but once you want to put a web application in production to be used by several people and with real-world data, you need a real database like SQL Server.

Secondly, `json-server` will only perform simple CRUD operations to our data. We cannot add _logic_ to the `json-server` API. For example, imagine we'd like to verify that a Dog is not already in the database before we save it. `json-server` will not help us. We will be forced to download the entire list of Dogs and search through it in our JavaScript code. This is, at best, inefficient and, at worst, a security concern since we are potentially downloading sensitive data to the user's browser.

## ASP<span>.NET</span> Core Web API

So how do we overcome the issues of `json-server`? We write our own Web API! Instead of the dynamically generated, but limited `json-server`, we create a custom application that is built specifically for our data and our business rules.

With ASP<span>.NET</span> Core, you can use the Web API project type to actually build business logic into your API. In the next chapter, we'll do just that. Along the way we'll see that Web API has many similarities to MVC. Much of what we learned in MVC will transfer. In fact, it could be argued that Web API is essentially MVC without Views.

<<<<<<< HEAD
## Resources

1. [Create a Web API with ASP.NET Core and Visual Studio](https://docs.microsoft.com/en-us/aspnet/core/tutorials/first-web-api) - This tutorial uses Entity Framework (which we will cover later), but still is a good tutorial to see how everything works.
=======

>>>>>>> master
