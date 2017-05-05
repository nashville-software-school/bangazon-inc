

Visual Studio Code setup with .NET Core
---------------------------------------


1. Download [Visual Studio Code](https://code.visualstudio.com/Download). When you open the program for the first time, use the extensions section on the left bar to find the C# extension. This extension will give you syntax highlighting. 
2. Download [.NET Core](https://www.microsoft.com/net/core). Windows users, follow the directions in the NOTE: section and don't download Visual Studio
3. To verify it all worked successully, completely quit your terminal, then open an new terminal window. Create a new folder and `cd` into it. Inside this folder, enter the command `dotnet new`. If this command executes without any errors, you have successfully installed .NET Core. Use `dotnet restore` and then `dotnet run` to see "Hello World" in your console. 


----------


 In order to use Yeoman to scaffold .NET Core applications, follow the directions below:
 
 1. `npm install -g yo bower grunt-cli gulp`  This command will install or update Yeoman, Bower, Grunt, and Gulp. 
 2. `npm install -g generator-aspnet` This command will install the yeoman generator for .NET Core applications
 3. In your terminal, make a new folder and `cd` into it. Type `yo aspnet`. This should open a menu. Choose the type of .NET Core application you would like to build, then name your application. Finish up by running a `dotnet restore` and `dotnet run` in your terminal.