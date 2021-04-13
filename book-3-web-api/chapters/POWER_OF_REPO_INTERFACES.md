# Challenge: Audit Tables and  Power of Interfaces

> **NOTE:** This is a _challenge_ exercise and should only be attempted after you've completed all other exercises.

## Auditing Database Changes

As you know a database is used for "permanent" storage for our data. However, as you also know, "permanent" is only permanent until someone updates or deletes the data.

It's more accurate to say the database holds the  _state_ of our system, and that state may change over time.

As you might imagine, it's often useful to see the _previous_ states of a system. What did the database look like yesterday? Last week? Two years ago? This knowledge could be useful for debugging, for tracking trends, for investigating security breaches, and lots of other things.

There are many approaches to tracking changes to a database. In this exercise we're going to touch on an over-simplified implementation of one of the simpler techniques - writing to an _audit table_.

An [audit table](https://dba.stackexchange.com/questions/15186/what-is-an-audit-table) is a table in which each row describes a change that happened to another table within the database. A row is added to the audit table each time a record is inserted, updated or deleted from another table.

## What does this have to do with interfaces?

One way to write to an audit table - and the approach we'll use for this exercise - is to do so from a repository.

> **NOTE:** Another common approach to writing to an audit table is to use a [database trigger](https://en.wikipedia.org/wiki/Database_trigger).

One way to do this would be to update our repositories. For example, we could alter a `UserProfileRepository`'s `Add()` method so that after the code to insert a new record in the `UserProfile` table, we might add code to insert a record into the `Audit` table.

Altering our repositories would work, but imagine how large our methods would be. And even if we created private helper methods to breakout some of the functionality, our repository class would quickly grow to be bulky and complex. This is an indication - a [code smell](https://en.wikipedia.org/wiki/Code_smell) - that something is wrong.

Adding code to each repository would violate the [single responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle) because our code would have _more than one reason to change_. If we added a column to the `UserProfile` table, we'd need to update the repository, OR if we wanted to change the way we were auditing - maybe to write to a different database - we'd also need to update the repository.

## Seriously, what does this have to do with interfaces?

Ok, it's really time to talk about interfaces. As you know we create an interface to match each repository and it's the interface that we use in each controller. Well, it turns out this is the foundation we need to implementing an auditing repository. Technically speaking we are going to use the [Decorator Pattern](https://en.wikipedia.org/wiki/Decorator_pattern) to make a repository that performs CRUD operations on a database table AND writes audit records. And we won't have to change our existing repositories or our controllers.

## Exercise - Adding Auditing to Gifter

1. Create a SQL script that adds a table called `Audit` to the `Gifter` database. The database should have these columns.
     * Id - the primary key
     * TableName - the name of the table being audited
     * Operation - 'insert', 'update' or 'delete'
     * DateTime - date and time when the operation ocurred
     * OldValue - a single string that contains the entire record before the change. `null` for `insert` Operations
     * NewValue - a single string that contains the entire record after the change. `null` for `delete` operations.
1. Create an `AuditRepository` class that has a single method: `Add(string tableName, string operations, string oldValue, string newValue)`. This method should insert a new record into the `Audit` table.
1. Create an `AuditingPostRepository` class that implements the `IPostRepository` interface. This class should use the `PostRepository` and `AuditRepository` classes internally such that any insert, update or delete operation on the `Post` table is recorded in the `Audit` table.
1. Update the `Startup` class to use the new `AuditingPostRepository`.
1. Test it out.