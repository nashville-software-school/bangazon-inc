# Common Types - Dictionary

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
Dictionary<string, int> toysSold = new Dictionary<string, int>() {
    {"hotWheels", 344},
    {"legos", 763},
    {"gamingConsoles", 551},
    {"boardGames", 298}
};
```

You can also use the `Add()` method to add more key/value pairs to a dictionary.

```cs
toysSold.Add("Bicycle", 87);
```

# Practice: Stock Purchase Dictionaries

## Setup

```
mkdir -p ~/workspace/csharp/exercises/dictionaries && cd $_
dotnet new console
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

Next, create another dictionary to hold stock purchases by an investor.

```cs
Dictionary<string, double> purchases = new Dictionary<string, double>();
```

Then add some purchases.

##### Example

```cs
purchases.Add("GE", 230.21));
purchases.Add("GE", 580.98));
purchases.Add("GE", 406.34));

// Add more purchases for each stock
```

Create a total ownership report that computes the total value of each stock that you have purchased. This is the basic relational database join algorithm between two tables.

> **Helpful Links:** [ContainsKey](https://msdn.microsoft.com/en-us/library/kw5aaea4(v=vs.110).aspx), [Add](https://msdn.microsoft.com/en-us/library/k7z0zy8k(v=vs.110).aspx)

```cs
/*
    Define a new Dictionary to hold the aggregated purchase information.
    - The key should be a string that is the full company name.
    - The value will be the total valuation of each stock


    From the three purchases above, one of the entries
    in this new dictionary will be...
        {"General Electric", 1217.53}

    Replace the questions marks below with the correct types.
*/
Dictionary<?, ?> stockReport = new Dictionary<?, ?>();

/*
   Iterate over the purchases and record the valuation
   for each stock.
*/
foreach (KeyValuePair<?, ?> purchase in purchases)
{
    // Does the company name key already exist?

    // If it does, update the total valuation

    /*
        If not, add the new key and set its value.
        You have the value of "GE", so how can you look
        the value of "GE" in the `stocks` dictionary
        to get the value of "General Electric"?
    */
}
```

