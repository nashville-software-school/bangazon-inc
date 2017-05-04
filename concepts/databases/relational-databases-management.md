# Relational Database Management System Concepts

#### Basic terminology  
* A **database** is a data store.
  * Databases logically organize data into an abstraction of real-world concepts.
  * Database is often abbreviated to DB.
* A **DBMS** is a database management system.
* Databases and database management systems are different concepts.
   * The database is the data and the metadata (for example, indexes) about that data.
   * The database management system is the software used to access and manipulate the data stored in the database.
* Accessing and manipulating the data in the DB is typically referred to as the **CRUD** operations (Create, Read, Update, Delete).

* https://en.wikipedia.org/wiki/Database

### ACID Model
* http://databases.about.com/od/specificproducts/a/acid.htm

"In computer science, ACID (Atomicity, Consistency, Isolation, Durability) is a set of properties that guarantee that database transactions are processed reliably. In the context of databases, a single logical operation on the data is called a transaction. For example, a transfer of funds from one bank account to another, even involving multiple changes such as debiting one account and crediting another, is a single transaction." [Wikipedia]

#### How can databases be stored?

###### Centralized
* This is the closest thing we have to a default storage pattern. Centralized databases are stored and served from a single location/machine.
* Many databases systems can start with a centralized storage model and later be expanded to act as a distributed database.

###### In-Memory Databases
* In-memory databases store all (or most) of their data in-memory (i.e. RAM). The information stored in an in-memory database is lost when the database is restarted.
* These databases are particularly suited to storing temporary work queues and other processing-oriented information.

###### Distributed Databases
* Distributed databases are stored across multiple machines and locations. This storage mechanism is used to speed up access and aid in disaster recovery.
* Distributed databases increase maintenance and administrative costs, as managing databases and fail-over across many locations typically requires more specialized knowledge.

#### Relational Databases
* There are many different types of databases that are suited to different specialized purposes.  However, in this class, we will be focusing on relational databases.
* Relational databases are databases that are based on the relational model, in which all data is stored in tuples (ordered lists of elements) and relations.
* Relational database data is stored in tables with specific schemas (specifications of exactly what kind of data is stored) and relationships (between tables).
Relational databases are particularly strong at storing and querying highly structured data that have rich relationships.
* Microsoft SQL Server, MySQL, Oracle and PostgreSQL are among the more famous relational database systems.

#### Normalization
* Don't put same data in 2 different places
