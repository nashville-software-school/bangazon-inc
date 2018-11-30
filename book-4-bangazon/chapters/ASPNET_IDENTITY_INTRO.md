# Identity Framework

Identity Framework in .NET allows you to easily add authentication and user-related data to your ASP.NET MVC application.

When you create a new project in Visual Studio, you need to make sure that during the setup that you click the button labeled `Change Authentication` and select _Individual User Accounts_.

Your instruction team will live-code setting up a project with Identity Framework enabled and how it looks and works by default.

## Customizing User Accounts

By default the only information that is captured about the user by Identity Framework is their username and password. Often, your application will want to capture more information about the user - such as their name, address, phone number, etc.

To do that you need to override the default code that Identity provides for registering a new user. You cannot modify that code directly, so you need to generate your own files in your project, and that will override the default behavior.

### Scaffolding Identity Assets

```sh
dotnet tool install -g dotnet-aspnet-codegenerator
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
```

Then open your `.csproj` file and add the following section.

```xml
<ItemGroup>
    <DotNetCliToolReference Include="Microsoft.VisualStudio.Web.CodeGeneration.Tools" Version="2.1.0-preview1-final" />
</ItemGroup>
```

Then restore the packages and run the generator to create your user class and corresponding views.

```sh
dotnet restore
dotnet aspnet-codegenerator identity -u ApplicationUser -fi Account.Register
dotnet aspnet-codegenerator identity -u ApplicationUser -fi Account.Manage.Index
```

1. Remove the `Areas/Identity/Pages/Data` directory
1. Remove the `Areas/Identity/ProjectStart.cs` file
1. Create `Models.ApplicationUser` (_see below_) and add the additional properties.
1. Update `Register.cshtml.cs` with
    1. Replace every instance of `IdentityUser` with `ApplicationUser` and use the lightbulb to include the correct namespace.
    1. Update `InputModel` with corresponding properties
    1. Update `OnPostAsync` with corresponding properties
1. Update `Views/Shared/_LoginPartial.cshtml` to use the `ApplicationUser` instead of `IdentityUser`


### Scaffolding Controllers

You can scaffold a controller with its corresponding Razor views on the command line now. Type in the following command to see all of the options.

```sh
dotnet aspnet-codegenerator controller --help
```

Here's an example if you have a `Pet` data model, an `ApplicationDbContext` file, and want to generate a `Controllers.PetController.cs` file with the following views.

* /Views/Payment/Create.cshtml
* /Views/Payment/Edit.cshtml
* /Views/Payment/Details.cshtml
* /Views/Payment/Delete.cshtml
* /Views/Payment/Index.cshtml

```sh
dotnet aspnet-codegenerator controller -name PetsController -actions -m Pet -dc ApplicationDbContext -outDir Controllers
```

## References

### ApplicationUser

Identity Framework provides a default `IdentityUser` class to represent user that authenticate with your system, but it only captures user name and password. If you want to capture more information, you need to define a custom type that inherits from that type.

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

### Startup.cs

To enable EF model-first migrations, and enable Identity Framework for your project, this is what your `ConfigureServices` method should be in the `Startup.cs` file.

```cs
public void ConfigureServices (IServiceCollection services) {
    services.Configure<CookiePolicyOptions> (options => {
        // This lambda determines whether user consent for non-essential cookies is needed for a given request.
        options.CheckConsentNeeded = context => true;
        options.MinimumSameSitePolicy = SameSiteMode.None;
    });

    services.AddDbContext<ApplicationDbContext> (options =>
        options.UseSqlServer (
            Configuration.GetConnectionString ("DefaultConnection")));

    services.AddDefaultIdentity<ApplicationUser> ()
        .AddEntityFrameworkStores<ApplicationDbContext> ()
        .AddDefaultTokenProviders ();

    services.AddMvc ().SetCompatibilityVersion (CompatibilityVersion.Version_2_1);
}
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
