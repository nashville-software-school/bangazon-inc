# Firebase Authentication

[Firebase](https://firebase.google.com/) is a development platform provided by Google. It offers a wide array of tools for app development, data/file storage and even machine learning. We will be using firebase for user authentication.

## Firebase Authentication Setup

Firebase provides an _identity store_ for user emails and passwords. Using Firebase relieves our application of the burden (and risk) of storing user credentials. Firebase also offers a set of tools for setting password strength requirements, for letting users change passwords and many other common credential management tools that we would otherwise have to build. In this course we will only touch the surface of the tools that Firebase offers.

> **NOTE:** In addition to email/password authentication, Firebase provides tools to allow authentication via Google, Github and several other third-party auth providers. We will not cover these alternatives in this course, but there is extensive documentation on the Firebase website.

## Disclaimer
The subject of authentication, particularly authentication using a _third-party provider_ such as Firebase, is both broad and deep. There are several approaches to authentication and each approach is non-trivial to implement. While the approach we cover in this course is a perfectly feasible way to implement authentication, it is by no means an exhaustive look at the topic.

## Authentication vs Authorization

_Authentication_ is the process of verifying a user is who they say they are. This is often done by requesting the user to provide a username and password, but put more generally the user must demonstrate that they _know something that only they should know_ or that they _posses something that only they should have_.

_Authorization_ is the process of determining if a user should be _allowed to perform_ an action. Authorization requires that a user be authenticated since the application cannot check a user permissions until it knows who the user is.


## High Level Overview

[Here is a slide deck of our basic auth flow](https://sketchboard.me/PCmJSxesIXN#/presentation). It will show how register, login, and making authenticated requests works

Once you go through it, you might also ponder this slightly more technical diagram of the auth flow.

![Firebase auth flow](./images/firebase-auth-architecture-small-1.png)

> Source: https://stackoverflow.com/questions/42336950/firebase-authentication-jwt-with-net-core/42410233#42410233

> **NOTE:** The process of authentication is very complex. It is very unlikely that you will understand very much of it right away.

### The Login Process

1. When our Web API server application starts up, it communicates with a back-end Google API server in order to gain access to Google's _public encryption key_.
1. The react application (running on a user's browser) sends a request to the Firebase server containing the user's email and password.
1. Firebase communicates with the Google  API server to confirm that the user's credentials are valid.
1. Once confirmed, Firebase sends a token (called a [JWT](https://jwt.io/introduction/)) to the React application. This token contains encoded information about the user.
1. The react application stores the token in the browser's `localStorage`. **The user is now _logged in_** to the app.
1. When the react application needs to make an authenticated request to the Web API server, it passes token along with the request.
1. When the Web API sever receives the request from the react application, it verifies the token and uses it to determine who the user is.

## Example Project

The process of implementing this auth flow will be long. If you need a reference to a simple working example, you will probably want to bookmark [this repo](https://github.com/nashville-software-school/WisdomAndGrace/tree/entity-framework)

Let's get into it.....

## Setting up Firebase

### Firebase Account

Before you get started using Firebase, you must create an account. Go to https://firebase.google.com/ and click the large `Getting started` button to create an account. You will need to login with a Google username/password. If you do not have a Google account, there is an option to create on on the Google sign in form.

### Firebase Project

A Firebase identity store is contained within a _Project_. Once you have logged into Firebase, click the `Add project` button to create new project. When it prompts you for a name you can call it "Gifter"

### Project Id and Web API Key

Once you've created the project, you should see a menu on the left side of the screen. Select the gear image near the top of this menu and choose the `Project settings` options.

On the Project settings page take note of the `Project ID` and the `Web API Key`. Remember how you got here because you will need these values later.

### Setting up Authentication in the Firebase console

1. From the Project Overview page, select `Authentication` in the menu on the left.
1. From the Authentication page, select the `Sign-in method` tab.
1. Hover your mouse over the `Email/password` sign-in provider and click the pencil icon.
1. In the window that appears, turn on the `Enable` switch, but make sure the `Email link (passwordless sign-in)` switch is turned off.
1. Click the `Save` button.
1. Select the `Users` tab and click the `Add user` button. Enter an email and a password _that you must remember_. The email does not have to be real.
1. After you create the user notice the value in the `User UID` column in the table. We'll be using this id later.
1. Finally, create a second user in the same manner as before. It's recommended that you use the same password for both users.

## Adding the Firebase JS library to our Gifter client

We're going to install a firebase npm package in our React app which will do a lot of the heavy lifting in communicating with Firebase.

1. Install the firebase library by running `npm install firebase` in your `/client` directory.
1. Create a file named `.env.local` (don't forget the leading `.`) inside the `client` directory and add the following
    ```
    REACT_APP_FIREBASE_API_KEY=xxxxxxxxxxxx
    ```
    Replace the `xxx`'s with your firebase API key. You can find this in your project settings on the Firebase website.
1. Update the `index.js` file to include the following code right below your `import` statements
    ```js
    // other imports omitted
    import firebase from "firebase/app";

    const firebaseConfig = {
        apiKey: process.env.REACT_APP_API_KEY,
    };
    firebase.initializeApp(firebaseConfig);

    // other code omitted
    ```
    You'll need to restart the React dev server, but your app should now be hooked up to your firebase project and ready to implement our auth flow.
## Implementing the auth flow in Gifter

### Adding a UserProfileProvider in the React app

Our UserProfileProvider is going to hold on to the user state as well as define the methods which will make the login/register calls to firebase and handle the responses. Create a `providers` folder inside the `src` directory and add a `UserProfileProvider.js` file with the following code

```js
import React, { useState, useEffect, createContext } from "react";
import { Spinner } from "reactstrap";
import firebase from "firebase/app";
import "firebase/auth";

export const UserProfileContext = createContext();

export function UserProfileProvider(props) {
    const apiUrl = "/api/userprofile";

    const userProfile = localStorage.getItem("userProfile");
    const [isLoggedIn, setIsLoggedIn] = useState(userProfile != null);

    const [isFirebaseReady, setIsFirebaseReady] = useState(false);
    useEffect(() => {
        firebase.auth().onAuthStateChanged((u) => {
            setIsFirebaseReady(true);
        });
    }, []);

    const login = (email, pw) => {
        return firebase.auth().signInWithEmailAndPassword(email, pw)
        .then((signInResponse) => getUserProfile(signInResponse.user.uid))
        .then((userProfile) => {
            localStorage.setItem("userProfile", JSON.stringify(userProfile));
            setIsLoggedIn(true);
        });
    };

    const logout = () => {
        return firebase.auth().signOut()
        .then(() => {
            localStorage.clear()
            setIsLoggedIn(false);
        });
    };

    const register = (userProfile, password) => {
        return firebase.auth().createUserWithEmailAndPassword(userProfile.email, password)
            .then((createResponse) => saveUser({ ...userProfile, firebaseUserId: createResponse.user.uid }))
            .then((savedUserProfile) => {
                localStorage.setItem("userProfile", JSON.stringify(savedUserProfile));
                setIsLoggedIn(true);
            });
    };

    const getToken = () => firebase.auth().currentUser.getIdToken();

    const getUserProfile = (firebaseUserId) => {
        return getToken().then((token) =>
        fetch(`${apiUrl}/${firebaseUserId}`, {
            method: "GET",
            headers: {
                Authorization: `Bearer ${token}`
            }
        }).then(resp => resp.json()));
    };

    const saveUser = (userProfile) => {
        return getToken().then((token) =>
        fetch(apiUrl, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify(userProfile)
        }).then(resp => resp.json()));
    };

    return (
        <UserProfileContext.Provider value={{ isLoggedIn, login, logout, register, getToken }}>
        {isFirebaseReady
            ? props.children
            : <Spinner className="app-spinner dark"/>}
        </UserProfileContext.Provider>
    );
}
```

While you might go through this code to try to match up each method with how it fits into our auth diagram above, it's not necessary that you understand everything in it. What _is_ important is that you recognize that this provider can provide other components with a  boolean property of `isLoggedIn`, along with methods for

- login
- logout
- register
- getToken

### Adding a Login & Register component to the React app

Create a `Login.js` file in the `components` directory. The following code simply creates a login form and calls into the `login` method which it gets from the `UserProfileProvider` we defined above

```js
import React, { useState, useContext } from "react";
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { useHistory, Link } from "react-router-dom";
import { UserProfileContext } from "../providers/UserProfileProvider";

export default function Login() {
    const history = useHistory();
    const { login } = useContext(UserProfileContext);

    const [email, setEmail] = useState();
    const [password, setPassword] = useState();

    const loginSubmit = (e) => {
        e.preventDefault();
        login(email, password)
            .then(() => history.push("/"))
            .catch(() => alert("Invalid email or password"));
    };

    return (
        <Form onSubmit={loginSubmit}>
            <fieldset>
                <FormGroup>
                    <Label for="email">Email</Label>
                    <Input id="email" type="text" onChange={e => setEmail(e.target.value)} />
                </FormGroup>
                <FormGroup>
                    <Label for="password">Password</Label>
                    <Input id="password" type="password" onChange={e => setPassword(e.target.value)} />
                </FormGroup>
                <FormGroup>
                    <Button>Login</Button>
                </FormGroup>
                <em>
                    Not registered? <Link to="register">Register</Link>
                </em>
            </fieldset>
        </Form>
    );
}
```

Now do the same for register by creating a `Register.js` file with the following code

```js
import React, { useState, useContext } from "react";
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { useHistory } from "react-router-dom";
import { UserProfileContext } from "../providers/UserProfileProvider";

export default function Register() {
  const history = useHistory();
  const { register } = useContext(UserProfileContext);

  const [name, setName] = useState();
  const [bio, setBio] = useState();
  const [email, setEmail] = useState();
  const [imageUrl, setImageUrl] = useState();
  const [password, setPassword] = useState();
  const [confirmPassword, setConfirmPassword] = useState();

  const registerClick = (e) => {
    e.preventDefault();
    if (password && password !== confirmPassword) {
      alert("Passwords don't match. Do better.");
    } else {
      const userProfile = { name, bio, imageUrl, email };
      register(userProfile, password)
        .then(() => history.push("/"));
    }
 };

  return (
    <Form onSubmit={registerClick}>
      <fieldset>
        <FormGroup>
          <Label htmlFor="name">First Name</Label>
          <Input id="name" type="text" onChange={e => setName(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label htmlFor="bio">Bio</Label>
          <Input id="bio" type="text" onChange={e => setBio(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label for="email">Email</Label>
          <Input id="email" type="text" onChange={e => setEmail(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label htmlFor="imageUrl">Profile Image URL</Label>
          <Input id="imageUrl" type="text" onChange={e => setImageUrl(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label for="password">Password</Label>
          <Input id="password" type="password" onChange={e => setPassword(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label for="confirmPassword">Confirm Password</Label>
          <Input id="confirmPassword" type="password" onChange={e => setConfirmPassword(e.target.value)} />
        </FormGroup>
        <FormGroup>
          <Button>Register</Button>
        </FormGroup>
      </fieldset>
    </Form>
  );
}
```

Now give both of these components routes in your `ApplicationViews`

```html
// code omitted

<Route path="/login">
    <Login />
</Route>

<Route path="/register">
    <Register />
</Route>

// code omitted
```

### Adding a FirebaseId column to our UserProfile table & model

1. Run this SQL script to add the additional column
    ```sql
    ALTER TABLE UserProfile
    ADD FirebaseId VARCHAR(50);
    ```
1. Now that our database table has been updated, we also need to update the `UserProfile` model. Update `UserProfile.cs` to include this property
    ```csharp
    public string FirebaseId { get; set; }
    ```

### Setting the server up to talk to Firebase

1. Update your `appsettings.json` file to include your firebase Project ID (you can find this back on the firebase website). Add it right below the connection string

    ```json
    "ConnectionStrings": {
        "DefaultConnection": "server=localhost\\SQLExpress;database=Gifter;integrated security=true"
    },
    "FirebaseProjectId": "YOUR_FIREBASE_PROJECT_ID"
    ```
1. Update the `ConfigureServices` method inside `Startup.cs` to include the following code. This is what allows our server to verify incoming tokens with Firebase.

    ```csharp
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
1. Still inside `Startup.cs`, in the `Configure` method find the line that calls `app.UseAuthorization()` and add `app.UseAuthentication()` right above it. This is what will tell our API server to check the token on each request

    ```csharp
    // code omitted...

    app.UseAuthentication();
    app.UseAuthorization();

    // code omitted...
    ```

### Creating User Repository and Controller

Lastly we need to create the methods for getting and saving user profiles. Start by adding a `UserProfileRepository.cs` to your `Repositories` directory with the following code

```csharp
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Gifter.Data;
using Gifter.Models;

namespace Gifter.Repositories
{
    public class UserProfileRepository
    {
        private readonly ApplicationDbContext _context;

        public UserProfileRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public UserProfile GetByFirebaseUserId(string firebaseUserId)
        {
            return _context.UserProfile
                    .Include(up => up.UserType) 
                    .FirstOrDefault(up => up.FirebaseUserId == firebaseUserId);
        }

        public void Add(UserProfile userProfile)
        {
            _context.Add(userProfile);
            _context.SaveChanges();
        }
    }
}
```

Afterwards, extract an `IUserProfileRepository` interface and have the `UserProfileRepository` implement it. Don't forget to register it inside `Startup.cs`

```csharp
services.AddTransient<IUserProfileRepository, UserProfileRepository>();
```

Finally, add a `UserProfileController` which will expose our API endpoints

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using System;
using Gifter.Data;
using Gifter.Models;
using Gifter.Repositories;

namespace Gifter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserProfileController : ControllerBase
    {
        private readonly UserProfileRepository _userProfileRepository;
        public UserProfileController(ApplicationDbContext context)
        {
            _userProfileRepository = new UserProfileRepository(context);
        }

        [HttpGet("{firebaseUserId}")]
        public IActionResult GetUserProfile(string firebaseUserId)
        {
            return Ok(_userProfileRepository.GetByFirebaseUserId(firebaseUserId));
        }

        [HttpPost]
        public IActionResult Post(UserProfile userProfile)
        {
            userProfile.CreateDateTime = DateTime.Now;
            userProfile.UserTypeId = UserType.AUTHOR_ID;
            _userProfileRepository.Add(userProfile);
            return Ok(userProfile);
        }
    }
}
```

### Checking if it's working

To verify that everything is working, you should confirm that you can register a new user and then subsequently log in as that user. You should be able to check both firebase and your database and see that the user has been created in both.

### What are we left with?

Now that everything is set up, what can we do?

#### Get the current user in our controllers

We can add a private method to our controllers which will get us the current user.

```csharp
private UserProfile GetCurrentUserProfile()
{
    var firebaseUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
    return _userProfileRepository.GetByFirebaseUserId(firebaseUserId);
}
```

Similar to how we did this in our MVC controllers, we're getting the firebase ID out of the token (although, we used cookies before in MVC) and we're looking up in the database the user object with that firebase ID.

#### Ensure only authenticated users access certain API endpoints

We can do this exactly how we did in our MVC controllers. Simply put the `[Authorize]` annotation above any controller class or controller method and it will block anyone from accessing that API enpoint unless they send a valid token up with the request.

```csharp
[Authorize]
[Route("api/[controller]")]
[ApiController]
public class PostController : ControllerBase
{
    // controller code here can only be accessed by authenticated users...
}
```

#### Get the logged in user in your React application

When users login/register we're saving their profile information inside localStorage. Any component or js file can access the user object by retrieving it from there

```js
const user = JSON.parse(localStorage.getItem('userProfile'));
```

#### Authenticate our `fetch` calls

Our `UserProfileProvider` exposes a `getToken` method. We can add that token to our fetch requests so that the server will know who is making the call. To inlcude a token in a `fetch` call, set the `Authorization` header like this

```js
import React, { useContext, useEffect } from 'react';
import { UserProfileContext } from "../providers/UserProfileProvider";

const SomeComponent = () => {
    const { getToken } = useContext(UserProfileContext);

    useEffect(() => {
         getToken().then((token) =>
            fetch(apiUrl, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}` // The token gets added to the Authorization header
                }
            })
            .then(resp => resp.json())
            .then(setQuotes));
    }, []);
}


```

## Exercises

1. In the AddPost form, remove the input field for User Id. Instead, set that property on the server in the controller code.
1. Update the Header so that if a user is not logged in, they see links for Login and Register. If they are logged in, they should see a link for Logout and the header should display their username somewhere.
1. Update ApplicationViews so that only authenticated users can access routes other than Login and Register. If a user tries to go to those URLs directly, they should be redirected to the Login page. You should also protect all the `api/posts` endpoints from being hit directly without a token.
1. Add a delete feature in the React client. Make sure that only the owner of a post can delete it (this check needs to be done client side _and_ server side. It's not enough to just hide a button. Make sure someone else couldn't delete it using POSTMAN)

## Advanced

Congrats. You've conquered the regular auth challenges. Implement the comment and subscription features that Gifter is missing. Allow users to subscribe to one another and comment on each others posts.
