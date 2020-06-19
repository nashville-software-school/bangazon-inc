## User Related Data

As part of a previous exercise, you made views for creating, editing, and listing dogs. Currently anyone can create a dog, assign it to any Owner, and view a list of all dogs. For the sake of privacy though, it would be nice if owners could only view or edit their own dogs. It would also be nice if in the dog Create form, we didn't make users enter an owner ID into an input field; instead the server would look for the current logged in owner, and default the dog's OwnerId property to that.

To be able to do this, we need to create a system for authentication and authorization. 

### Authentication vs Authorization

Authentication is the process of determining _who_ a user is. One way this could be determined is when a user logs in using an email/password combination. With that combination, the server can assume who the user is. 

Authorization is the process of determining _what a user has access to_. In our case, we're saying that owners should only be able to view and edit their own dogs. If Bob tries to navigate to `/dogs/edit/3` but the dog with the ID 3 belongs to Patty, Bob should not be authorized to view that page.

**IMPORTANT NOTE**

Creating a secure system for authentication and authorization is both incredibly important and very complex. We'll talk a bit more about safely storing sensitive information later in the course, but for now we're going to skip the password step and instead we're going to implement a lite version of auth where users only enter their email addresses to log in.

## Create a Login Page for Owners

We want owners to be able to authenticate, so let's create them a Login page. We'd like the url for this login form to be `/owners/login` which means that we'll need to eventually create two methods in our `OwnerController` called `Login` (again, we need two because the first is to GET the form and the second is to POST the form).

First create a new file in your ViewModels folder and name it `LoginViewModel.cs`. This is a simple class that will only capture a user's email address when logging in. Add the following code

```csharp
namespace DogGo.Models.ViewModels
{
    public class LoginViewModel
    {
        public string Email { get; set; }
    }
}
```

Now go into the `OwnerController` and add the following methods

```csharp
public ActionResult Login()
{
    return View();
}

[HttpPost]
public async Task<ActionResult> Login(LoginViewModel viewModel)
{
    Owner owner = _ownerRepo.GetOwnerByEmail(viewModel.Email);

    if (owner == null)
    {
        return Unauthorized();
    }

    var claims = new List<Claim>
    {
        new Claim(ClaimTypes.NameIdentifier, owner.Id.ToString()),
        new Claim(ClaimTypes.Email, owner.Email),
        new Claim(ClaimTypes.Role, "DogOwner"),
    };

    var claimsIdentity = new ClaimsIdentity(
        claims, CookieAuthenticationDefaults.AuthenticationScheme);

    await HttpContext.SignInAsync(
        CookieAuthenticationDefaults.AuthenticationScheme,
        new ClaimsPrincipal(claimsIdentity));

    return RedirectToAction("Index", "Dogs");
}
```

The GET method for `Login` should feel pretty familiar, but the POST method has some new code in it we haven't seen before. We're looking up an owner by their email address and then it's saving some of the owner's data into a cookie. The way this works is that when a user successfully logs in, the server is going to create something that's almost like a drivers license. The server populates that license with whatever information it chooses--in this case our code is choosing to add the owner's Id, email address, and role. It then takes that license/cookie and gives it back to whoever made the request. A cookie is a way that we can store data on a user's browser. After logging in, every time an owner makes a request to the server, the browser will automatically send up the value of that cookie. The ASP<span>.NET</span> Core framework will look at the cookie every time and know who the user is that's making the request.

We have to let ASP<span>.NET</span> Core know that we plan on using cookies for authentication. In the `Startup.cs` file, change the `ConfigureServices` and `Configure` methods to look like the following

> ConfigureServices

