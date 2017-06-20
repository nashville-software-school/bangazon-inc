# Language Integrated Query

.NET Language-Integrated Query defines a set of general purpose standard query operators that allow traversal, filter, and projection operations to be expressed in a direct yet declarative way in any .NET-based programming language. The standard query operators allow queries to be applied to any `IEnumerable<T>`-based information source.

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

```
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
            and immediately inject them into the array.

            Also, arrays in C# cannot be added to dynamically like in
            JavaScript. In the code below, I'm initializing it to hold
            4 things and 4 things only.
        */
        List<Product> shoppingCart = new List<Product>{ 
            new Product("Bike", 109.99),
            new Product("Mittens", 6.49),
            new Product("Lollipop", 0.50),
            new Product("Pocket Watch", 584.00)
        };

        // IEnumerable is an interface, which we'll get to later,
        // that we're using here to create a collection of Products
        // that we can iterate over.
        IEnumerable<Product> inexpensive = from product in shoppingCart 
            where product.Price < 100.00
            orderby product.Price descending
            select product;

        foreach (Product p in inexpensive)
            Console.WriteLine($"{p.Title} ${p.Price:f2}");
        }
}
```