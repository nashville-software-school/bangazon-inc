# Quick ASP.NET Web Application

## Setup

```
mkdir -p ~/workspace/csharp/exercises/MusicHistory && cd $_
dotnet new sln -n MusicHistory
mkdir src && cd $_
dotnet new webapi -n MusicHistory
dotnet restore
mkdir -p ../test/MusicHistory.Tests && cd $_
dotnet new xunit
dotnet restore
cd ../..
code .
```

## Requirements

1. Create a web page that lists all artists.
1. Create a web page that shows a single artist's details, and lists all albums that the artist has created.
1. Create a web page that lists all songs.
1. Create a web page that shows a single song's details.
1. Create a web page that lists all albums.
1. Create a web page that shows a single album's details, and lists all songs on the album.

### Models

1. Build a [model](https://docs.microsoft.com/en-us/aspnet/mvc/overview/older-versions/getting-started-with-aspnet-mvc4/adding-a-model) representing your `Artist` table.
1. Build a model representing your `Album` table. Ensure that you define the foreign key to the artist table.
1. Build a model representing your `Song` table. Ensure that you define the foreign keys to the artist, and album table.

### Views

Create a [view](https://docs.microsoft.com/en-us/aspnet/mvc/overview/older-versions/getting-started-with-aspnet-mvc4/adding-a-view) for each of the web pages defined above in the requirements.

### Templates

Define a [Razor template](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor)  for every web page defined above in the requirements. Each View will return a fully rendered Razor template to the client

### Migrations

Remember that every time you create a model, or update it, you need to [create a migration](https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/migrations), and apply it.


# Optional Stretch Goals

1. Style your templates with CSS by setting up your application to serve static files.
1. Create a site template that shows a navigation bar at the top. All individual view will extend it, so that you don't need to duplicate the code in each one.