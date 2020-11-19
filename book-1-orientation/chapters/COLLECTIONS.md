# Collections

"Collection" is a broad term that means a kind of object that stores things.

Examples of collections in JavaScript are arrays and objects. Arrays store elements in order. We use numeric, positional indexes to access elements. Objects store key/value pairs in no particular order. Keys are strings and values can be anything. We look up a value using its key.

There are several collections in C#, This chapter covers a few commons ones.

> **NOTE:** If you'd like to dig deeper into collections take a look at [the documentation](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/collections).

## List&lt;T&gt;

In C#, a List is much like the arrays that you used in JavaScript. They are ordered collections of a objects.

* `List<int>` - List of integers
* `List<string>` - List of strings
* `List<bool>` - List of booleans
* `List<Customer>` - List of Customers

However, unlike JavaScript, lists can **only contain** one type. A list cannot be a collection of integers *and* strings.

```cs
// Totally fine code
List<int> yearsBorn = new List<int>() 
{
    1967, 1969, 1972
};
```

This code will produce red squiggles under 1967 and 1972. C# has no default way to convert a string into an integer, and it will tell you that.

```cs
// Bogus code
List<int> yearsBorn = new List<int>() 
{
    "1967", 1969, "1972"
};
```

Lists are found in the `System.Collections.Generic` namespace;

```cs
using System.Collections.Generic;
```

### A Note About  C# Arrays

You can use [arrays](https://docs.microsoft.com/en-us/dotnet/api/system.array?view=netcore-3.0) in C#, as well.

```cs
int[] itemsSold = new int[] {9, 12, 8, 8, 7, 14, 13, 9};
```

The downside to using arrays in C#, in particular for web application development, is that is not as easy to add and remove items from an array as it is when you use a `List`.

### The Power of Lists

The `List` collection in C# has the following methods that an array does not.

* [Add()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.add?view=netcore-3.0)
* [AddRange()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.addrange?view=netcore-3.0)
* [Insert()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.insert?view=netcore-3.0)
* [Find()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.find?view=netcore-3.0)
* [Remove()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.remove?view=netcore-3.0)
* [Contains()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.contains?view=netcore-3.0)
* [ForEach()](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.foreach?view=netcore-3.0)
* [Count](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.count?view=netcore-3.0)

```cs
using System;
using System.Collections.Generic;

namespace NSSOrientation
{
    public class Program
    {
        public static void Main()
        {
            List<string> students = new List<string>() 
            {
                "Mori", "Travis", "Braxton", "Parker",
                "Ember", "Matt", "CJ", "Sam",
                "Jerry", "Terra", "Brady"
            };

            // Can't do this easily with a base array
            students.Add("Adam");
            students.Insert(3, "Rose");

            if (students.Contains("Rose")) 
            {
                Console.WriteLine("Must be cohort 43");
            }

            // This looks a lot like JavaScript!
            students.ForEach(stu => Console.WriteLine(stu));
        }
    }
}
```

### Reference

* [C# Lists](https://msdn.microsoft.com/en-us/library/6sh2ey19(v=vs.110).aspx)
* [Interactive C# Lists](http://www.learncs.org/en/Lists)

## Dictionary&lt;TKey, TValue&gt;

In C#, a **`Dictionary`** is much like the objects that you used in JavaScript. They are collections of a key/value pairs - just strongly typed.

Here's a JavaScript object to represent toys sold by a business.

```js
const toysSold = {
    "hotWheels": 344,
    "legos": 763,
    "gamingConsoles": 551,
    "boardGames": 298
}
```

Here's how that would look in C# as a **`Dictionary`**.

```cs
Dictionary<string, int> toysSold = new Dictionary<string, int>() 
{
    {"Hot Wheels", 344},
    {"Legos", 763},
    {"Gaming Consoles", 551},
    {"Board Games", 298}
};
```

You can also use the `Add()` method to add more key/value pairs to a dictionary.

```cs
toysSold.Add("Bicycles", 87);
```

### Iterating a Dictionary

If you want to see all the toys and how many were sold, you can use a `foreach` to iterate over all of the `KeyValuePair` items in the dictionary.

```cs
foreach (KeyValuePair<string, int> toy in toysSold)
{
    Console.WriteLine($"We sold {toy.Value} units of {toy.Key}");
}
```

### References

* [C# dictionaries](https://msdn.microsoft.com/en-us/library/xfhwa508(v=vs.110).aspx#Anchor_8)
* [Dictionary in C#](http://www.c-sharpcorner.com/UploadFile/219d4d/dictionary-in-C-Sharp-language/)
* [Interactive C# Dictionaries](http://www.learncs.org/en/Dictionaries)

## IEnumerable&lt;T&gt;

Throughout your C# journey, you will also encounter a collection type called `IEnumerable`. This is a special type used by many [LINQ methods](./LINQ_INTRO.md). It's not as flexible as a List, but, good news, if you have an `IEnumerable`, you can convert it to a list with the `ToList()` method.

```cs
IEnumerable<string> names = data.GetNames();
List<string> nameList = names.ToList();
```
