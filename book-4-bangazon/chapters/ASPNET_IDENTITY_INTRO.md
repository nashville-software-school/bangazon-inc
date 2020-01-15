# Identity Framework

Identity Framework in .NET allows you to add authentication and user-related data to your ASP.NET  applications.

## Authentication and Authorization

_Authentication_ is the process of confirming the user's identity. Authentication is usually accomplished by some kind of login procedure. After the user has entered a correct username and password, the application knows _who_ they are.

_Authorization_ is the process of confirming the user's rights within an application. It is about asking the question, "is this user allowed to do this thing?". For example, if only administrators can delete records, then the application must ask if the current user is an administrator before allowing them to delete something.

Identity Framework contains features for both authentication and authorization, however, in this course we will only focus on authentication.

## Creating an MVC Project using Identity Framework

When you create a new project in Visual Studio, you need to make sure that during the setup that you click the button labeled `Change Authentication` and select _Individual User Accounts_.

The new application will contain quite a bit of initial structure, including a lot of Entity Framework related code. While we will use a lot of the code in the initial project, we will need to make some changes and add some things.

## ApplicationUser

Identity Framework provides a default `IdentityUser` class to represent the user that authenticate with your system, but it only captures user name and password. If you want to capture more information (which is often the case), you need to define a custom type that inherits from `IdentityUser`.

For example, if we'd like to capture the following information about a user

* First name
* Last name
* Street address
* Products the user is selling

We would make new class like this

> Models/ApplicationUser.cs

```cs
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace YourApplicationNamespaceHere.Models
{
    public class ApplicationUser : IdentityUser
    {
        [Required]
        [Display(Name="First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name="Last Name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name="Street Address")]
        public string StreetAddress { get; set; }

        public virtual ICollection<Product> Products { get; set; }
    }
}
```

## Identity and Entity

Identity Framework works hand-in-hand with Entity framework. When we create a new Identity Framework project, VS even gives us an initial `ApplicationDbContext`, a migration and a connection string in `appSettings.json`. These scaffolded items are a good starting point, but we need to make a few changes.

1. If you're starting a new project, you can delete the `Data/Migrations` folder. It was nice of VS to give us an initial migration, but that migration wasn't built with our custom `ApplicationUser` class. If you're overriding the `ApplicationUser` in a project that already exists, you don't need to delete the `Migrations` folder. 
    > **NOTE:** Do NOT delete the `Data` folder, only the `Migration` folder inside of it.
1. Update the connection string in your appsettings file to point to a new database in your local SQLExpress database server.
1. Tell Identity and Entity about your custom `ApplicationUser` class by updating the `ApplicationDbContext` to inherit from `IdentityDbContext<ApplicationUser>`
1. Add a `DbSet<ApplicationUser>` property to the `ApplicationDbContext` class.

> Data/ApplicationDbContext.cs

```cs
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using YourApplicationNamespaceHere.Models;

namespace YourApplicationNamespaceHere.Data {
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser> {
        public ApplicationDbContext (DbContextOptions<ApplicationDbContext> options) : base (options) { }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
    }
}
```

## Replace IdentityUser with ApplicationUser

Other than the initial migration you deleted in the previous section, there are three places (in two files) in the scaffolded application that refer to `IdentityUser`. We need to change each instance to `ApplicationUser`.

1. **Startup.cs**
    * In the `ConfigureServices()` method
1. **Views/Shared/_LoginPartial.cshtml**
    * On the second and third lines

## Scaffolding User Management Pages

The default user registration page that Visual Studio generated does not have inputs for custom data (e.g. first name, last name, address) we would like to store for a user. In order to capture that information about a user we must modify the registration page.

As of .NET Core 2.1, the Razor pages that are used by Identity Framework for user management have been compiled into a Razor Page Archives, which means you can't see the `.cshtml` files in Solution Explorer. To override the template in the Archive, follow this process.

1. Right-click on your project in Solution Explorer
1. Choose _Add -> Scaffolded Item_
1. Select _Identity_ on the left
1. Click 'Next'
1. Choose `Register` from the list of items that appear
1. Choose your `ApplicationDbContext` file in the drop-down below the list of files
1. Click 'Add'


Once that's complete, look in your Solution Explorer. You will see a new directory structure of `Areas -> Identity -> Pages -> Account`. In that directory, you will find the `Register.cshtml` file.