\* _This adds the call to_ `AddAuthentication`

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllersWithViews();
    services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
        .AddCookie(options => options.LoginPath = "/Owners/LogIn");
}
```

> Configure

\* _This adds a call to_ `UseAuthentication()`

```csharp
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }
    else
    {
        app.UseExceptionHandler("/Home/Error");
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }
    app.UseHttpsRedirection();
    app.UseStaticFiles();

    app.UseRouting();

    app.UseAuthentication();
    app.UseAuthorization();

    app.UseEndpoints(endpoints =>
    {
        endpoints.MapControllerRoute(
            name: "default",
            pattern: "{controller=Home}/{action=Index}/{id?}");
    });
}
```

The last thing we need to do is create a Login form. Right click the `Login` method in `OwnersController` and select add view, give it the template of Create, and the model class of `LoginViewModel`

You should now be able to log in at `/owners/login` and enter an existing email address. You can confirm it worked by checking for the cookie in your dev tools.

### Getting the current user in controllers

Go to the `DogController`. Let's make it so that if a logged in owner goes to the `/dogs` route, they only see their dogs. We'll do this by getting the current logged in owner's id and then adding a `WHERE` clause to our sql statement. 

Getting the id of the current logged in user will be something that we'll need to do many times in our controller, so let's separate this out into its own helper method. Add this private method to the bottom of the Dogs controller

```csharp
private int GetCurrentUserId()
{
    string id = User.FindFirstValue(ClaimTypes.NameIdentifier);
    return int.Parse(id);
}
```

Now in the `Index` method let's use our new helper method to get the currently logged in owner and query for only their dogs in the database

```csharp
public ActionResult Index()
{
    int ownerId = GetCurrentUserId();

    List<Dog> dogs = _dogRepo.GetDogsByOwnerId(ownerId);

    return View(dogs);
}
```

Now try going to the `/dogs` route. You should only see the dogs of the owner you just logged in as.

### Defaulting the OwnerId when creating dogs

Currently the form the user fills out when creating a dog asks the user to fill out a field for OwnerId. We can now remove that field and have the server set that value for us. First, go into the `Create.cshtml` file for Dogs and remove the form field for `OwnerId`

**Note:** _If you don't already have a method in your Dog Repository to add a new Dog, be sure to update that class with the following method_

```csharp
 public void AddDog(Dog dog)
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"
            INSERT INTO Dog (Name, Breed, OwnerId, Notes, ImageUrl)
            VALUES (@name, @breed, @ownerId, @notes, @imageUrl)
            ";

            cmd.Parameters.AddWithValue("@name", dog.Name);
            cmd.Parameters.AddWithValue("@breed", dog.Breed);
            cmd.Parameters.AddWithValue("@ownerId", dog.OwnerId);

            // nullable columns
            cmd.Parameters.AddWithValue("@notes", dog.Notes ?? "");
            cmd.Parameters.AddWithValue("@imageUrl", dog.ImageUrl ?? "");

            int newlyCreatedId = (int)cmd.ExecuteScalar();

            dog.Id = newlyCreatedId;

        }
    }
}
```

Now change the Dog Controller method for `Create` to set the `OwnerId` to the current user's Id

```csharp
[HttpPost]
[ValidateAntiForgeryToken]
public ActionResult Create(Dog dog)
{
    try
    {
        // update the dogs OwnerId to the current user's Id 
        dog.OwnerId = GetCurrentUserId();

        _dogRepo.AddDog(dog);

        return RedirectToAction("Index");
    }
    catch (Exception ex)
    {
        return View(dog);
    }
}
```

## Protecting Routes

We have certain routes that we don't want unauthenticated users to go to. `/dogs` and `/dogs/create` for example should not be accessible unless a user is logged in. Protecting routes with ASP<span>.NET</span> is easy. In your Dog Controller, put an `[Authorize]` annotation above any action for which a user would need to be logged in (Note: We'll discuss annotations more in a later chapter).

```csharp
[Authorize]
public ActionResult Index()
```

```csharp
[Authorize]
public ActionResult Create()
```


If an unauthenticated user now tries to go to either of these routes, they will be redirected to the login page.

## Exercise

1. In the DogController update the GET and POST methods for the Edit and Delete actions to make sure that a user can only edit or delete a dog that they own. Example: if a user goes to `/dogs/edit/5` or `/dogs/delete/5` and they don't own that dog, they should get a 404 NotFound result.

1. Update the Index method in the walkers controller so that owners only see walkers in their own neighborhood. 
**Hint**: Use the UserRepository to look up the user by Id before getting the walkers.

1. If a user goes to `/walkers` and is not logged in, they should see the entire list of walkers.
