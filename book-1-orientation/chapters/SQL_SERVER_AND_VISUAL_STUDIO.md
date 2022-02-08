# SQL Server using Visual Studio

## SQL Server

SQL Server is a _Relational Database Management System_ (RDBMS) created by Microsoft. It runs as a background _service_ inside Windows. When you installed it, the installation process set up the service to automatically start when your computer starts.

SQL Server is essentially a container to hold multiple relational databases.


Although you can access lots of RDBMSs from a .NET application, SQL Server is very popular and commonly used by .NET development teams.

## Relational Database

A _relational database_ is a database made up of tables and the relationships between tables.

A _table_ is a "grid" of data. It's made up rows and columns.

A _relationship_ is a link between a primary key in one table and a foreign key in another table (or, possibly, the same table).

> **NOTE:** Relational databases contain more than just tables, but in this course we'll be focused on tables.

## Connecting to SQL Server from Visual Studio

In this course we use Visual Studio for writing C# code, but, turns out, it's also a good tool for interacting with SQL Server.

### Getting Started

1. Start Visual Studio 2022.
1. At the start screen select `Continue without code`.
1. Open the `View` menu and select `SQL Server Object Explorer`.
1. Right-click the `SQL Server` node, select `Add SQL Server...`.
1. In the dialog that appears, expand the `Local` node and select the SQL Server instance called `SQLEXPRESS`.
1. Click `Connect`.

Now you should have a listing for your SQL Server instance in the `SQL Server Object Explorer` window. You can expand it and interact with your databases.

> **NOTE:** You can also connect to SQL Server from Visual Studio when you have a C@ project open.

## Other Tools

There are other tools for connecting to SQL Server.

* [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-ver15)
    * A relatively new and cross platform tool.
* [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
    * The (currently) most popular tool for managing SQL Server. It is mature and full of features that DBAs love. It's only available on Windows.
