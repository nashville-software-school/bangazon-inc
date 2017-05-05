# REST / HTTP

* With APIs, clients (e.g. a browser or phone app) make AJAX requests to a URI to interact with data. This is most naturally implemented by a server side application returning HTTP responses containing JSON. This is different from a traditional MVC-style process in two ways:
  * The client is only requesting data and not an entire view/HTML page
  * The server only exposes data, usually in the form of JSON (could be XML)

* Why? In the modern age of the internet, clients come in many shapes and sizes, and the old model of server-returning-HTML to every device no longer worked well. Clients can now implement the presentation in their own way (cf. the Facebook app for iOS versus facebook.com in your browser) and simply interact with the data by itself. This allows the front end clients and back end service to be more decoupled - the back end resource does not care or need to know which kind of client is requesting data as long as it is authorized to do so. This accordingly enforces the separation of concerns.
  * E.g.: while the profile page in the facebook iOS app looks different from the profile page on facebook in a browser, both issued the same request for profile data for a given user. The clients render the data in their views differently but received the same underlying object.

* Since the back end resource is only presenting and handling data requests, the front end clients become more responsible for determining how and where the data is rendered in a given view. This gives greater flexibility when designing clients for different platforms and removes the responsibility of building and managing views from the server.

* In order to make as generic an interface as possible, most Web APIs implement to some degree the conventions of REST. This aides in providing a consistent system of interacting with data.


###### Sonda's Notes re: APIs in .NET:
* With APIs, there is the browser or something like it on one side of the internet. On the other side, you have the back-end where you have your database and your application logic and they only communicate with the user and the browser world through API (the interface).
* There is a push towards API development where you have a backend app and the browser shows it through the API.
* Different meanings of API - API actually has two meanings.
  * One means that there is the front end and back end parts and this is the interface by which they talk to each other.
  * When the web got bigger, then API meant how to use the data from another web service data.
* Quick REST recap
    * REST is a convention for building API’s and interacting with them.  
    * If you build APIs RESTful, there is a standard format/protocol that people will know how to interact with when using your API.
    * The web is built on the HTTP protocol.  Each message we send with HTTP has a couple of parts.
  	  * Headers
        * → request method (the verbs, the how, ex: HEAD/PATCH/GET/POST/PUT/DELETE)
  		  * → referrer
  		  * → requested uri (universal resource identifier, the nouns)
  	  * Body
  		...?
    * All this ties into MVC.

* The important bit is when we’re building our own API’s, we will be connecting these REST concepts with the MVC concepts.  There is almost always a 1 to 1 correspondence between our controllers and our models.  Using an airport as an example, three example controllers are:
  	GateController → Connects to the Gate model (which talks to the DB)
  	RunwayController → Connects to the Runway model (which talks to the DB)
  	PlaneController  → Connects to the Plane model (which talks to the DB)

### WebAPI Resources

##### ApiController
* https://msdn.microsoft.com/en-us/library/system.web.http.apicontroller%28v=vs.118%29.aspx

##### Online Tutorial
Building a Web App with ASP.NET 5, MVC 6, EF7, and AngularJS
https://app.pluralsight.com/library/courses/aspdotnet-5-ef7-bootstrap-angular-web-app/table-of-contents