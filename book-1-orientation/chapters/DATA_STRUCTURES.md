# Most Commonly Used Data Structures

## Lists, Dictionaries, and Sets

---

## New List of Planets

### Setup

```
mkdir -p ~/workspace/csharp/exercises/lists && cd $_
dotnet new console
```

### Reference

* [C# Lists](https://msdn.microsoft.com/en-us/library/6sh2ey19(v=vs.110).aspx)
* [Interactive C# Lists](http://www.learncs.org/en/Lists)

### Exercise

In the `Main` method, place the following code

```cs
List<string> planetList = new List<string>(){"Mercury", "Mars"};
```

1. `Add()` Jupiter and Saturn at the end of the list.
1. Create another `List` that contains that last two planet of our solar system.
1. Combine the two lists by using `AddRange()`.
1. Use `Insert()` to add Earth, and Venus in the correct order.
1. Use `Add()` again to add Pluto to the end of the list.
1. Now that all the planets are in the list, slice the list using `GetRange()` in order to extract the rocky planets into a new list called `rockyPlanets`.
1. Being good amateur astronomers, we know that Pluto is now a dwarf planet, so use the `Remove()` method to eliminate it from the end of `planetList`.

### Iterating over planets

> **Ref:** [List of Solar System probes](https://en.wikipedia.org/wiki/List_of_Solar_System_probes)

1. Create another list containing dictionaries. Each dictionary will hold the name of a spacecraft that we have launched, and the name of the planet that it has visited. If it visited more than one planet, just pick one.
    ```cs
    List<Dictionary<string, string>> probes = new List<Dictionary<string, string>>();
    probes["Mars"] = "Viking";
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

---

## Stock Purchase Dictionaries

### Setup

We're going to use `ValueTuple` that was mentioned in the [tuple exercise](./02_TUPLES.md).

```
mkdir -p ~/workspace/csharp/exercises/dictionaries && cd $_
dotnet new console
dotnet add package System.ValueTuple
dotnet restore
```

### References

* [C# dictionaries](https://msdn.microsoft.com/en-us/library/xfhwa508(v=vs.110).aspx#Anchor_8)
* [Dictionary in C#](http://www.c-sharpcorner.com/UploadFile/219d4d/dictionary-in-C-Sharp-language/)
* [Interactive C# Dictionaries](http://www.learncs.org/en/Dictionaries)

### Instructions

A block of publicly traded stock has a variety of attributes, we'll look at a few of them. A stock has a ticker symbol and a company name. Create a simple dictionary with ticker symbols and company names in the `Main` method.

##### Example

```cs
Dictionary<string, string> stocks = new Dictionary<string, string>();
stocks.Add("GM", "General Motors");
stocks.Add("CAT", "Caterpillar");
// Add a few more of your favorite stocks
```

To find a value in a Dictionary, you can use square bracket notation much like JavaScript object key lookups.

```cs
string GM = stocks["GM"];   <--- "General Motors"
```

Create list of ValueTuples that represents stock purchases. Properties will be `ticker`, `shares`, `price`.

```cs
List<(string ticker, int shares, double price)> purchases = new List<(string, int, double)>();
```

##### Example

```cs
purchases.Add((ticker: "GE", shares: 150, price: 23.21));
purchases.Add((ticker: "GE", shares: 32, price: 17.87));
purchases.Add((ticker: "GE", shares: 80, price: 19.02));
// Add more for each stock you added to the stocks dictionary
```

Create a total ownership report that computes the total value of each stock that you have purchased. This is the basic relational database join algorithm between two tables.

```cs
/*
    Define a new Dictionary to hold the aggregated purchase information.
    - The key should be a string that is the full company name.
    - The value will be the valuation of each stock (price*amount)

    {
        "General Electric": 35900,
        "AAPL": 8445,
        ...
    }
*/

// Iterate over the purchases and update the valuation for each stock
foreach ((string ticker, int shares, double price) purchase in purchases)
{
    // Does the company name key already exist in the report dictionary?

    // If it does, update the total valuation

    // If not, add the new key and set its value
}
```

> **Helpful Links:** [ContainsKey](https://msdn.microsoft.com/en-us/library/kw5aaea4(v=vs.110).aspx), [Add](https://msdn.microsoft.com/en-us/library/k7z0zy8k(v=vs.110).aspx)

---

## Car Sets

### Setup

```sh
mkdir -p ~/workspace/csharp/exercises/sets && cd $_
dotnet new console
dotnet restore
```

### References

* [C# HashSet](https://msdn.microsoft.com/en-us/library/bb359438.aspx)


### Instructions

1. Create an empty HashSet named `Showroom` that will contain strings.
1. Add four of your favorite car model names to the set.
1. Print to the console how many cars are in your show room.
1. Pick one of the items in your show room and add it to the set again.
1. Print your showroom again, and notice how there's still only one representation of that model in there.
1. Create another set named `UsedLot` and add two more car model strings to it.
1. Use the `UnionWith()` method on `Showroom` to add in the two models you added to `UsedLot`.
1. You've sold one of your cars. Remove it from the set with the `Remove()` method.

### Acquiring more cars

1. Now create another HashSet of cars in a variable `Junkyard`. Someone who owns a junkyard full of old cars has approached you about buying the entire inventory. In the new set, add some different cars, but also add a few that are the same as in the `Showroom` set.
1. Create a new HashSet of your show room  with `HashSet<string> clone = new HashSet<string>(Showroom);`
1. Use the `IntersectWith()` method on the clone to see which cars exist in both the show room and the junkyard.
1. Now you're ready to buy the cars in the junkyard. Use the `UnionWith()` method to combine the junkyard into your showroom.
1. Use the `Remove()` method to remove any cars that you acquired from the junkyard that you don't want in your showroom.
