# Identity Framework

Identity Framework in .NET allows you to easily add authentication to your ASP.NET MVC application.

Follow the steps in the [Introduction to Identity on ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/identity?view=aspnetcore-2.1&tabs=visual-studio) tutorial to see how easily you can create an application that has register, log in, and log out automatically scaffolded for you.

Once you complete that short tutorial, you should skip directly to the [Add custom user data to the Identity DB](https://docs.microsoft.com/en-us/aspnet/core/security/authentication/add-user-data?view=aspnetcore-2.1&tabs=visual-studio#add-custom-user-data-to-the-identity-db) section to see how to _extend_ the basic **`IdentityUser`** model to add more information.

## Scaffolding for ASP.NET Core 2.1

```sh
dotnet tool install -g dotnet-aspnet-codegenerator
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
```

Then open your `.csproj` file and add the following section.

```xml
<ItemGroup>
    <DotNetCliToolReference Include="Microsoft.VisualStudio.Web.CodeGeneration.Tools" Version="2.1.0-preview1-final" />
</ItemGroup>
```

Then restore the packages and run the generator to create your user class and corresponding views.

```sh
dotnet restore
dotnet aspnet-codegenerator identity -u ApplicationUser -fi Account.Register
dotnet aspnet-codegenerator identity -u ApplicationUser -fi Account.Manage.Index
```

1. Remove the `Areas/Identity/Pages/Data` directory
1. Remove the `Areas/Identity/ProjectStart.cs` file
1. Create `Models.ApplicationUser` and add the additional properties.
1. Update `Register.cshtml.cs`, `Register.cs` with
    1. Update `using` statement to your Models namespace
    1. Update `InputModel` with corresponding properties
    1. Update `OnPostAsync` with corresponding properties
1. Update `Views/Shared/_LoginPartial.cshtml` to use the `ApplicationUser` instead of `IdentityUser`