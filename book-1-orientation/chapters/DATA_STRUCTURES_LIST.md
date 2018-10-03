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

```cs
// Also rad code
List<int> yearsBorn = new List<int>() {
    1967, 1969, 1972
};
```

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

## Iterating over planets

> **Ref:** [List of Solar System probes](https://en.wikipedia.org/wiki/List_of_Solar_System_probes)

1. Create another list containing dictionaries. Each dictionary will hold the name of a spacecraft that we have launched, and the name of the planet that it has visited. If it visited more than one planet, just pick one.
    ```cs
    List<Dictionary<string, string>> probes = new List<Dictionary<string, string>>();
    ```
1. Iterate over your list of planets from above, and inside that loop, iterate over the list of dictionaries. Write to the console, for each planet, which satellites have visited which planet.
    ```cs
    foreach () // iterate planets
    {
        List<string> matchingProbes = new List<string>();

        foreach() // iterate probes
        {
            /*
                Does the current Dictionary contain the key of
                the current planet? Investigate the ContainsKey()
                method on a Dictionary.

                If so, add the current spacecraft to `matchingProbes`.
            */
        }

        /*
            Use String.Join(",", matchingProbes) as part of the
            solution to get the output below. It's the C# way of
            writing `array.join(",")` in JavaScript.
        */
        Console.WriteLine($"{}: {}");
    }
    ```

#### Example Output in the Terminal

```sh
Mars: Viking, Opportunity, Curiosity
Venus: Mariner, Venera
```