Click on the arrow next to the `Register.cshtml` file and you will see a related `Register.cshtml.cs` file. The `*.cshtml` file contains the razor/html markup for the register view and the `*.cs` file contains the C# code the will save the new user to the database.

### Adding More Fields for Registration

1. Open `Register.cshtml.cs`
1. Update `InputModel` to include all of the properties of `ApplicationUser`.
    ```cs
    // Example
    [Required]
    [Display(Name = "First Name")]
    public string FirstName { get; set; }

    [Required]
    [Display(Name = "Last Name")]
    public string LastName { get; set; }

    [Required]
    [Display(Name = "Street Address")]
    public string StreetAddress { get; set; }
    ```
1. Update `OnPostAsync` so that the new instance of `ApplicationUser` has all of the properties being submitted in the form.
    ```cs
    // Example
    var user = new ApplicationUser {
        UserName = Input.Email,
        FirstName = Input.FirstName,
        LastName = Input.LastName,
        StreetAddress = Input.StreetAddress,
        Email = Input.Email
    };
    ```
1. Update `Register.cshtml` to include all of the HTML input fields for each of the properties on your `ApplicationUser`.
    ```html
    <div class="form-group">
        <label asp-for="Input.FirstName"></label>
        <input asp-for="Input.FirstName" class="form-control" />
        <span asp-validation-for="Input.FirstName" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Input.LastName"></label>
        <input asp-for="Input.LastName" class="form-control" />
        <span asp-validation-for="Input.LastName" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Input.StreetAddress"></label>
        <input asp-for="Input.StreetAddress" class="form-control" />
        <span asp-validation-for="Input.StreetAddress" class="text-danger"></span>
    </div>
    ```

### Additional User Management Pages

There are many other Identity Razor Pages you can scaffold and change. Feel free to scaffold them and see what they do. You can always delete any pages you don't need and/or (re)scaffold pages. In particular you will want to update the Login page because the default page contains text that is meant to help you as a developer, but is inappropriate for a real login page.


## Accessing the Authenticated User

### In Controllers

In any of your controllers that need to access the currently authenticated user, for example the Order Summary screen or the New Product Form, you need to inject the `UserManager` into the controller. Here's the relevant code that you need.

Add a private field to your controller.

```cs
private readonly UserManager<ApplicationUser> _userManager;
```

In the constructor, inject the `UserManager` service.

```cs
public ProductsController(ApplicationDbContext ctx,
                          UserManager<ApplicationUser> userManager)
{
    _userManager = userManager;
    _context = ctx;
}
```

Then add the following private method to the controller.

```cs
private Task<ApplicationUser> GetCurrentUserAsync() => _userManager.GetUserAsync(HttpContext.User);
```

Once that is defined, any method that needs to see who the user is can invoke the method. Here's an example of when someone clicks the Purchase button for a product.

```cs
[Authorize]
public async Task<IActionResult> Purchase([FromRoute] int id)
{
    // Find the product requested
    Product productToAdd = await _context.Product.SingleOrDefaultAsync(p => p.ProductId == id);

    // Get the current user
    var user = await GetCurrentUserAsync();

    // See if the user has an open order
    var openOrder = await _context.Order.SingleOrDefaultAsync(o => o.User == user && o.PaymentTypeId == null);


    // If no order, create one, else add to existing order
}
```

### In Razor Templates

There are often times that you want to display certain information in a Razor template if the user is currently signed in. For example, displaying _**Hello, Michael Ross**_ in the navigation bar if the user is signed in, but display the _**Login**_ link if the user is not signed in.

First, you need to inject the `UserManager` and the `SignInManager` tools into the Razor template. If you are using a custom user model, then you also need to include a `using` statement for the namespace of your models.

```html+razor
@using Microsoft.AspNetCore.Identity
@using YourApplicationNamespaceHere.Models;

@inject SignInManager<ApplicationUser> SignInManager
@inject UserManager<ApplicationUser> UserManager
```

Now you can use those tools to determine if the user is authenticated, and get their information.

```html+razor
@if (SignInManager.IsSignedIn(User))
{
    Hello @UserManager.GetUserAsync(User).Result.FirstName @UserManager.GetUserAsync(User).Result.LastName
}
else
{
    <a asp-area="" asp-controller="Account" asp-action="Login">Log in</a>
}
```
