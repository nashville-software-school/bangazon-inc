# Firebase Authentication

[Firebase](https://firebase.google.com/) is a development platform provided by Google. It offers a wide array of tools for app development, data/file storage and even machine learning. We will be using firebase for user authentication.

The subject of authentication, particularly authentication using a _third-party provider_ such as Firebase, is both broad and deep. There are several approaches to authentication and each approach is non-trivial to implement. While the approach we cover in this course is a perfectly feasible way to implement authentication, it is by no means an exhaustive look at the topic.

## Authentication vs Authorization

_Authentication_ is the process of verifying a user is who they say they are. This is often done by requesting the user to provide a username and password, but put more generally the user must demonstrate that they _know something that only they should know_ or that they _posses something that only they should have_.

_Authorization_ is the process of determining if a user should be _allowed to perform_ an action. Authorization requires that a user be authenticated since the application cannot check a user permissions until it knows who the user is.

## Firebase Authentication Setup

Firebase provides an _identity store_ for user emails and passwords. Using Firebase relieves our application of the burden (and risk) of storing user credentials. Firebase also offers a set of tools for setting password strength requirements, for letting users change passwords and many other common credential management tools that we would otherwise have to build. In this course we will only touch the surface of the tools that Firebase offers.

> **NOTE:** In addition to email/password authentication, Firebase provides tools to allow authentication via Google, Github and several other third-party auth providers. We will not cover these alternatives in this course, but there is extensive documentation on the Firebase website.

### Firebase Account

Before you get started using Firebase, you must create an account. Go to https://firebase.google.com/ and click the large `Getting started` button to create an account. You will need to login with a Google username/password. If you do not have a Google account, there is an option to create on on the Google sign in form.

### Firebase Project

A Firebase identity store is contained within a _Project_. Once you have logged into Firebase, click the `Add project` button to create new project.

The example we'll be using for this chapter is an application for managing [Grace Hopper](https://en.wikipedia.org/wiki/Grace_Hopper) quotes called `WisdomAndGrace`. Create a Firebase project with that name.

### Setting up Authentication

1. From the Project Overview page, select `Authentication` in the menu on the left.
1. Click the `Get Started` button to begin the authentication set up process.
1. From the Authentication page, select the `Sign-in method` tab.
1. Hover your mouse over the `Email/password` sign-in provider and click the pencil icon.
1. In the window that appears, turn on the `Enable` switch, but make sure the `Email link (passwordless sign-in)` switch is turned off.
1. Click the `Save` button.
1. Select the `Users` tab and click the `Add user` button. Enter an email and a password _that you must remember_. The email does not have to be real.
1. After you create the user notice the value in the `User UID` column in the table. We'll be using his id later.
1. Finally, create a second user in the same manner as before. It's recommended that you use the same password for both users.

### Project Id and Web API Key

Once you've created the project, you should see a menu on the left side of the screen. Select the gear image near the top of this menu and choose the `Project settings` options.

On the Project settings page take note of the `Project ID` and the `Web API Key`. Remember how you got here because you will need these values later.

## Demo Project Overview

Now that we have some initial setup out of the way, let's take some time to think about what we are going to be building.

Our goal is to build a full-stack application using ASP<span>.NET</span> Core Web API on the server, ADO<span>.</span>NET to interact with a SQL Server database, React on the client and Firebase for authentication.

Because Web API, ADO<span>.</span>NET and React are all familiar to us, we won't go into them here. But we do need to get a high-level idea of how authentication will fit into the project. The image below describes the process.

![Firebase auth flow](./images/firebase-auth-architecture-small-1.png)

> Source: https://stackoverflow.com/questions/42336950/firebase-authentication-jwt-with-net-core/42410233#42410233

> **NOTE:** The process of authentication is very complex. It is very unlikely that you will understand very much of it right away.

### The Login Process

1. When our Web API server application starts up, it communicates with a back-end Google API server in order to gain access to Google's _public encryption key_.
1. The react application (running on a user's browser) sends a request to the Firebase server containing the user's email and password.
1. Firebase communicates with the Google  API server to confirm that the user's credentials are valid.
1. Once confirmed, Firebase sends a token (called a [JWT](https://jwt.io/introduction/)) to the React application. This token contains encoded information about the user.
1. Inside the react application, the Firebase library stores the token in the browser's `IndexedDB`. **The user is now _logged in_** to the app.
    > **NOTE:** We don't really need to care how or where Firebase stores the token. We just need to know how to get the token from Firebase when we need it. We'll see how to do that shortly.
1. When the react application needs to make an authenticated request to the Web API server, it passes token along with the request.
1. When the Web API sever receives the request from the react application, it verifies the token and uses it to determine who the user is.

## Running the Demo

As mentioned above the application we'll be building is for managing quotes from the brilliant Grace Hopper. Because there are a lot of steps required to build this application, we will not be doing it together in class. Instead you should **fork** the Github repo linked to below, then clone your copy to your computer.

https://github.com/nashville-software-school/WisdomAndGrace

### Look around the repo

In the repo you will find...

* A Visual Studio solution and project both called `WisdomAndGrace`.
* A `client` folder inside the project folder than contains a react application. This application's `package.json` file has already been configured to use the react proxy server.
* A sql script for building the application database.
* An `appsettings.json` file containing configuration information for the Web API.
* A `.env` file containing configuration settings for the React application.

### Update the Repo

Before we can run the app we need to make a few changes.

1. Open the SQL script in an editor and find the `INSERT` statements that insert records into the `UserProfile` table. Modify these statements to add the users you added to Firebase earlier in this chapter.
1. Update the `appsettings.json` file. Change the value of the `FirebaseProjectId` key to be the Project Id of your Firebase project.
1. Update the `.env` file. Change the value of the `REACT_APP_API_KEY` key to the API Key from your Firebase project.

Now we're finally ready to run this thing. Build your database, then run both server and client apps.

## Examining the Demo

Your instructor will take you through the parts of the demo application and describe how it is setup to use Firebase authentication.

### Some Key Areas to Explore

* JWT Authentication in `Startup.cs`.
* `app.UseAuthentication()` in `Startup.cs`.
* `FirebaseUserId` property in `UserProfile.cs`.
* `GetCurrentUser()` method in `QuoteController`.
* Use of the `[Authorize]` attribute to secure the `UserProfileController` and `QuoteController` controllers.
* Firebase JavaScript Library installed from npm.
* `login`, `register`, `logout`, `getToken` and `onLoginStatusChange` functions in `authManager.js`.
* Using the token (JWT) in the `fetch()` calls in both `authManager.js` and `quoteManager.js`.
* Simple `UserType` verification in `QuoteController.cs` and in `quoteManager.js`.

## Exercise

1. Go through the chapter and follow the steps to make the `WisdomAndGrace` app work on your computer.
1. Add Firebase authentication to the Streamish application.

### Firebase Authentication Checklist

#### In Firebase

1. Create a new Firebase project.
1. Enable the `Email/Password` `Sign-in method`.
1. Add at least two new users to Firebase. Each user **must** have the same email address as one of the users in your Streamish application.

#### In the Streamish Database

> **NOTE:** The following will delete and recreate the database.

1. Update the Streamish SQL script to add a `FirebaseUserId` column to the `UserProfile` table.

    ```sql
    CREATE TABLE [UserProfile] (
      [Id] INTEGER PRIMARY KEY IDENTITY NOT NULL,
      [FirebaseUserId] NVARCHAR(28) NOT NULL,
      [Name] NVARCHAR(255) NOT NULL,
      [Email] NVARCHAR(255) NOT NULL,
      [ImageUrl] NVARCHAR(255) NULL,
      [DateCreated] DATETiME NOT NULL,

      CONSTRAINT UQ_FirebaseUserId UNIQUE(FirebaseUserId)
    )
    ```

1. Change the `UserProfile` `INSERT` statements to insert users with the `FirebaseUserId`s and `Email`s that match the users you created in Firebase.
1. Run the script to recreate the Streamish database.

#### In the Visual Studio Web API Project

As you work through the following checklist, make sure to use the `WisdomAndGrace` application as an example.

1. Update the `appsettings.json` file to add a `"FirebaseProjectId"` key. Make the value of this key your Firebase project id.
1. Add the `Microsoft.AspNetCore.Authentication.JwtBearer` Nuget package to your project.
1. Update the `ConfigureServices()` method in `Startup.cs` to configure your web API to understand and validate Firebase JWT authentication.

    ```cs
    var firebaseProjectId = Configuration.GetValue<string>("FirebaseProjectId");
    var googleTokenUrl = $"https://securetoken.google.com/{firebaseProjectId}";
    services
        .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.Authority = googleTokenUrl;
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidIssuer = googleTokenUrl,
                ValidateAudience = true,
                ValidAudience = firebaseProjectId,
                ValidateLifetime = true
            };
        });
    ```

1. Update the `Configure()` method in `Startup.cs` to call `app.UseAuthentication();`.

    ```cs
    // ...
    app.UseRouting();
    app.UseAuthentication();
    app.UseAuthorization();
    // ...
    ```

1. Update the `UserProfile` model to include a `FirebaseUserId` property. This property should be a `string`.
1. Create a new web API action in the `UserProfileController` that will return a user by `firebaseUserId`. This new endpoint will be used for login.

    > **NOTE:** You should already have an API action for adding a new UserProfile that will be used in the registration process.

1. Add `[Authorize]` attributes to all of your controllers. We will not allow anonymous users in the Streamish app.

#### In the React Client App

As you work through the following checklist, make sure to use the `WisdomAndGrace` application as an example.

1. Use npm to install the firebase library: `npm install firebase`.
1. Create a `authManager.js` module with `login`, `register`, `logout`, `getToken` and `onLoginStatusChange` functions. Make sure you get all the helper functions too.
1. Add an `isLoggedIn` boolean to the `App`'s state and setup the `onLoginStatusChange` function to update the `isLoggedIn` state.
1. Add code to `index.js` to initialize Firebase.
1. Update `fetch()` calls throughout the app to include an `Authorization` header that uses the Firebase token.
