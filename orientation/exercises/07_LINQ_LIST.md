# LINQed List

## Setup

```
mkdir -p ~/workspace/csharp/exercises/linq && cd $_
dotnet new console
dotnet restore
```

## References

* [Write LINQ queries in C#](https://docs.microsoft.com/en-us/dotnet/csharp/linq/write-linq-queries)
* [101 LINQ Samples](https://code.msdn.microsoft.com/101-LINQ-Samples-3fb9811b)

## Instructions

Given the collections of items shown below, use LINQ to build the requested collection, and then `Console.WriteLine()` each item in that resulting collection.

```cs
// Find the words in the collection that start with the letter 'L'
List<string> fruits = new List<string>() {'Lemon', 'Apple', 'Orange', 'Lime', 'Watermelon', 'Loganberry'};

var LFruits = from fruit in fruits ...
```

```cs
// Which of the following numbers are multiples of 4 or 6
List<int> numbers = new List<int>()
{
    15, 8, 21, 24, 32, 13, 30, 12, 7, 54, 48, 4, 49, 96
}

var fourSixMultiples = numbers.Where();
```

```cs
// Order these student names alphabetically, in descending order (Z to A)
List<string> names = new List<string>()
{
    "Heather", "James", "Xavier", "Michelle", "Brian", "Nina",
    "Kathleen", "Sophia", "Amir", "Douglas", "Zarley", "Beatrice",
    "Theodora", "William", "Svetlana", "Charisse", "Yolanda",
    "Gregorio", "Jean-Paul", "Evangelina", "Viktor", "Jacqueline",
    "Francisco", "Tre" 
}

var descend = ...
```

```cs
/*
    Store each number in the following List until a perfect square
    is detected.

    Ref: https://msdn.microsoft.com/en-us/library/system.math.sqrt(v=vs.110).aspx
*/
List<int> wheresSquaredo = new List<int>()
{
    66, 12, 8, 27, 82, 34, 7, 50, 19, 46, 81, 23, 30, 4, 68, 14
}
var untilPerfectSquare = ...
```