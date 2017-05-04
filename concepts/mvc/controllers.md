# Controllers
* A controller handles the flow of information between front end and back end.
* Controller will change over time.
  * Business logic belongs in Repository, not Controller.
* The name of each controller ends in "...Controller", and inherits from .NET `System.Web.Mvc.Controller` class.
* Each controller method connects a particular request route from a client to a particular response action that the server performs.


* Most web pages are dynamically generated these days.
 * Each controller injects data into a corresponding `View`.
 * Document types include html, json, soap, xml, csv, pdf.


 * `ActionResults` of a controller match the View with the same name.

* `ViewBag` - for passing data (via variables) from Controller to View.  

* Controllers can also be used with template engines in the MVC framework to present (a list of) objects to the View.