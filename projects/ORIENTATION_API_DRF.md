# Bangazon Orientation API (Django REST Framework Edition)

## Prerequisites

1. .NET Core [installed](https://www.microsoft.com/net/core#macos).
1. [Visual Studio Code](https://code.visualstudio.com/), or [Visual Studio Community Edition](https://www.visualstudio.com/vs/community/) installed for existing Windows users.
1. Yeoman, and the ASP.NET generator, installed: `npm install -g yo generator-aspnet`

## What You Will Be Learning

### project.json

With the release of .NET Core, the .NET platform now more closely adheres to conventions that have been adopted by the OSS community. Once of those conventions is storing project-related settings and configuration in JSON format instead of XML format.

You will understand the structure of the `project.json` file, and how to use it to install dependencies for your project, along with the `dotnet restore` command.

### Controllers

ASP.NET makes heavy use of decorators and conventions to abstract away much of the heavy lifting that is required to build an API. By using these Magical Abstractions, far less coding and configuration is needed from an API developer.