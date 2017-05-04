# Relational Databases

#### Document Oriented vs Relational Database
  * **Relational database**
    * Stored very similar to how data is stored in spreadsheets like excel.  
    * In tables or a grid that relate to other tables or grids.  
    * Instead of storing all the data in one place, you split it up.  For instance:    
      * Book grid with title / author / year stored in the table.  
      * Another grid with book #, chapter, and chapter text stored there.
  * **Document Oriented**
    * Like a json blob.  
    * In document oriented, there is no schema.

  * **Practical Differences**
    * At least 95% of the time, you want a relational database.  But in the modern age, you don’t have to choose between one or the other.  Things like Postgres allow for storing document oriented stuff in a relational database.  We will be focusing on relational databases.
    * When using firebase, we used JSON.  We will be moving towards Tables as the overriding metaphor, as stored data will be kept in a tabular way (or at least mimic this structure).

#### Types of Relational Databases:
  * **MySQL** → loose on rules
  * **Postgres** → strict
  * **MS SQL** → proprietary
  * **Sqlite** → light weight
  * **Oracle** → wrote their own spec

#### Tables, Rows and Columns
* A database with one table is not very useful.  What we end up doing in databases is having multiple tables that often relate to each other.
* Each database consists of N number of tables.  
* Each row in a table can be referred to as a “tuple”, or just a row of data if you prefer.  
* Columns have…
	 * name (i.e. id, title)
	 * type (i.e. integer, varchar)
	 * constraints (i.e. NOT NULL, UNIQUE, etc)
	* Typically in databases we have an ID column, and the ids are typically sequential.
* Schema = rules for how data is structured
* ID column is **primary key**
* **foreign key** ID key when it is used in a different table, to reference data in original table

#### Talking to a Database

###### SQL Statements
 * SQL keywords are written in CAPS
 * Basic Structure of a SQL statement:
	`SELECT ______   
	FROM ______
	JOIN ______ ON ______
	WHERE ______`

* Example:  `SELECT * FROM employees WHERE name LIKE ‘b%’`
   * LIKE means “matches a pattern” and % means “starts with” (wildcard).

* Example 2: `SELECT products.id, products.name FROM order_details JOIN products ON  order_details.product_id = products.id WHERE order_details.order_id = 10250`

###### How to: Insert Rows Into the Database
  * https://msdn.microsoft.com/en-us/library/bb386941%28v=vs.110%29.aspx

###### How to: View your Table in your Database:
  * Open Server Explorer > Click on your Database Connection > Tables > Right Click on ObjectName > Show Table Data

###### How to: Delete your Database (in case you’re having connection errors):
  * Open Microsoft SQL Server Management
  * Click OK if that’s the Server you’re working with
  * Click Database > Your Database > Right Click > Delete > Make sure close connection is checked.

###### How to: Make a New Connection:
  * Right-Click Data Connection from Server Explorer.
  * Now add a Connection > Server Name .\SQLEXPRESS > Under Connect to database add ProjectName.ObjectContext (Or whatever your project name.ObjectContext).
  * You can test it and then add it.
  * It should populate in Server Explorer with tables, views, etc.

###### How to:  Make a New Database First, then create a Connection:
  * Right-Click Data Connection from Server Explorer.
  * Now Create New SQL Server > Server Name .\SQLEXPRESS > Under Connect to database add ProjectName.ObjectContext.
  * You can test it and then add it.
  * It should populate in Server Explorer with tables, views, etc.
  * Add Connection makes a connection and then new Object.Context, realizes there is not a database yet, and then makes a database.
  * Create SQL DB - creates a new database first, thus the database is empty for while, and then the code runs to add/delete/and such.

#### Joins
* http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/
* With a join, you must specify how the table is joined using ON. Otherwise, you will get all the combinations possible of one table row matched with another table row.
  * **Inner Join** matches one table with another table row for row. If one row doesn’t have its pair on another table, it will be excluded. It will only show matching row pairs.
  * **Outer Join** matches two tables row for row but includes rows that are not paired up, aka rows that have a pair with a null in the other table.

#### Other Resources
* http://tutorials.jumpstartlab.com/topics/fundamental_sql.html