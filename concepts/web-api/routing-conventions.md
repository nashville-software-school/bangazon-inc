# Routing Conventions

* **REST** (REpresentational State Transfer) is another set of guidelines outlining how resource endpoints are defined and behaved
* When writing a .NET Web API resource, the style of REST can help keep your controller methods focused and organized
* The typical development process is to work on one model at a time.
* In contrast to MVC routing (which allows you to dictate your own action verbs), a RESTful resource performs actions based on the combination of the url and the HTTP request's method (or "verb")
* Most often used HTTP request methods:
  * **GET**
  * **POST**
  * **PUT**
  * **DELETE**
* For any given resource (or model name), the convention for crud operations is as follows:

  | Method  | Url      | Action performed |
  | ------- | -------- | ----------------------------- |
  | GET     | Users/   | Returns a list of all users   |
  | GET     | Users/1  | Returns user with id of 1     |
  | POST    | Users/   | Creates/adds a user to set of all users |
  | PUT     | Users/1  | Updates info stored about user with id of 1 |
  | DELETE  | Users/1  | Deletes user with id of 1 |

* RESTful urls can also reflect relationships between entities. For example, say we want to find out the assignments a particular student has. An example of a RESTful url would be:
  * (GET) students/43/assignments

* Retrieving an individual assignment of that user could be:
  * (GET) students/43/assignments/2   

#### Resources  
* https://msdn.microsoft.com/en-us/library/system.web.http.routeattribute%28v=vs.118%29.aspx

* https://msdn.microsoft.com/en-us/library/system.web.http.routeprefixattribute%28v=vs.118%29.aspx