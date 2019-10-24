# View Components

[View Components](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components?view=aspnetcore-3.0) allow you to create small, independant HTML components that can be used in any other Razor template in your system. The philosophy and architecture behind View Components in Razor is very much like React components.

View components are lesser-known features of ASP.NET Core Razor views. Unlike tag-helpers and HTML helpers - both of which generate single HTML elements - view components are a bit different.

They contain business logic - just like a controller - but the scope is generally contained to a single, reusable component rather than an entire view.

## Defining the Component Logic

A view component acts very much like a controller for your application. In the code below, you will see two classes created:

1. OrderCountViewModel
1. OrderCountViewComponent

OrderCountViewComponent is the controller-like logic except that this class inherits from `ViewComponent` instead of `Controller`.

```cs
public class OrderCountViewComponent : ViewComponent
```

Also unlike controllers, there are no standard methods like `Index`, `Create`, `Edit`, and `Delete`. Instead there is one method named `InvokeAsync` that contains all of the logic required to execute the business logics produce HTML from a `cshtml` file.

Like controllers, you can use dependency inject to get access to `ApplicationDbContext` - so you can query your database - and to the `UserManager` service - so you can get information about the currently authenticated user.

> ViewComponents/OrderCountViewComponent.cs

```cs
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Bangazon.Data;
using Bangazon.Models;
using Bangazon.Models.OrderViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bangazon.ViewComponents
{
    public class OrderCountViewModel
    {
        public int OrderCount { get; set; } = 0;
    }

    /*
        ViewComponent for displaying the shopping cart link & cart
        widget in the navigation bar.
     */
    public class OrderCountViewComponent : ViewComponent
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;

        public OrderCountViewComponent(ApplicationDbContext c, UserManager<ApplicationUser> userManager)
        {
            _context = c;
            _userManager = userManager;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            // Get the current, authenticated user
            ApplicationUser user = await _userManager.GetUserAsync(HttpContext.User);

            // Instantiate view model
            OrderCountViewModel model = new OrderCountViewModel();

            // Determine if there is an active order
            var order = await _context.Order
                .Include("LineItems.Product")
                .Where(o => o.User == user && o.PaymentType == null)
                .SingleOrDefaultAsync()
                ;

            // If there is an open order, query appropriate values
            if (order != null)
            {
                model.OrderCount = order.LineItems.Count;
            }

            // Render template bound to OrderCountViewModel
            return View(model);
        }
    }
}
```


## Defining the Component Layout

> Views/Shared/Components/OrderCount/Default.cshtml

```html+razor
@model Bangazon.ViewComponents.OrderCountViewModel

<span href="#" id="nav-shopping-cart">Cart (@Model.OrderCount)</span>
```

## Invoking a View Component in a Razor Template

Once you have the logic for the component written, and have created the `cshtml` file that defines the HTML structure, you can then use your component in any Razor template by invoke the the `InvokeAsync()` method that was defined in the view component controller.

> Views/Shared/_LoginPartial.cshtml

```html+razor
<li>@await Component.InvokeAsync("OrderCount")</li>
```
