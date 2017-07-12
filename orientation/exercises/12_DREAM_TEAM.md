# Define Your Dream Team with Classes

## Setup

```
mkdir -p ~/workspace/csharp/exercises/dreamteam && cd $_
dotnet new console
dotnet restore
```

## Instructions

Your job is to pick 5 of your teammates in your cohort and build a `class` for each one. Each teammate should have the following properties/methods. Build one for yourself, as well.

1. Specialty property - This holds the technology that the person enjoys the most.
1. FirstName property
1. LastName property
1. FullName property - This property is a readonly property that returns the first and last name concatenated.
1. Work() method - This will write a comical message to the console that describes the work they will do on a group project, based on their speciality.

Once you're done, you should have 6 different types in total, each with the properties and methods above.

For example...

```cs
public class Ed
{
  ...
}

public class Eliza
{
  ...
}

public class Mitchell
{
  ...
}

etc...
```

1. Create two groups (i.e. `List`) that will hold three teammates each. These two lists represent one team that will be the server side team, and one that will be the client side team.
1. Instantiate one instance of each of your teammates.
1. Put your teammates into the appropriate team.
    ```cs
    serverSide.Add(ed);
    serverSide.Add(eliza);
    serverSide.Add(kathy);

    clientSide.Add(preeti);
    clientSide.Add(mitchell);
    clientSide.Add(matt);
    ```
1. Write two `foreach` loops that iterate over each List and makes each of the teammates do their work.