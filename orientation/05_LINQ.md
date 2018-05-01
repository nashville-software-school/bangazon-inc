# Language Integrated Query

.NET Language-Integrated Query defines a set of general purpose standard query operators that allow traversal, filter, and projection operations to be expressed in a direct yet declarative way in any .NET-based programming language. The standard query operators allow queries to be applied to any `IEnumerable<T>`-based information source.

## Resources

[List of all LINQ methods](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/ef/language-reference/supported-and-unsupported-linq-methods-linq-to-entities)

### Visualization of LINQ methods

![linq methods chart](./assets/linq.jpg)

## Selecting Items from a Collection

```cs
using System;
using System.Linq;
using System.Collections.Generic;

public class Program
{
    public static void Main() {
        /*
            Start with a collection that is of type IEnumerable, which
            List is and initialize it with some values. This is the
            class sizes for a selection of NSS cohorts.
        */
        List<int> cohortStudentCount = new List<int>()
        {
            25, 12, 28, 22, 11, 25, 27, 24, 19
        };

        /*
            Now we need to determine which cohorts fell within the range
            of acceptable size - between 20 and 26 students. Also, sort
            the new enumerable collection in ascending order.
        */
        IEnumerable<int> idealSizes = from count in cohortStudentCount
            where count < 27 && count > 19
            orderby count ascending
            select count;

        // Display each number that was the acceptable size
        foreach (int c in idealSizes)
        {
            Console.WriteLine($"{c}");
        }
    }
}
```

## Using Aggregation Methods

There are also helper methods that let you do aggregate calculations on collections, such as getting the sum of all numbers, or finding the maximum value. Let's looks at some examples.

```cs
List<int> cohortStudentCount = new List<int>()
{
    25, 12, 28, 22, 11, 25, 27, 24, 19
};
Console.WriteLine($"Largest cohort was {cohortStudentCount.Max()}");
Console.WriteLine($"Smallest cohort was {cohortStudentCount.Min()}");
Console.WriteLine($"Total students is {cohortStudentCount.Sum()}");

IEnumerable<int> idealSizes = from count in cohortStudentCount
    where count < 27 && count > 19
    orderby count ascending
    select count;

Console.WriteLine($"Average ideal size is {idealSizes.Average()}");

// The @ symbol lets you create multi-line strings in C#
Console.WriteLine($@"
There were {idealSizes.Count()} ideally sized cohorts
There have been {cohortStudentCount.Count()} total cohorts");
```

This produces the following output.

```sh
Largest cohort was 28
Smallest cohort was 11
Total students is 193
22
24
25
25
Average ideal size is 24

There were 4 ideally sized cohorts
There have been 9 total cohorts
```

## Selecting Using Properties of Objects

It's not just for built-in types. In the following code, I define a custom type for representing products in the system. I can then use LINQ to filter a collection based on the properties of the type.

```cs
using System;
using System.Linq;
using System.Collections.Generic;

public class Product
{
    /*
    Properties
    */
    public string Title { get; set; }
    public double Price { get; set; }

    // Constructor method
    public Product (string title, double price)
    {
        this.Title = title;
        this.Price = price;
    }
}

public class Program
{

    public static void Main() {
        /*
            We can use curly braces to create instances of objects
            and immediately inject them into the List.
        */
        List<Product> shoppingCart = new List<Product>(){
            new Product("Bike", 109.99),
            new Product("Mittens", 6.49),
            new Product("Lollipop", 0.50),
            new Product("Pocket Watch", 584.00)
        };

        /*
            IEnumerable is an interface, which we'll get to later,
            that we're using here to create a collection of Products
            that we can iterate over.
        */
        IEnumerable<Product> inexpensive = from product in shoppingCart
            where product.Price < 100.00
            orderby product.Price descending
            select product;

        foreach (Product p in inexpensive) {
            Console.WriteLine($"{p.Title} ${p.Price:f2}");
        }

        /*
            You can also use `var` when creating LINQ collections. The
            following variable will still be typed as List<Product> by
            the compiler, but you don't need to type that all out.
        */
        var expensive = from product in shoppingCart
            where product.Price >= 100.00
            orderby product.Price descending
            select product;
    }
}
```

## LINQ and Lambdas

Remember your anonymous function syntax that you learned about in the client-side course? It was nice, clean syntax to pass a function to another function, such as `forEach()` or `map()`, or `filter()` on an array.

```js
// Given this JavaScript array of numbers
const numbers = [9, -59, 23, 71, -74, 13, 52, 44, 2]

/*
    Use filter() method to build a new array of numbers that
    match two conditions. Then chain the sort() method to order
    them ascending
*/
let smallPositiveNumbers = numbers.filter(n => n < 40 && n > 0).sort((f, s) => f - s)
```

Luckily for you, you can use lambdas in C#, and the syntax is almost identical using LINQ.

```cs
// Give this C# List of numbers
List<int> numbers = new List<int>(){ 9, -59, 23, 71, -74, 13, 52, 44, 2 };

/*
    Use the IEnumerable Where() method to build a new array of
    numbers that match two conditions. Then chain the OrderBy()
    method to order them ascending
*/
var smallPositiveNumbers = numbers.Where(n => n < 40 && n > 0).OrderBy(n => n);

/*
    Use All() to see if every item in the collection passes the
    provided conditions.
*/
var allBetweenLarge = numbers.All(n => n > -100 && n < 400);  // true
var allBetweenSmall = numbers.All(n => n > -5 && n < 39);  // false
```

Here's some more examples of how JavaScript Array methods and LINQ are similar:

## Determine if every item in a collection passes a condition

```cs
// JavaScript
const sampleNumbers = [18, 9, 5, 6, 84, 2, 5, 13];
const allAreEven = sampleNumbers.every(number => number % 2 == 0 );

// LINQ
List<int> sampleNumbers = new List<int> {18, 9, 5, 6, 84, 2, 5, 13};
bool areAllEven = sampleNumbers.All(number => number % 2 == 0);
```

## Limit an array to the items that meet a criteria

```cs
// JavaScript
var onlyEvens = sampleNumbers.filter(number => number % 2 == 0);

// LINQ
IEnumerable<int> onlyEvens = sampleNumbers.Where(number => number % 2 == 0);
```

## Perform an action on each item in an array

```cs
// JavaScript
onlyEvens.forEach(evenValue => { console.log(evenValue + " is an even value"); });

// LINQ
onlyEvens.ToList().ForEach(evenValue => Console.WriteLine(evenValue + " is an even value"));
```

## Transform each value in a collection

```cs
// JavaScript
var sampleNumbersSquared = sampleNumbers.map(number => number * number);

// LINQ
IEnumerable<int> sampleNumbersSquared = sampleNumbers.Select(number => number * number);
```

## First matching item

```cs
// JavaScript
const small = sampleNumber.find(n => n < 5);

// LINQ
int small = sampleNumbers.Single(n => n < 5);
```
