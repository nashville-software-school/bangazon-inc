# Bag o' Loot

This exercise is your introduction to writing command line applications that interact with the user, and store their data in a persistent SQLite database. You may want to review the [Command Line User Input](../13_CLI_IO.md) tutorial again before starting on this one.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/bagoloot/BagOLoot && cd $_
dotnet new console
dotnet add package Microsoft.Data.SQLite --version 2.0.0
dotnet restore
mkdir ../BagOLoot.Tests && cd $_
dotnet new xunit
dotnet add reference ../BagOLoot/BagOLoot.csproj
dotnet restore
cd ..
code .
```

## Interface Guidelines

You have an acquaintance whose job is to, once a year, delivery presents to the best kids around the world. They have a problem, though. There are so many good boys and girls in the world now, that their old paper accounting systems just don't cut it anymore. They want you to write a program that will let them do the following tasks.

Here are what the options for each function should be.

```
WELCOME TO THE BAG O' LOOT SYSTEM
*********************************
1. Register a child
2. Assign toy to a child
3. Revoke toy from child
4. Review child's toy list
5. Child toy delivery complete
6. Yuletime Delivery Report
```

```
Enter the name of a child
>
```

```
Assign toy to which child?
1. Jamal
2. Susie
3. Kelly
4. Mike
5. Charisse
6. Erin
>
```

```
Enter toy to add to Jamal's Bag o' Loot
>
```

```
Remove toy from which child
1. Jamal
2. Susie
3. Kelly
4. Mike
5. Charisse
6. Erin
```

```
Choose toy to revoke from Kelly's Bag o' Loot
1. Science kit
2. Basketball
3. Legos
```

```
View Bag o' Loot for which child?
1. Jamal
2. Susie
3. Kelly
4. Mike
5. Charisse
6. Erin
```

```
Which child had all of their toys delivered?
1. Jamal
2. Susie
3. Kelly
4. Mike
5. Charisse
6. Erin
```

```
Yuletime Delivery Report
%%%%%%%%%%%%%%%%%%%%%%%%
Jamal
  1. Baseball
  2. Tonka truck

Kelly
  1. Science kit
  2. Basketball
  3. Legos
```


## Testing Requirements

> **Write tests before you write implementation code!!!!!**

1. Items can be added to bag, and assigned to a child.
1. Items can be removed from bag, per child. Removing `Ball`, for example, from the bag should not be allowed. A child's name must be specified.
1. Must be able to list all children who are getting a toy.
1. Must be able to list all toys for a given child's name.
1. Must be able to set the *delivered* property of a child, which defaults to `false` to `true`.

There are a couple unit tests to get your started in the boilerplate code repo that your instructor will assign to you via Github Classroom.

## Persistent Storage

> **Note:** Each toy is unique. If Mike and Susie are both getting a basketball, then each must be stored individually. The same basketball record is not shared by Mike and Susie.

You must persist the data in a SQLite database. Create a quick ERD that represents the two types of data in this application.

How are they related to each other?

What are the primary keys and foreign keys?

