# Using Identity Tools in Razor Templates

## Determine if the User is Authenticated

There are often times that you want to display certain information in a Razor template if the user is currently signed in. For example, displaying _**Hello, Michael Ross**_ in the navigation bar if the user is signed in, but display the _**Login**_ link if the user is not signed in.

First, you need to inject the `UserManager` and the `SignInManager` tools into the Razor template. If you are using a custom user model, then you also need to include a `using` statement for the namespace of your models.

```html+razor
@using Microsoft.AspNetCore.Identity
@using Bangazon.Models

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

## Common Issues

Since you will usually define a custom user class for use in your application (e.g. `ApplicationUser`) then you will need to find every instance of the word `IdentityUser` in all of your Razor templates, and change it to `ApplicationUser`.
