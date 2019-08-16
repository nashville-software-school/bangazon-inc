# Exercise - BookShelf App

The purpose of this exercise is to practice creating a new MVC project using Entity and Identity Frameworks.

Your instruction team will demonstrate creating the initial structure of this application and then give you time to build it on your own.

> **NOTE:** It is **not** necessary to complete this exercise in order to learn from it.

## The BookShelf App

The goal of this application is to allow users to keep track of the books they have on their bookshelf, as well as the authors of those books.

This application should be build in ASP.<span>NET</span> Core MVC with Entity and Identity Frameworks and use a SQL Server database to store data.


### Data Entities

The application should have the following entities with their associated properties.

#### ApplicationUser

* First Name
* Last Name
* Full Name (_This property should not be saved to the database. See the [NotMapped ](https://www.learnentityframeworkcore.com/configuration/data-annotation-attributes/notmapped-attribute) data annotation_)
* _...All `IdentityUser` properties..._


#### Author

* First Name
* Last Name
* Full Name (_This property should not be saved to the database_)
* Penname (_optional_)
* PreferredGenre (_optional_)
* List of Books written by this Author
* ApplicationUser who created the Author 


#### Book

* ISBN (_should be between 10 and 13 characters_)
* Title
* Genre
* Publish Date
* Author (_a book may have **only one** Author_)
* Owner (_ApplicationUser who created the Book_)


### Requirements

1. Only authenticated users should have access to any Book or Author functionality
1. New users should be able to register for an account.
1. Existing users should be able to login with an email and password.
1. A user should be able to preform all CRUD operations on an Author.
1. A user should be able to preform all CRUD operations on a Book.
1. Users should **only** be allowed to View, Edit or Delete Books and Authors that **they created**.
1. Only Authors **not associated with a Book** may be deleted.


> **NOTE:** This is a complex project that entails much of what we've covered throughout this course. **It is a challenging exercise.** Do not let yourself get stuck on anything for too long without asking for help.

