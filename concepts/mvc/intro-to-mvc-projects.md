# Intro to MVC projects

### ASP.NET MVC File Structure:
* **App_Data** Folder: stores app data such as the database here
* **Content** Folder: stores static css stylesheets. You edit the site.css to style the site
* **Controllers** Folder: handles user inputs for diff views
* **Models** Folder: hold and manipulate app database data
* **Views** Folder: where html and html partials are stored. The shared folder here stores views that are shared between controllers like layout pages. You will also find Razor markup here that uses the @syntax to denote C# to make more specific content depending upon the app state.
* **Scripts** Folder: stores javascript, AJAX, and jquery files

### Create a new ASP.NET Application
* To create a new project > Go to Web > ASP.NET MVC 4 Application > Internet Application.
* You will go to the new project > Web > Web application.
  * MVC 4 is a past version.

### Playing to a Browser:
When you press play, you can select whatever browser you want to open it up with. It comes with an authentication framework already built in. It picks a localhost number for you, and you can then copy it and use it on whatever browser you want to see how it works on other browsers.

### Other things
* The `@` symbol is basically a variable that outputs into html; will be discussed later in `Razor` module.
* **Partial** is a view that other views can call into their own structure. It allows you to reuse parts of a view in other web pages.
* **struct** is an object that just holds values. It’s very similar to JS objects. A struct is a bigger deal for non-object oriented programs because it can act as container that holds things, such as properties.