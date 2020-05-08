# How to Start the API Sprint

> **Alert:** One teammate should complete this entire setup process before anyone else does anything.


## Via Visual Studio

### Create API Project and Solution

1. Launch Visual Studio
1. File > New > Project...
1. Select **.NET Core** on the left menu.
1. Select **ASP.NET Core Web Application** from the list of options that appears.
1. Check `Create Git repository`
1. In the name field, type `BangazonAPI`, then click Next.
1. Uncheck `Configure for HTTPS`
1. Choose **API** from the current list of options, then click Ok.

### Update appsettings

Replace what's in your `appsettings.json` file with this.

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=BangazonAPI;Trusted_Connection=True;"
  }
}
```

### Create Testing Project

1. Right-click the solution file.
1. Select _Add > New Project_
1. Make sure **.NET Core** is selected on the left menu.
1. Choose _xUnit Test Project_ from the list of options.
1. In the name field, type `TestBangazonAPI`, then click Ok.

### Push the Changes

Add. Commit. Push.

## Via the Command Line

If you are comfortable on the command line and would like to set up your project using the `dotnet` commands, then follow these steps.

### Project and Solution Commands

Be in the root directory of your repo and run the following commands to create the projects and the solution file.

```sh
dotnet new webapi -n BangazonAPI
dotnet new xunit -n TestBangazonAPI
dotnet new sln -n BangazonAPI -o .
dotnet sln BangazonAPI.sln add BangazonAPI/BangazonAPI.csproj
dotnet sln BangazonAPI.sln add TestBangazonAPI/TestBangazonAPI.csproj
```

### Gitignore Setup

Run the following command. It will create a `.gitignore` file and place the standard Visual Studio ignore content into it.

```sh
curl https://www.gitignore.io/api/visualstudio > .gitignore
```

### SQL Package

Install package to let you connect to SQL Server.

```sh
cd BangazonAPI
dotnet add package System.Data.SqlClient
dotnet restore
```

### 3rd Party Package Installation

Now you need to install the packages needed for the integration testing project.

```sh
cd ../TestBangazonAPI
dotnet add package Microsoft.AspNetCore
dotnet add package Microsoft.AspNetCore.HttpsPolicy
dotnet add package Microsoft.AspNetCore.Mvc
dotnet add package Microsoft.AspNetCore.Mvc.Testing
dotnet restore
```

### Update App Settings

Now you can go back to the root directory and start Visual Studio with this solution loaded.

```sh
cd..
start BangazonAPI.sln
```

Once started, open your `appsettings.json` file and replace what is there with the following settings.

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=BangazonAPI;Trusted_Connection=True;"
  }
}
```

### Push the Changes

Add. Commit. Push.

## SQL

All teams must use the [bangazon.sql](./sql/bangazon.sql) script to populate their database. Do not use one of yours.
