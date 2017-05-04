# ASP.NET Web API

* http://www.asp.net/web-api/overview

* API = classes and routes that map to classes
  * send json to browser
  * enable building something else on top
  * require serialization & deserialzation

* To include external static files (e.g. angular)
  * download file
  * add to scripts
  * include in Bundles
  * use RESTful routes to intermediate between .NET and angular

* set up controllers with Razor to load views with index pages, which will (later) have ng-view
* Angular modules:  .config $route provider [??]
* Razor handles some, and angular loads partial views
*