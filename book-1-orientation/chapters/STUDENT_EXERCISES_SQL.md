# Dog Walker

In this series, you'll be building out the back end of an application for users in Nashville to have their dogs walked. Users can find walkers in their neighborhood who can take their dogs on walks while they're away.

# Dog Walker Database

In this part of building your application, you will be creating the database tables and the data that you will be querying in your application logic later.

You will use `CREATE TABLE` statements and `INSERT` statements to create all the tables necessary for storing information about dogs, owners, and walkers in a SQL Server database.

## Setup

### Create a new Database

1. Open Visual Studio
1. Open the SQL Server Object Explorer
1. Right-click the `Databases` node beneath your SQLEXPRESS SQL Server Instance. Select `Add New Database`.
1. Name the database `DogWalker`.
1. Right-click the new database and select `New Query...`.
1. Click `File` -> `Save SQLQuery1.sql`. Navigate to an approprate directory save the file as `DogWalker.sql`.

### Creating The Database

When creating the database, refer to [this ERD](https://dbdiagram.io/d/5e641e294495b02c3b87efcb)

In the Query Window, enter the SQL to create all of your tables, columns, and foreign key constraints.

Use `CREATE TABLE` statements to create the tables and columns. Make sure you put in the foreign key `CONSTRAINT` statements where needed.

Then use `INSERT` statements to create starting data in your tables.

## Instructions

1. Create tables for each entity.
1. Populate each table with data. You should have 2-3 neighborhoods, 5-10 dogs, 4-8 owners, 2-5 walkers and each walker should have 1-2 walks recorded.
1. Write a query to return all owners names and the name of their neighborhood.
1. Write a query to return the name and neighborhood of a single owner (can be any Id).
1. Write a query to return all walkers ordered by their name.
   > **NOTE:** SQL offers the ability to [order by](https://www.w3schools.com/SQL/sql_orderby.asp) columns in a table.
1. Write a query to return a list of unique dog breeds.
   > **NOTE:** Take a look at [SQL SELECT DISTINCT Statement](https://www.w3schools.com/Sql/sql_distinct.asp) for some guidance.
1. Write a query to return a list of **all** dog's names along with their owner's name and what neighborhood they live in
   > **NOTE:** sometimes you need to join more than two tables in a query.
1. Return a list of owners along with a count of how many dogs they have
   > **NOTE:** SQL has a [group by](https://www.w3schools.com/sql/sql_groupby.asp) just like LINQ does.
1. Return a list of walkers along with the amount of walks they've recorded
1. Return a list of all neighborhoods with a count of how many walkers are in each, but do not show neighborhoods that don't have any walkers.
1. Return a list of dogs that have been walked in the past week
   > **NOTE:** It may help to know how to [format dates](https://www.w3schools.com/sql/sql_dates.asp)
1. Return a list of dogs that have not been on a walk
