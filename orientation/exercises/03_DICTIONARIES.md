# Stock Purchase Dictionaries

## Setup

We're going to use `ValueTuple` that was mentioned in the [tuple exercise](./02_TUPLES.md).

```
mkdir -p ~/workspace/csharp/exercises/dictionaries && cd $_
dotnet new console
dotnet add package System.ValueTuple
dotnet restore
```

## References

* [C# dictionaries](https://msdn.microsoft.com/en-us/library/xfhwa508(v=vs.110).aspx#Anchor_8)
* [Dictionary in C#](http://www.c-sharpcorner.com/UploadFile/219d4d/dictionary-in-C-Sharp-language/)
* [Interactive C# Dictionaries](http://www.learncs.org/en/Dictionaries)

## Instructions

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
