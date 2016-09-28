# Customer Service Incident Portal

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [Resources](#resources)

## Prerequisites

* [DB Browser for SQLite](http://sqlitebrowser.org/).
* Completed the [Chinook SQL exercise](https://github.com/nashville-software-school/csharp-dotnet-milestones/blob/master/3-database-driven-applications/exercises/database/DBS_SQL_LEARNING-THRU-DOING.md) 
* Introduction to unit testing
* ERD development
* Class based inheritance
* Interfaces

## What You Will Be Learning

### Interacting with a Database with SQL

You will be using raw SQL statements to read and write information to a SQLite database that powers a command line application.

### User Input

You will learn how to build a command line application that accepts user input to navigate a terminal-based user interface and then use input to update data in your database.

### Test Driven Development (TDD)

For this project, all core logic of the application must have a failing unit test written before any implementation logic is attempted. By following [TDD](https://msdn.microsoft.com/en-us/library/aa730844(v=vs.80).aspx) [principles](http://c2.com/cgi/wiki?TestDrivenDevelopment), you are ensuring that the program is more solidly designed before work begins.

## Requirements

Your team must build a customer service application that allows our customer service representatives keep track of customer issues. There will be several menus of options to navigate, and you will also be writing a report that customer service managers will be using to keep track of trends.

### Access Prompt

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Enter your first and last name to start. Type "new user" to create a new user account.
> 
```

#### Valid User

Once the user enters in a valid first name and last name that exists in the database, the user will be presented with the main menu.

#### New User

If the user entered "new user" at the prompt, display three prompts to create a new account in the `Employee` table.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

First name
> 

Last name:
>

Department:
1. Apparel
2. Electronics
3. Toys & Games
4. Books
5. Home Furnishings
>
```

### Main Menu

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

1. Create incident
2. List all my incidents
3. Incident report
X. Exit
```

### Create Incident

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Enter customer name (<First> <Last>):
>
```

After the customer representative enters in the customer's first and last name, you need to create a connection to the Bangazon Product Database to find that customer's information and any orders that the customer has completed.

Then display a menu where the rep can choose the order for which the customer has an issue.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Choose a customer order:
1. Order #9: 01/01/2011
2. Order #32: 03/14/2011
3. Order #151: 11/07/2011
4. Order #236: 06/30/2012
5. Order #783: 01/12/2013
X. Exit
>
```

After an order has been selected, then prompt for the incident type.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Choose incident type:
1. Defective Product
2. Product Not Delivered
etc...
X. Exit
```

Then display an incident screen where the customer service rep can enter in the resolution.

```
INCIDENT
==============================================================
Customer: Smith, John                            Order: 151
Incident Type: Defective Product

Labels:
* This order is refundable
* This order is replaceable
* Non-Tranactional incident
==============================================================
Enter resolution:
>
```

Make sure you have a class definition for each type of incident in your database. Use inheritance to share common properties, and implement the correct interfaces on the appropriate types.

1. `Defective Product` and `Product Not Delivered` incident types are replaceable.
1. `Defective Product` and `Product Not Delivered`, and `Fraud` incident types are refundable.
1. `Request for Information` and `Shipping Info Update` incident types are non-transactional (i.e. just for information and not complaints).

Based on which interface the specific incident type implements will determine which label(s) are displayed on the incident screen above (see the `Labels` section).


### List Incidents

### Incident Report

## Resources

### Initial Data

Run the following SQL statements against your database to have some initial data. You may add more departments or incident types if you wish.

```
/*
Add some default departments
 */
INSERT INTO Department (Label) VALUES ('Apparel');
INSERT INTO Department (Label) VALUES ('Electronics');
INSERT INTO Department (Label) VALUES ('Toys & Games');
INSERT INTO Department (Label) VALUES ('Books');
INSERT INTO Department (Label) VALUES ('Home Furnishings');

/*
Add some default incident types
 */
INSERT INTO IncidentType (Label) VALUES ('Defective Product');
INSERT INTO IncidentType (Label) VALUES ('Product Not Delivered');
INSERT INTO IncidentType (Label) VALUES ('Unhappy With Product');
INSERT INTO IncidentType (Label) VALUES ('Request For Information');
INSERT INTO IncidentType (Label) VALUES ('Fraudulent Charge');
INSERT INTO IncidentType (Label) VALUES ('Shipping Info Update');
```