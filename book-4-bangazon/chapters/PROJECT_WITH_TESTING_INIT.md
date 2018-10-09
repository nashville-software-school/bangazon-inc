# Starting a Project with a Test Suite

```sh
mkdir ~/workspace/csharp/BangazonSite && cd $_
dotnet new mvc -n Bangazon
dotnet new xunit -n BangazonTests
dotnet new sln -n Bangazon -o .
dotnet sln Bangazon.sln add Bangazon/Bangazon.csproj
dotnet sln Bangazon.sln add BangazonTests/BangazonTests.csproj
```

[![](./assets/projectsetup.png)](https://youtu.be/sI2SMfG7DiU)

