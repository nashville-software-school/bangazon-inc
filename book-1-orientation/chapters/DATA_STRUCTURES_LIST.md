# Common Types - List

In C#, a List is much like the arrays that you used in JavaScript. They are collections of a objects that are all of a specific type.

* List of integers
* List of strings
* List of booleans
* List of Customers

However, unlike JavaScript, lists can **only contain** one type. A list cannot be a collection of integers *and* strings.

```cs
// Totally fine code
List<int> yearsBorn = new List<int>() {
    1967, 1969, 1972
};
```

This code will produce red squiggles under 1967 and 1972. C# has no default way to convert a string into an integer, and it will tell you that.

```cs
// Bogus code
List<int> yearsBorn = new List<int>() {
    "1967", 1969, "1972"
};
```

## A More Powerful Array

You can use [arrays](https://docs.microsoft.com/en-us/dotnet/api/system.array?view=netcore-2.1) in C#, as well.

```cs
int[] itemsSold = new int[] {9, 12, 8, 8, 7, 14, 13, 9};
```

The downside to using arrays in C#, in particular for web application development, is that is not as easy to add and remove items from an array as it is when you use a `List`.

The `List` collection in C# has the following methods that an array does not.

* [Add()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.add?view=netcore-2.1)
* [AddRange()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.addrange?view=netcore-2.1)
* [Insert()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.insert?view=netcore-2.1)
* [Find()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.find?view=netcore-2.1)
* [Remove()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.remove?view=netcore-2.1)
* [Contains()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.contains?view=netcore-2.1)

```cs
using System.Collections.Generic;

namespace NSSOrientation
{
    public class Program
    {
        public static void Main()
        {
            List<string> students = new List<string>() {
                "Megan", "Damon", "Chase", "Tekisha",
                "Castle", "Mark", "Keith", "Adam",
                "Patrick", "Hannah", "Mike"
            }

            // Can't do this easily with a base array
            students.Add("Melanie");
            students.Insert(3, "Simon");

            if (students.Contains("Chase")) {
                Console.WriteLine("Must be cohort 13");
            }

            // This looks a lot like JavaScript!
            students.ForEach(stu => Console.WriteLine(stu));
        }
    }
}
```

## Reference

* [C# Lists](https://msdn.microsoft.com/en-us/library/6sh2ey19(v=vs.110).aspx)
* [Interactive C# Lists](http://www.learncs.org/en/Lists)

# Practice: Planet and Spaceships

## Setup

```
mkdir -p ~/workspace/csharp/exercises/lists && cd $_
dotnet new console
```

## Instructions

In the `Main` method, place the following code

```cs
List<string> planetList = new List<string>(){"Mercury", "Mars"};
```

1. `Add()` Jupiter and Saturn at the end of the list.
1. Create another `List` that contains that last two planet of our solar system.
1. Combine the two lists by using `AddRange()`.
1. Use `Insert()` to add Earth, and Venus in the correct order.
1. Use `Add()` again to add Pluto to the end of the list.
1. Now that all the planets are in the list, slice the list using `GetRange()` in order to extract the rocky planets into a new list called `rockyPlanets`. The rocky planets will remain in the original planets list.
1. Being good amateur astronomers, we know that Pluto is now a dwarf planet, so use the `Remove()` method to eliminate it from the end of `planetList`.

# Practice: Random Numbers


## Instructions
1. Use the following code to create a list of random numbers. Each number will be between 0 and 9.
    ```cs
    Random random = new Random();
    List<int> numbers = new List<int> {
        random.Next(10),
        random.Next(10),
        random.Next(10),
        random.Next(10),
        random.Next(10),
    };
    ```
1. Use a `for` loop to iterate over all numbers between `0` and `numbers.Count - 1`. 
1. Inside the body of the `for` loop determine if the current loop index is contained inside of the `numbers` list. Print a message to the console indicating whether the index is in the list.

#### Example Output in the Terminal
```sh
numbers list contains 0
numbers list does not contain 1
numbers list does not contain 2
numbers list contains 3
numbers list contains 4
```
**NOTE:** Each run will produce different output.

 
> **Further Reading**
> [Random class in .net](https://docs.microsoft.com/en-us/dotnet/api/system.random?view=netframework-4.7.2)
