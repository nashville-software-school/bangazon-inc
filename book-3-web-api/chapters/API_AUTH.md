# Authenticating Users in a Full Stack Application

We're going to use a bit of a cheat code for authentication. In a real full-stack application, you would likely use something called JSON Web Tokens (JWTs) to secure your API so that only users who were logged in on the front end could access certain end points. JWTs are very, very complicated. We want you to focus more on how the front-end and back-end communicate with each other, without getting bogged down in authentication schemes and security. 

The method that we will use is similar to what we used in the front-end portion of the course, where we stored a logged-in user in local storage. Is it secure? Heck no! Would you use it in the workplace? Again, no. But on the job, you will likely have an authentication scheme already set up for whatever app you're working on. The chance of having to build one from scratch as a junior developer are pretty slim. So, onwards into our slightly jerry-rigged, extremely unsafe version of authentication!

## Overview
Let's walk through the process of authentication. First, a user opens our application in the browser. They see a form to log in, or a form to register. We know that these forms will be built in React, because they're things that the user can interact with directly. What happens next will depedn on whether they want to log in or register. 

#### Register
1. Let's say the user needs to register. They fill out the register form and click submit! 
1. When they click submit, our client (aka our React App) sends an HTTP POST request (aka a fetch call) to our API. It sends all the information the user just entered into the form-- their name, their email, their password, etc.
1. When our API gets a POST request to register a new user, it wraps that info up from the form and sends it to the database using ADO.NET and SQL. 
1. When we add the new user to our SQL Server database, SQL Server generates a unique id for that user. That user id is going to be really important!
1. Our API sends back the **entire user object, including that shiny new id** to our React app. This is basically like the API saying "yep, it worked! I created a user! Here it is!"
1. By now, our React App has the response from the API-- the full user object! Our React app stores it in local storage, in the browser, so that we can access that super important user id later to figure out which user is logged in. (Again: super insecure! That's ok for now.)

#### Logging In
1. If the user wants to log in, they fill out their email and password into a log in form in our React app
1. We need to use their email address and password to *get* their entire user object out of the database. We really want their user id so we can store it in local storage. (See "Accessing User-Specific Data" for why!)
1. When the user clicks submit, our React app sends an HTTP GET request (aka a fetch call) to the API. We pass along the email address that the user entered into the log in form so our API knows which user to retriev for us. 
1. Our API uses that email address and plugs it into a SQL query to get one specific user from the database with a matching email address. Our API sends the entire user object back to the React app. 
1. On the client side, the React app takes that user object (which includes it's id!) and stores it in local storage. 

#### Accessing User-Specific Data
What's the point of all this? Why go to all this trouble to store the user's info in local storage? The answer, my friends, is user-related data. That means that when a user logs in, we want them to see _only_ gifs that they posted. Just like when you log in to your notes app on your phone, you see _only_ notes that you've written-- not every note written by every user ever. Because that would be overwhelming and weird, and everyone would see the embarassing drafts of texts you keep in your notes app. (No? Just me? Cool cool cool.) 
1. Once the user logs in, they'll want to see their gifs, right? Except now we only want them to see _their_ gifs, and not anyone else's. 
1. When our React App loads, it's already making a fetch call to get all the gifs. We're going to attach a query string to that fetch call with the user's id. How do we know which user id to include? We always want to include the id of the logged in user, i.e. the user stored in local storage.
1. When our API intercepts a request for gifs, it will now _also_ intercept the id of the logged in user. 
1. Our API will plug that id into a SQL query to get _only_ that user's gifs out of the database. Then our API will send those gifs back as a response to the React app. 
1. Our React App will print the gifs as usual. We don't have to change anything about how we print-- all our own code will work here. We're just changing _which_ gifs we print when the page loads. 


#### Ok, after all that, what code do I actually need to write?
Take a few minutes and read back through the overview above with this question in mind. Then set a timer for five to ten minutes and write down what you think you will need to change in your Gifter code base to accomplish these steps. 
1. What components will you need to add to your React app? 
2. What controllers and repositories will you need to add in your API? 
3. What methods will those controllers have? 


**We're going to give you the answer below, but don't cheat-- this will be the process you have to do on your capstone and on the job.** If you need help thinking this through, talk to a classmate or an instructor. This is worth spending time on. Translating human-readable steps to a solid plan for how you're going to build it with code is the number one skill every developer needs to have.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

Have you made a list of the files and methods you think you'll need? No? Just want to skip down to the answer? DON'T DO IT! Give this an honest shot. please. You won't always have an answer key. 
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Okay, great job. Thanks for giving this a try! Now is a great time to check in on how the process of planning your authentication process went for you. If this felt really hard, it's probably wise to ask your instructor about how you can practice planning. If it felt doable, that's great! Even if the plan ends up changing, coming up with _some_ kind of plan allows you to communicate better with your team, estimate your time wisely, and predict road blocks before you hit them. Here's the plan that we came up with:
1. Becaues the user needs to see a login form and a register form, we will need to add a login component and a register component to our React app.
2. Because we will need work with the `UserProfile` table in the database, we will need to add a `UserProfile` controller and repository to our API.
3. In these files, we will need methods to handle adding a new user (for registering) and getting a user by their email address (for logging in). We don't really need any other functionality for users at the moment. 
4. Because our login and register components in React will be communicating with a new resource in our API (aka a new `/userprofile` endpoint), we will need a new data provider in our React app as well. 

If you came up with a different plan, that's ok! Discuss it with a teammate or an instructor to figure out where your plan differed from ours. There are always more than one right way to solve a problem! To have everyone on the same page, we're going to stick with our plan for the remainder of this chapter. 


## Set up your API to handle users
### Add a UserProfile Repository and Interface

>IUserProfileRepository.cs
```C#
using System.Collections.Generic;
using Gifter.Models;

namespace Gifter.Repositories
{
    public interface IUserProfileRepository
    {
        void Add(UserProfile user);

        UserProfile GetByEmail(string email);
    }
}
```
>Startup.cs
```C#
// Add the following line of code in the ConfigureServices method
  services.AddTransient<IUserProfileRepository, UserProfileRepository>();
```
>UserProfileRepository.cs
```C#
using System;
using System.Linq;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Gifter.Models;
using Gifter.Utils;

namespace Gifter.Repositories
{
    public class UserProfileRepository : BaseRepository, IUserProfileRepository
    {
        public UserProfileRepository(IConfiguration configuration) : base(configuration) { }



        public UserProfile GetByEmail(string email)
        {
            using (var conn = Connection)
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                          SELECT Id, Name, Email, ImageUrl, Bio, DateCreated FROM UserProfile WHERE Email = @email";
                    cmd.Parameters.AddWithValue("@email", email);



                    var reader = cmd.ExecuteReader();

                    UserProfile user = null;
                    if (reader.Read())
                    {
                        user = new UserProfile()
                        {
                            Id = DbUtils.GetInt(reader, "iD"),
                            Name = DbUtils.GetString(reader, "Name"),
                            Email = DbUtils.GetString(reader, "Email"),
                            DateCreated = DbUtils.GetDateTime(reader, "DateCreated"),
                            ImageUrl = DbUtils.GetString(reader, "ImageUrl")
                        };
                    }

                    reader.Close();

                    return user;
                }
            }
        }


        public void Add(UserProfile user)
        {
            using (var conn = Connection)
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        INSERT INTO UserProfile (Name, Email, ImageUrl, Bio, DateCreated)
                        OUTPUT INSERTED.ID
                        VALUES (@Name, @Email, @ImageUrl,  @Bio, @DateCreated)";

                    DbUtils.AddParameter(cmd, "@Name", user.Name);
                    DbUtils.AddParameter(cmd, "@Email", user.Email);
                    DbUtils.AddParameter(cmd, "@Bio", user.Bio);
                    DbUtils.AddParameter(cmd, "@ImageUrl", user.ImageUrl);
                    DbUtils.AddParameter(cmd, "@DateCreated", DateTime.Now);

                    user.Id = (int)cmd.ExecuteScalar();
                }
            }
        }


    }
}
```

### Add a UserProfile Controller
>UserProfileController.cs
```C#
using Gifter.Models;
using Gifter.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Gifter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserProfileController : ControllerBase
    {
        private readonly IUserProfileRepository _userRepository;
        public UserProfileController(IUserProfileRepository userRepository)
        {
            _userRepository= userRepository;
        }
        [HttpGet("GetByEmail")]
        public IActionResult GetByEmail(string email)
        {
            var user = _userRepository.GetByEmail(email);
            if (email == null || user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        [HttpPost]
        public IActionResult Post(UserProfile user)
        {
            _userRepository.Add(user);
            return CreatedAtAction("GetByEmail", new { email = user.Email }, user);
        }
    }
}

```

## Build your front end components 
### Add a login form
>Login.js
```js
import React, { useEffect, useState } from "react";
import { login } from "../modules/UserManager";

export const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const submitLoginForm = (e) => {
  const newLogin = {
   email: email,
   password: password
  }
    e.preventDefault();
    getUsers(newLogin);
  };

  return (
    <>
      <>
        <h2>Log In</h2>
        <form>
          <input
            type="text"
            onChange={(e) => setEmail(e.target.value)}
            name="email"
          />
          <input
            type="password"
            onChange={(e) => setPassword(e.target.value)}
            name="password"
          />
          <button type="submit" onClick={submitLoginForm}>
            Log In
          </button>
        </form>
      </>
    </>
  );
};

```

### Add a register form
>Register.js
```js
import React, { useContext, useEffect, useState } from "react";
import { register } from "../modules/UserManager";

export const Register = () => {
  // Create state variables for each form field
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [bio, setBio] = useState("");
  const [imageurl, setImageurl] = useState("");

  
  // This function will run when the user has finished filling out the form and clicks submit
  const submitLoginForm = (e) => {
  const newUser = {
  name: name,
  email: email,
  bio: bio,
  imageurl: imageurl
  }
    e.preventDefault();
    registerUser(newUser);
  };

  return (
    <>
    <h2>Register</h2>
      <form>
        <input
          type="text"
          onChange={(e) => setEmail(e.target.value)}
          placeholder="email"
        />
        <input
          type="text"
          onChange={(e) => setName(e.target.value)}
          placeholder="name"
        />
        <input
          type="text"
          onChange={(e) => setBio(e.target.value)}
          placeholder="bio"
        />{" "}
        <input
          type="text"
          onChange={(e) => setImageurl(e.target.value)}
          placeholder="imageurl"
        />
        <button type="submit" onClick={submitLoginForm}>
          Register
        </button>
      </form>
    </>
  );
};

```

### Add your data provider
>UserManager.js
```js
import React, { useState } from "react";



export const UserManager = (props) => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const getCurrentUser = () => {
    const currentUser = localStorage.getItem("gifterUser");

    return currentUser;
  };



  const login = (userObject) => {
    debugger;
    fetch(`api/userprofile/getbyemail?email=${userObject.email}`)
      .then((r) => r.json())
      .then((userObjFromDB) => {

        localStorage.setItem("gifterUser", JSON.stringify(userObjFromDB));
        setIsLoggedIn(true);
      })
  };

  const register = (userObject) => {
    fetch("/api/userprofile", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userObject),
    })
      .then((response) => response.json())
      .then((userObject) => {
        localStorage.setItem("gifterUser", JSON.stringify(userObject));
      });
  };

  const logout = () => {
    localStorage.clear();
    setIsLoggedIn(false);
  };

 
};

```

# Exercises
1. Create routes in `ApplicationViews` for your login and register forms. 
2. Modify your Post List to show _only_ the user's posts. 
