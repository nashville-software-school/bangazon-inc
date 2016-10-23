# Financial Reporting

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [Resources](#resources)

## Prerequisites

* [DB Browser for SQLite](http://sqlitebrowser.org/).
* Completed the [Chinook SQL exercise](https://github.com/nashville-software-school/csharp-dotnet-milestones/blob/master/3-database-driven-applications/exercises/database/DBS_SQL_LEARNING-THRU-DOING.md) 
* Introduction to unit testing

## What You Will Be Learning

### Interacting with a Database with SQL

You will be using raw SQL statements to query a SQLite database that powers a command line application.

### User Input

You will learn how to build a command line application that accepts user input to navigate a terminal-based user interface and then use input to update data in your database.

### Test Driven Development (TDD)

For this project, all core logic of the application must have a failing unit test written before any implementation logic is attempted. By following [TDD](https://msdn.microsoft.com/en-us/library/aa730844(v=vs.80).aspx) [principles](http://c2.com/cgi/wiki?TestDrivenDevelopment), you are ensuring that the program is more solidly designed before work begins.

### Refactoring Poorly Designed Code

This project was originally contracted to a developer in a European country through a freelancing web site. The developer was chosen because the rate for the project was the lowest of all people who placed a bid. After realizing how poor the quality of code was, we realized that you get what you pay for. You are now responsible to implementing the requirement with best practices.

## Requirements

> **Unit Testing**: Management will not accept a project for which implmentation code was written before a unit test. If you have questions about this, you need to speak with your manager.

Your team must build a customer service application that allows our customer service representatives keep track of customer issues. There will be several menus of options to navigate, and you will also be writing a report that customer service managers will be using to keep track of trends.

### Main Menu

```
==========================
BANGAZON FINANCIAL REPORTS
==========================

1. Weekly Report
2. Monthly Report
3. Quarterly Report
4. Customer Revenue Report
5. Product Revenue Report
```

#### Weekly Report


#### Monthly Report


#### Quarterly Report


#### Revenue per Customer


#### Revenue per Product


## Resources

### Initial Data

> **Note:** Any SQL that you need to populate your database needs to be checked into source control. Your database file should **never** be in source control - only the migrations.

Save the following SQL statements into a `populate.sql` file in your project directory. Run the statements against your database to have some initial data. You may add more departments or incident types if you wish.

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