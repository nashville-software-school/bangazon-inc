
# Installing required software

<!-- ## 1. Install .NET Core

1. Visit the [.NET Tutorial](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/intro) site, click on your OS and follow the steps to install .NET Core.
1. In your terminal go to your `workspace` directory and do steps 2 and 3 in the tutorial to verify everything works. -->

## 1. .NET

1. Install .NET 5 from [here](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-5.0.405-windows-x64-installer)
   * Run the program once it is downloaded
1. Open a terminal and run `dotnet --version`. You should see a version equal to `5.0.405`

## 2. Setting .NET 5 as the SDK version 

When you installed Visual Studio 2022, it also installed .NET 6. .NET 6 is great, but the curriculum was written with .NET 5 in mind, and the two are different enough that we will be using 5.

Run the following command in your terminal:

```sh
echo $'{
   "sdk": {
      "version": "5.0.408"
   }
}' > ~/global.json
```


## 3. Install [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/)

#### Visual Studio Workloads

When installing Visual Studio, you will be presented with a variety of [Workloads](https://visualstudio.microsoft.com/vs/support/selecting-workloads-visual-studio-2017/). Select these workloads.

1. ASP.NET and web development

## 4. Install the [Visual Studio Code C# Extension](https://code.visualstudio.com/Docs/languages/csharp)

## 5. Bookmark the Following Sites

 [dbdiagram.io](http://dbdiagram.io) - for creating ERDs (Entity Relationship Diagrams).

https://docs.asp.net/en/latest/getting-started.html

https://docs.microsoft.com/en-us/dotnet/
