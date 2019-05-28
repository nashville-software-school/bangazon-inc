# Identity Framework

Identity Framework in .NET allows you to easily add authentication and user-related data to your ASP.NET MVC application.

When you create a new project in Visual Studio, you need to make sure that during the setup that you click the button labeled `Change Authentication` and select _Individual User Accounts_.

Your instruction team will live-code setting up a project with Identity Framework enabled and how it looks and works by default.

## Customizing User Accounts

By default the only information that is captured about the user by Identity Framework is their username and password. Often, your application will want to capture more information about the user - such as their name, address, phone number, etc.

To do that you need to override the default code that Identity provides for registering a new user. You cannot modify that code directly, so you need to generate your own files in your project, and that will override the default behavior.

Create `Models.ApplicationUser` (_see the code further down in the chapter_). By default, this adds first name, last name and street address as properties of the users of your system. If you want to capture even more data, add the properties to that class.

### Scaffolding Identity Assets

As of .NET Core 2.1, the Razor pages that are used by Identity Framework for user management have been compiled into a Razor Page Archives, which means you can't see the `.cshtml` files in Solution Explorer. To override the template in the Archive, follow this process.

1. Right-click on your project in Solution Explorer
1. Choose _Add -> Scaffolded Item_
1. Select _Identity_ on the left
1. Click next
1. Choose `Login` and `Register` from the list of items that appear
1. Choose your `ApplicationDbContext` file in the drop-down below the list of files

Once that's complete, look in your Solution Explorer. You will see a new directory structure of `Areas -> Identity -> Pages -> Account`. In that directory, you will find the `Login.cshtml` and `Register.cshtml` files.

Click on the arrow next to each and it will show you that each of those files has a related `.cs` file. Open both of those `.cs` files.

1. Update `Register.cshtml.cs` and...
    1. Replace every instance of `IdentityUser` with `ApplicationUser` and use the lightbulb to include the correct namespace.
    1. Update `InputModel` to include all of the properties of `ApplicationUser`.
    1. Update `OnPostAsync` so that the new instance of `ApplicationUser` has all of the properties being submitted in the form.
1. Update `Register.cshtml` to include all of the HTML input fields for each of the properties on your `ApplicationUser`.
1. Update `Login.cshtml.cs` and...
    1. Replace every instance of `IdentityUser` with `ApplicationUser` and use the lightbulb to include the correct namespace.
1. Update `Views/Shared/_LoginPartial.cshtml` to use the `ApplicationUser` instead of `IdentityUser`
1. Also make sure that you change `Startup.cs` to replace `IdentityUser` with `ApplicationUser`.


### Scaffolding Controllers

In Visual Studio, you can use the scaffolding tool by right-clicking on the Controllers directory and choosing `Add > New Scaffolded Item`.

Then choose the model you want your controller to handle and it will generate one with all of the Entity Framework statements required to interact with the database.

## References

### ApplicationUser

Identity Framework provides a default `IdentityUser` class to represent the user that authenticate with your system, but it only captures user name and password. If you want to capture more information, you need to define a custom type that inherits from that type.

In the class below, you extend the `IdentityUser` so that you can also capture the following information and store it in the `AspNetUsers` table in the database.

* First name
* Last name
* Street address

> Models/ApplicationUser.cs

```cs
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace StudentExercises.Models
{
    // Add profile data for application users by adding properties to the ApplicationUser class
    public class ApplicationUser : IdentityUser
    {
        public ApplicationUser() { }

        [Required]
        [Display(Name ="First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name ="Last Name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name ="Street Address")]
        public string StreetAddress { get; set; }


        // Set up PK -> FK relationships to other objects
        public virtual ICollection<Product> Products { get; set; }

        public virtual ICollection<Order> Orders { get; set; }

        public virtual ICollection<PaymentType> PaymentTypes { get; set; }
    }
}
```

Then ensure that you add a `DBSet` in your `ApplicationDbContext` for this custom type.

```cs
public DbSet<ApplicationUser> ApplicationUsers { get; set; }
```

## Accessing the Authenticated User

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
