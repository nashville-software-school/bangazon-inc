# Stock Purchase Dictionaries

## Setup

```
mkdir -p ~/workspace/csharp/exercises/dictionaries && cd $_
dotnet new console
```

## References

* [C# dictionaries](https://msdn.microsoft.com/en-us/library/xfhwa508(v=vs.110).aspx#Anchor_8)
* [Dictionary in C#](http://www.c-sharpcorner.com/UploadFile/219d4d/dictionary-in-C-Sharp-language/)
* [DotNet Perls - Dictionary](https://www.dotnetperls.com/dictionary)


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

Create another dictionary that represents stock purchases. The key will be the ticker symbol and the value will be the number of shares purchased.

##### Example

```cs
Dictionary<string, int> purchases = new Dictionary<string, int>();
purchases.Add("GE", 150);
purchases.Add("AAPL", 13);
purchases.Add("CAT", 55);
purchases.Add("GE", 79);
purchases.Add("CAT", 55);
purchases.Add("APPL", 21);
// Add more for each stock you added to the stocks dictionary
```

Create a total ownership report that computes the total amount of each stock that you have purchased. This is the basic relational database join algorithm between two tables.

```cs
/* 
    Define a new Dictionary to hold the aggregated purchase information.
    - The key should be a string that is the full company name.
    - The value will be the aggregate of all stock owned for the company

    {
        "General Electric": 229,
        "AAPL": 34,
        ...
    }
*/

// Iterate over the purchases and 
foreach (KeyValuePair<string, int> purchase in purchases)
{
    // 
}
```

> **Helpful Links:** [ContainsKey](https://msdn.microsoft.com/en-us/library/kw5aaea4(v=vs.110).aspx), [Add](https://msdn.microsoft.com/en-us/library/k7z0zy8k(v=vs.110).aspx)
 