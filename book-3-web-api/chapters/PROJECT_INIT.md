# Starting a Project

Choose one teammate to perform all of these steps on a branch. No one else on the team should do **ANY WORK** until this entire procedure is completed.

## Create Github Repo

1. Create a new Github repository
1. Choose `Visual Studio` from the options for a .gitignore

## Create Local Solution

Replace `<url>` below with the connection string from Github. Also note that the period at the end of the `git clone` command is **not a mistake**.

```sh
mkdir ~/workspace/csharp/StudentExercisesIdentity && cd $_
git clone <url> .
dotnet new mvc -n StudentExercisesIdentity --auth Individual
dotnet new sln -n StudentExercisesIdentity -o .
dotnet sln StudentExercisesIdentity.sln add StudentExercisesIdentity/StudentExercisesIdentity.csproj
```

## appsettings.json Template

Your `appsettings.json` should be ignored since each teammate's connection string will be different. By copying the file as template, this ensures that each person who clones your repository will get a file to be modified for their own machine.

```sh
cp Bangazon/appsettings.json Bangazon/appsettings.json.template
echo 'appsettings.json' >> .gitignore
echo '*.db' >> .gitignore
```

Just make sure you include instructions on how to do this in your README.

For example...

> To connect to your own database, run the following command in your terminal and modify the connection string to point to your local SQL Server Express instance
>
>    `cp appsettings.json.template appsettings.json`


By default, your `appsettings.json` file has a connection string to a SQLite database. Update it to connect to your SQL Server instance.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=YourServerHere\\SQLEXPRESS;Database=BangazonSite;Trusted_Connection=True;"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

## Add Entity Framework Tooling

In order to create your database from the command line, you need to install a specific package from NuGet.

```sh
cd Bangazon
dotnet add package Microsoft.EntityFrameworkCore.Tools.DotNet
dotnet ef database update
```

Once those commands are run, then you will have a basic database structure that enabled user authentication.
