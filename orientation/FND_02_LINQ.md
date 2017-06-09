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
        Product[] shoppingCart = { 
            new Product("Bike", 109.99),
            new Product("Mittens", 6.49),
            new Product("Lollipop", 0.50),
            new Product("Pocket Watch", 584.00)
        };

        IEnumerable<Product> inexpensive = from product in shoppingCart 
            where product.Price < 100.00
            orderby product.Price
            select product;

    foreach (Product p in inexpensive)
        Console.WriteLine("{0} ${1:f2}", p.Title, p.Price);
    }
}
```