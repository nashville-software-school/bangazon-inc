# LINQ

* https://msdn.microsoft.com/library/bb397926.aspx
* https://en.wikipedia.org/wiki/Language_Integrated_Query

Anything that LINQ produces is IQueryable (an expression tree is created).
###### Sonda's Notes

* **Dialect** - specific database-specific version of SQL language in order to query the database from your code. The ORM does that for you, so that you don’t have to learn dialects. The ORM automatically figures out what database you are running and then links the commands together.
  * In Microsoft, it’s called **LINQ**, a query language that provide assemblies to use the .NET framework with SQL databases.
  * You can use LINQ to talk to the ORM which translates the statement so the database can understand what you want it to do.
  * LINQ uses commands very very similar to SQL but not quite (so don’t assume you know what the command does just cause you saw it in SQL) to query your database from your code.
  * The return of a LINQ query is a .NET collection that you can use regular methods on.