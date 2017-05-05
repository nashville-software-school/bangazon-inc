# Routing
* Routing in MVC by default follows this setup which is run when the app starts up:
```
public static void RegisterRoutes(RouteCollection routes)
{
    routes.MapRoute(
        name: "Default",
        url: "{controller}/{action}/{id}",
        defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
    );
}
```
* We see here that the convention is `{controller}/{action}/{id}` (N.B. in the code configuration above, that the `id` parameter is optional). This allows a developer to create semantic and abstract urls rather than associate urls with a specific file. The end goal is to have readable and intuitive urls rather than `http://about.exofly.com/my_site?f=2enr93hv98&collect=true&blahblah=blarghdiblargh`
* Contrast an unintuitive url with these `{controller}/{action}/{id}`-patterned examples:
  * `Users/Create/`      (remember an `id` is optional)
  * `Shipments/Edit/231`
  * `Pets/Search/1`
  * `Project/Destroy/2`
* The **{action}** parameter of a route corresponds with a specific method on an MVC controller
  * Example:
    * Default MVC "About" page url:  `./Home/About` where url syntax is:
      *	"Home" = prefix of controller class (by convention), via routes
      *	"About" = controller action, an instance method; returns an "Action Result" that refers to the view that will get data injected, as part of .NET's MVC package.
      * Works as a regular method for testing and utilities.