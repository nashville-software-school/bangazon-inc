# Language Integrated Query

.NET Language-Integrated Query defines a set of general purpose standard query operators that allow traversal, filter, and projection operations to be expressed in a direct yet declarative way in any .NET-based programming language. The standard query operators allow queries to be applied to any `IEnumerable<T>`-based information source.

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
        Product[] shoppingCart = { 
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
            orderby product.Price
            select product;

    foreach (Product p in inexpensive)
        Console.WriteLine($"{p.Title} ${p.Price:f2}");
    }
}
```