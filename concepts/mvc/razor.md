# Razor

* Most web pages are dynamically generated these days.

* `.cshtml` - filetype specific to Microsoft's MVC framework
  * Supports use of embedded C# inside html-syntax files using Razor syntax.
  * Razor engine then interprets html with embedded C# into pure html file - this happens on the server, before html reaches browser


* `@` delimits C# code and prefixes C# variables
  * Even classes can be dynamic: `@class` does not call C# class, but escapes .css class.


* Each controller injects data into a corresponding `View`.
  * Q: What is the syntax for injecting a View into layout?
  * A: `@RenderBody()` helper function ("lazy evaluator")
    * Waits until last minute, when view is thrown at it during rendering of `Index`.

### For more info, see:
* http://www.asp.net/web-pages/overview/getting-started/introducing-razor-syntax-c
* https://en.wikipedia.org/wiki/ASP.NET_Razor
* http://www.w3schools.com/aspnet/razor_intro.asp
* http://www.w3schools.com/aspnet/razor_syntax.asp
* http://razorcheatsheet.com/
* https://github.com/aspnet/Razor