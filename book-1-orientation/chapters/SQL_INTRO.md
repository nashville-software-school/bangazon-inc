# Introduction to SQL with Music History

## What is SQL?

**Structured Query Language** (**SQL**) is the language for interacting with relational databases. It has commands for all the CRUD operations.

* **INSERT**: Create a new record in a table
* **SELECT**: Read records from a table or combination of joined tables
* **UPDATE**: Update records in a table
* **DELETE**: Delete records from a table

What is a **relational database**? A relational database is one that stores data in tables and allows you to specify the relationships between records in those tables.

## Setup

1. Open **Azure Data Studio**.
1. Connect to the master database.
1. Run [this SQL script](./assets/musichistory_create.sql) inside ADS to create a new database named `MusicHistory`.
1. Delete the SQL from the previous step, and run [this SQL script](./assets/musichistory.sqlserver.sql) inside ADS to create tables in your database and insert some seed data.
1. Type `ctrl+G` to view your connections.
1. Right click your connection and choose _New Query_
    ![open a new query window](./images/ads_newquery.gif)

You will be writing your SQL statements in this new, blank query window.

## Querying Data

Querying the database is how you ask for data that is stored in it. Here's some starter examples.

In the Music History database, there is a list of songs stored in the `Song` table. Here is how you would ask to see all of the rows in that table. You can specify every column in a table.

```sql
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song;
```

However, if you only need information from a smaller set of columns, you can specify only those.

```sql
SELECT
    Id,
    Title,
    ReleaseDate
FROM Song;
```

A shortcut that you can use during development (but never in the final production code) is the asterisk - which mean select all columns. The following query is will return that same set of results that the first query above returned.

```sql
SELECT * FROM Song;
```

## Filtering Queries

The `WHERE` clause on a SQL query will filter the results. If you want to find songs that have a duration greater than 100 seconds, you would use the following query.

```sql
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song
WHERE SongLength > 100
;
```

## Joining Tables

Use `JOIN`s to combine tables together into one result set.

```sql
SELECT s.Title,
       a.ArtistName
  FROM Song s
       LEFT JOIN Artist a on s.ArtistId = a.id;
```

### SQL Joins Visualized
![SQL Joins](./images/SQL_Joins.svg)

## Creating New Data

Create a new row in the `Genre` table to represent techno music.

```sql
INSERT INTO Genre (Label) VALUES ('Techno');
```

## Updating Existing Data

Change the length (in seconds) for one of the songs.

```sql
select * from Song where Id = 18;
> 664

update Song
set SongLength = 515
where Id = 18;

select * from Song where Id = 18;
> 515
```

## Deleting Data

You can use the `DELETE` keyword to remove rows from your database tables.

```sql
delete from Song where Id = 18;
```

Be wary of leaving off the `WHERE` clause. The following SQL statement will remove **ALL ROWS** from the table.

```sql
delete from Song;
```



## References

* [SQLBolt Learn SQL with simple, interactive exercises.](https://sqlbolt.com/)
* [Introductory SQL tutorial](http://www.sqlcourse.com/)
* [W3schools interactive SQL tutorial](https://www.w3schools.com/sql/sql_intro.asp)
* [SQL Server Functions](https://www.w3schools.com/sqL/sql_ref_sqlserver.asp)

## Instructions

1. Using the **Object Explorer** in Azure Data Studio, examine the tables, columns, and foreign keys of the database.
1. Using the `dbdiagram.io` site, create an ERD for the database.

For each of the following exercises, provide the appropriate query. Yes, even the ones that are expressed in the form of questions. Everything from class and the references listed above is fair game.

1. Query all of the entries in the `Genre` table
1. Using the `INSERT` statement, add one of your favorite artists to the `Artist` table.
1. Using the `INSERT` statement, add one, or more, albums by your artist to the `Album` table.
1. Using the `INSERT` statement, add some songs that are on that album to the `Song` table.
1. Write a `SELECT` query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the [`LEFT JOIN`](https://www.tutorialspoint.com/sql/sql-using-joins.htm) keyword sequence to connect the tables, and the `WHERE` keyword to filter the results to the album and artist you added.
    > **Reminder:** Direction of join matters. Try the following statements and see the difference in results.

    ```
    SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.AlbumId;
    SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.AlbumId;
    ```
1. Write a `SELECT` statement to display how many songs exist for each album. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
1. Write a `SELECT` statement to display how many songs exist for each artist. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
1. Write a `SELECT` statement to display how many songs exist for each genre. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
1. Using `MAX()` function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
1. Using `MAX()` function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
1. Modify the previous query to also display the title of the album.