# How to Start the API Sprint

## Setup

> **Alert:** One teammate should complete this entire setup process before anyone else does anything.

## Gitignore Setup

1. Clone repository
1. `touch README.md`
1. `touch .gitignore`
1. Open `.gitignore` in Visual Studio Code - not the full Visual Studio IDE
1. Visit [gitignore.io](https://www.gitignore.io/api/visualstudio) in your browser.
1. Copy the content there and paste it into your .`gitignore` file.
1. Go to the bottom of `.gitignore` file and add `appsettings.json`.
1. Save and quit VS Code

## Project Setup

Be in the root directory of your repo and run the following commands.

```sh
dotnet new webapi -n BangazonAPI
dotnet new sln -n BangazonAPI -o .
dotnet sln BangazonAPI.sln add BangazonAPI/BangazonAPI.csproj
cd BangazonAPI
dotnet add package Dapper
dotnet restore
```

Add. Commit. Push.

## Appsettings

Once the setup steps are complete, each teammate should pull down the new master. In the root directory, create your `appsettings.json` and paste in the following config.

Replace `YOUR-SQL-SERVER` with the name of your SQL Server on your machine.

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Server=YOUR-SQL-SERVER\\SQLEXPRESS;Database=BangazonAPI;Trusted_Connection=True;"
  }
}
```