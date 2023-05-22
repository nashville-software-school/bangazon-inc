# Installing Required Software in Windows


## .NET

1. Install .NET from https://dotnet.microsoft.com/download
   * Click the `Download .NET SDK x64` button under the large `.NET` header on the right side. 
1. Open a terminal and run `dotnet --version`. You should see a version greater than or equal to `6.0.16`

## Visual Studio IDE

 [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/). This will be your main code authoring tool for the server-side course.
   > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workloads.
   >
   > - ASP.NET and web development
   > - .NET Core cross-platform development

## SQL Server Express Database

[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads). This is the database tool where all your data will be stored for the server-side course. Click the Download button under the Express option. During the setup, take the basic installation option

## Gitignore Shortcut

You'll be making a lot of new projects and we want to easily be able to create a gitignore file before pushing to Github. Run the following code from a git bash window

```sh
echo "dnignore() {
    curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore' > .gitignore
}" >> ~/.bashrc
```

You now have access in your terminal to a command called `dnignore` which will add a gitignore file to your project.


## Bookmark the Following Sites

[dbdiagram.io](http://dbdiagram.io) web application for creating ERDs (Entity Relationship Diagrams).

https://docs.asp.net/en/latest/getting-started.html

https://docs.microsoft.com/en-us/dotnet/

### .NET on YouTube

- **Main page**: https://www.youtube.com/channel/UCvtT19MZW8dq5Wwfu6B0oxw
- **C# 101**: https://www.youtube.com/watch?v=BM4CHBmAPh4&list=PLdo4fOZ0oVxKLQCHpiUWun7vlJJvUiN
- **.NET 101**: https://www.youtube.com/watch?v=eIHKZfgddLM&list=PLdo4fOcmZ0oWoazjhXQzBKMrFuArxpW80
