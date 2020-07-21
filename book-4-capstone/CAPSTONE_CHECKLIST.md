# Checklist for setting up a Fullstack Capstone

This checklist covers creating a project with ASP<span>.</span>NET Core Web API, Entity Framework Core, SQL Server, React and Firebase Auth.

The technologies outlines in this chapter are _NOT_ the only technologies you are allowed to use for your capstone, but they are the standard, "happy-path" technologies that we generally recommend.

_**If you would like to use an alternative technology (ex. ADO<span>.</span>NET, MVC, etc...) you must get approval from your capstone mentor.**_

## Set up project

1. Create Web API project in Visual Studio
1. Create .gitignore

## Setup SQL Server

1. Create SQL "create" script (either copy from Gifter and modify or generate from DBDiagram). Save SQL file in the project.
1. Create SQL "seed data" script (or update create script) to insert seed data records into your database tables.
1. Run the script(s) to create and seed your database.

> **NOTE:** The script(s) should be written such that they can be re-run as needed to recreate your database. _See the Gifter script for an example_


## Set up Firebase

1. Go to Firebase console and create a new project
1. Enable a "Sign-in method". 
    > **NOTE:** In the course we used the `Email/Password` sign-in method.
1. Go to project settings to view API Key and Project ID (you'll need these in future steps)

## Server Side

1. Install Nuget Packages (Copy from WisdomAndGrace.csproj & Gifter)
1. Add connection string
1. Create Models
1. Create Data folder and ApplicationDbContext.cs
1. Update `appSettings.json` to include `FirebaseProjectId`
1. Update Startup.cs to use Entity Framework and ApplicationDbContext
1. Update Startup.cs to ignore reference loops when serializing JSON
1. Update Startup.cs to handle JWTs
1. Copy in the `UserProfileRepository` and `UserProfileController` from WisdomAndGrace.

> **NOTE:** Make sure to update the `namespace` of any classes you copy/paste from another project.

## Client Side

1. Create client directory and run `npx create-react-app .`
1. Setup proxy in `package.json`
1. Install firebase and react router using `npm install react-router-dom firebase`
1. Install whatever component library you want
1. Create a .env.local file and add the firebase API Key
1. Add call to `firebase.initializeApp`
1. Copy in UserProfileProvider.js, Login.js, Register.js
1. Copy in ApplicationViews.js and remove code that's not needed
1. Modify App.js to use Router, UserProfileProvider, and ApplicationViews