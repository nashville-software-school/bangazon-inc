# Model View Controller (MVC) Concepts

## Overview
MVC, which stands for Model, View, Controller, is an architecture pattern for organizing software applications.  Each component manages a specific purpose, and serves to make your code more organized and modular.  In addition to defining the three components, MVC describes the actual relationship between the components.

###### Sonda's Notes
* Difference between Web and Desktop apps:
  * On the web, there is the model view controller, there is the model( classes, and data interaction), view (html and css) and controller(the browser).
  * For windowed and desktop languages like c sharp, there is view(user’s window), controller (the back end of operating system to create the window and bind its clicking), and the model.
* MVC Architecture:  Each Restful concept will typically have its own controller.
* Tests
  * Models will have unit tests
  * Views have functional tests, behavioral tests

## Model

The Model serves as the central component. It's responsible for talking to the database and represents your applications business logic and data. In other words, your model should contain the code that you'd typically find in an object oriented class.

###### Sonda's Notes
* Model
  * Stores data and business rules (such as validation). It is data and what it takes to stay consistent.
  * Business rules dictates what makes this data valid and useful.
  * Represents data but actually gets the data from somewhere else, such as data store like a database, API, or a certain file system.
  * You can have more than one model, each for the type of data you store.
  * A SERVICE can act as a go between from controller to model to have its own business rules like Firebase does.

## View
Views are the presentation layer for the MVC pattern.

###### Sonda's Notes
View - gives us things to display. Renders data into usable form. HTML, JSON, etc turns the data that is useful to you as a consumer. It is responsible for translating it to the user. Presenters squishes data from all sorts of places and presents it to you (including JSON files).

## Controller
A controller does exactly what its name implies. It serves as the hub of your app, receiving and routing requests between routes, models and views. In a typical request cycle, the controller starts off receiving a request, and routes that request to the appropriate model. The model then talks to the database and sends data back to the controller.  Finally, the controller renders the originally request view with the appropriate data.

###### Sonda's Notes
Controller - (aka router) talks between the model and view. Central hub of communication. User input is what motivates the controller to do things. This is the user’s browser with input and give replies. Controller will never interact with the data store. Typically there is a controller for each large concept.


#### What the heck are “business rules” and “business logic” in MVC?  (Per Sonda and stackoverflow.com)
* Business rules go in the model.
* Example:
  * Say you were displaying emails for a mailing list. The user clicks the "delete" button next to one of the emails, the controller notifies the model to delete entry N, then notifies the view the model has changed.
  * Perhaps the admin's email should never be removed from the list. That's a business rule, that knowledge belongs in the model.
  * The view may ultimately represent this rule somehow -- perhaps the model exposes an "IsDeletable" property which is a function of the business rule, so that the delete button in the view is disabled for certain entries - but the rule itself isn't contained in the view.
* The model is ultimately gatekeeper for your data. You should be able to test your business logic without touching the UI at all.



## Sources / Further Reading

* http://www.asp.net/mvc

* [Wikipedia] (http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)