# Dealing with Data

As you know a major aspect of software development is the searching, filtering and transformation of data. We often use the umbrella term, _query_, to encompass this broad concept. In C# applications it's common to invoke SQL to query data directly in the database, but it's sometimes the case that our data isn't in a database. For example, we may retrieve data from a web API or from a text file. How do we handle these situations?

> **NOTE:** We haven't, yet, discussed mixing SQL into our C# applications. We'll do that soon, but for now just know that it's possible. This chapter will discuss tools for handling data when SQL is not an option.

## Collections of Objects

Before we can talk about querying data, we should first define what we mean by "data".

Put simply when we talk about data we are usually talking about collections of objects, where each object is a collection of properties that describe a particular entity. For example, if we were to build an application to help manage our creepy garden gnome collection, it might contain a list of garden gnome objects in which each object has an `id`, a `name`, a `description` and a `note about the blood sacrifices it requires in order to remain docile`.

In JavaScript we use arrays to contain data. In C# we usually use `List`s. JavaScript arrays provide a variety of methods to help us manipulate data. In C# we use _LINQ_.

## LINQ

LINQ _(Language-INtegrated Query)_ is a set of methods defined in the `System.Linq` namespace that provide a concise syntax for searching, filtering and transforming collections of objects.

### Example

Imagine we have the following `Person` class.

> Person.cs

```cs
public class Person
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public int Age { get; set; }
}
```

Elsewhere in our code we get a `List<Person>` and we'd like to query that list to get the full names of everyone in their 20s.

> SomeOtherCode.cs

```cs
// It doesn't matter where the people come from.
List<Person> people = dataGetter.GetSomePeople();

List<string> twentySomethings =
    people
        .Where(p => p.Age >= 20 && p.Age < 30)
        .Select(p => $"{p.FirstName} {p.LastName}")
        .ToList();
```

The above code is probably not _too_ cryptic, but it might help to see how we'd write equivalent code in JavaScript.

> SomeCode.js

```js
const people = getSomePeople();

const twentySomethings = 
    people
        .filter(p => p.age >= 20 && p.age < 30)
        .map(p => `${p.firstName} ${p.lastName}`);
```

As you can see there's a lot of similarities. We might say the _shape_ of the code is the same in both the C# and JavaScript versions. This is an important demonstration of the similarities between languages, but for now let's focus on the differences.

* Variables in C# require explicit types
* The C# code uses a method called `Where` instead of `filter`
* The C# code uses a method called `Select` instead of `map`
* The C# code calls a `ToList()` method, and there is no need for such a method in JavaScript

## LINQ Methods

There are a _lot_ of LINQ methods. Some are more commonly used that others, and some are pretty complex and hard to understand. We'll focus our attention on the more common and relatively simple methods.

> **NOTE:** The examples below will use the `people` list we defined above.  

> **NOTE:** Most of the methods listed below have several _overloads_ - meaning there are alternative versions of the method that are not described here.

### Finding and Filtering

#### FirstOrDefault()

This method returns the first instance of the object that matches a given condition.

If no object matches it returns the default value for the type. This is usually `null`, but would be `0` for numbers, `false` for booleans, etc...

##### Example

```cs
Person carol = people.FirstOrDefault(p => p.FirstName == 'Carol');
```

##### JavaScript Equivalent

Find()

---

#### Skip

This method skips a specified number of items in the collection and then returns the rest.

##### Example

```cs
List<Person> skipFirstFive = people.Skip(5).ToList();
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Take

This method returns the given number of objects from the collection starting at the beginning.

##### Example

```cs
List<Person> firstThree = people.Take(3).ToList();
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Where

This method returns all objects that match a given condition.

##### Example

```cs
List<Person> people.Where(p => p.Age > 18).ToList();
```

##### JavaScript Equivalent

filter()

---

### Transforming Data

#### Select

This method converts a collection of objects of one type into a collection of objects of another type.

##### Example

```cs
List<int> ages = people.Select(p => p.Age).ToList();
```

##### JavaScript Equivalent

map()

---

### Sorting and Reversing

#### OrderBy

This method returns a new collection of objects sorted by the given expression.

##### Example

```cs
List<People> sortedByLastName = people.OrderBy(p => p.LastName).ToList();
```

##### JavaScript Equivalent

sort()

---

#### OrderByDescending

This method is like `OrderBy`, but sorts in the opposite direction.

##### Example

```cs
List<People> sortedByAgeOldestFirst = people.OrderByDescending(p => p.Age).ToList();
```

##### JavaScript Equivalent

sort()

---

### Reverse

This method returns a new collection in the opposite order of the initial collection.

##### Example

```cs
List<People> inverted = people.Reverse().ToList();
```

##### JavaScript Equivalent

reverse()

---

### Inspecting a Collection

#### All

This method returns true if every object meets a given condition.

##### Example

```cs
bool areAllAdults = people.All(p => p.Age >= 18);
```

##### JavaScript Equivalent

every()

---

#### Any

This method returns true if at least one of the objects meets a given condition.

##### Example

```cs
bool hasSmith = people.Any(p => p.LastName == "Smith");
```

##### JavaScript Equivalent

some()

---

#### Contains

This method returns true if the collection contains the given object.

##### Example

```cs
List<int> ages = people.Select(p => p.Age).ToList();
bool hasFortyTwo = ages.Contains(42);
```

##### JavaScript Equivalent

includes()

---

### Numbers and Math

#### Average

This method finds the average value of a given property in a collection.

##### Example

```cs
double avgAge = people.Average(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Max

This method finds the maximum value of the given property within the collection.

##### Example

```cs
int maxAge = people.Max(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Min

This method finds the minimum value of the given property within the collection.

##### Example

```cs
int maxAge = people.Min(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Sum

This method sums the values of given property in each object.

##### Example

```cs
int totalAge = people.Sum(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

## IEnumerable

In the above examples you probably noticed calls to a `ToList()` method chained after the call to many of LINQ methods. It may not surprise you to learn that this method returns a `List`, but it might surprise you that we have to call it all over the place.

In JavaScript many of the array method - such as `map()` and `filter()` - return an array, so you might expect LINQ methods - such as `Select()` and `Where()` - to return a `List`. However, this is NOT the case.

The LINQ methods that return a collection of items always return an `IEnumerable` and do NOT return a `List`.

So what is this `IEnumerable` thing? As the first letter of the name implies `IEnumerable` is an interface. It is implemented by the collections provided by .NET, and so is used as a central place to place LINQ methods.

If the above paragraph seems vague and technical to you, that's because it's vague and technical. The good news is you don't really need to understand it in order to get the benefits of LINQ. **All you need to know is when you need a list call the `ToList()` method.**

## LINQ's Query Syntax

You may have noticed that the names of many of the LINQ methods match keywords in SQL. This is no accident. In 2007 when LINQ was added to .NET it was a very new and confusing concept for many developers. LINQ's creators thought it would be easier to grasp if developers could associate it with the SQL concepts they already understood. 

> **NOTE:** Whether this was a good idea is debatable.

It turns out they didn't stop at choosing SQL inspired names for LINQ methods. They also decided to make an alternative and _completely different_ syntax for LINQ to make it seem even more SQL-like. This syntax is usually called the _query syntax_.

Here's the example from the beginning of the chapter re-written using the query syntax.

```cs
List<Person> people = dataGetter.GetSomePeople();

List<string> twentySomethings = (
        from p in people
        where p.Age >= 20 && p.Age < 30
        select $"{p.FirstName} {p.LastName}"
    ).ToList();
```

As you can see the query syntax looks a bit like a jumbled version of SQL...sorta...

We will not be using the query syntax in this course, but you will likely encounter it online, and you may encounter it on the job.

> **NOTE:** The syntax we've used throughout the bulk of this chapter - and will use throughout the course - is called the _method syntax_.

---


.NET Language-Integrated Query defines a set of general purpose standard query operators that allow traversal, filter, and projection operations to be expressed in a direct yet declarative way in any .NET-based programming language. The standard query operators allow queries to be applied to any `IEnumerable<T>`-based information source.




## LINQ Methods

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

## Sorting a collection

```cs
// JavaScript
let sorted = numbers.sort();

// LINQ
IEnumerable<int> sorted = numbers.OrderBy(n => n);
IEnumerable<int> sorted = numbers.OrderByDescending(n => n);
```

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
int small = sampleNumbers.First(n => n < 5);
// ...or...
int small = sampleNumbers.FirstOrDefault(n => n < 5);
```

## Select Using a Custom Type

### Person.cs
```cs
using System;
using System.Collections.Generic;

namespace linqExample
{
    public class Person 
    {
        public string FirstName {get; set;}
        public string LastName {get; set;}
        public DateTime DOB {get; set;}
        public List<string> NickNames {get; set;}
    }
 }
 ```
 ### ReportEntry.cs
 ```cs
 using System;
 
 namespace linqExample
{
    public class ReportEntry
    {
        public string FullName { get; set; }
        public DateTime DOB { get; set; }
        public int NickNameCount { get; set; }
    }
}
 ```
 ### Program.cs
 ```cs
using System;
using System.Collections.Generic;
using System.Linq;
 
 namespace linqExample
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Person> people = new List<Person>(){
                new Person(){
                    FirstName = "Ed", LastName = "Reed", DOB = new DateTime(1970, 04, 10),
                    NickNames = new List<string>(){
                        "Ed", "Goose", "Beast"
                    }
                },
                new Person(){
                    FirstName = "Dwayne", LastName = "Johnson", DOB = new DateTime(1966, 10, 11),
                    NickNames = new List<string>(){
                        "The Rock"
                    }
                },
                new Person(){
                    FirstName = "Bob", LastName = "Smith", DOB = new DateTime(1944, 12, 25),
                    NickNames = new List<string>(){
                        "Robby", "Smitty", "Bud", "The Tiger"
                    }
                },

            };

            //Use LINQ to generate a report a report that includes the pesron's name, their DOB and the number of nicknames they have
            // For example: Bob Smith (12/25/44) has 4 Nickname(s)

            List<ReportEntry> nickNameReport = people.Select(p => 
                new ReportEntry {
                    FullName = $"{p.FirstName} {p.LastName}",
                    DOB = p.DOB,
                    NickNameCount = p.NickNames.Count
                }
            ).ToList();

            foreach (ReportEntry re in nickNameReport)
            {
                Console.WriteLine($"{re.FullName} ({re.DOB.ToShortDateString()}) has {re.NickNameCount} Nickname(s)");
            }


        }
    }
}
```

## The "Query" Syntax

Up til now we've been using what is refereed to as the LINQ "method" syntax. This means we've been calling methods on our collections to do what we need. This is by far the most common approach to using LINQ, but it's not the only one. C# also provides us the so-called "query" syntax. You will sometimes see it used and, once in a while (as we shall see), it's a more readable syntax.

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


## Using a `group by`
### SalesReportEntry.cs
```cs
using System;

namespace linqGroupBy
{
    public class SalesReportEntry
    {
        public string ReportNeighborhood { get; set; }
        public double ReportTotalSales { get; set; }
    }
}
```
### Kid.cs
```cs
using System;

namespace linqGroupBy
{
    public class Kid 
    {
        public string FullName {get; set;}
        public string Neighborhood {get; set;}
        public double Sales {get; set;}
    }
}
```
### Program.cs
```cs
using System;
using System.Collections.Generic;
using System.Linq;

namespace linqGroupBy
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Kid> kids = new List<Kid>(){
                new Kid(){
                    FullName = "Billy Smith", Neighborhood = "Nolensville", Sales = 67.16
                },
                new Kid(){
                    FullName = "Jason Sync", Neighborhood = "North Nashville", Sales = 13.16
                },
                new Kid(){
                    FullName = "Kyle Edwards", Neighborhood = "Nolensville", Sales = 117.10
                },
                new Kid(){
                    FullName = "Avery Barkley", Neighborhood = "The Nations", Sales = 97.16
                },
                new Kid(){
                    FullName = "Audrey Ellington", Neighborhood = "Nolensville", Sales = 57.18
                },
                new Kid(){
                    FullName = "Juanita Voss", Neighborhood = "North Nashville", Sales = 147.12
                },
                new Kid(){
                    FullName = "Scott Avett", Neighborhood = "North Nashville", Sales = 56.11
                }
            };

             List<SalesReportEntry> salesReport = (from kid in kids
             //dealing with kids list
                group kid by kid.Neighborhood into neighborhoodGroup
            //now dealing with neighborhoodGroup list
                select new SalesReportEntry {
                    ReportNeighborhood = neighborhoodGroup.Key, 
                    ReportTotalSales = neighborhoodGroup.Sum(kidObj => kidObj.Sales)
                }).OrderByDescending(sr => sr.ReportTotalSales).ToList();

            foreach(SalesReportEntry entry in salesReport)
            {
                Console.WriteLine($"{entry.ReportNeighborhood}, {entry.ReportTotalSales}");
            }
        }
    }
}
```


## Practice: LINQed List

### Setup

```
mkdir -p ~/workspace/csharp/exercises/linq && cd $_
dotnet new console
```

### References

* [Videos: What is LINQ?](https://www.youtube.com/watch?v=z3PowDJKOSA&list=PL6n9fhu94yhWi8K02Eqxp3Xyh_OmQ0Rp6)
* [Write LINQ queries in C#](https://docs.microsoft.com/en-us/dotnet/csharp/linq/write-linq-queries)
* [101 LINQ Samples](https://code.msdn.microsoft.com/101-LINQ-Samples-3fb9811b)

### Instructions

Given the collections of items shown below, use LINQ to build the requested collection, and then `Console.WriteLine()` each item in that resulting collection.

### Restriction/Filtering Operations

```cs
// Find the words in the collection that start with the letter 'L'
List<string> fruits = new List<string>() {"Lemon", "Apple", "Orange", "Lime", "Watermelon", "Loganberry"};

IEnumerable<string> LFruits = from fruit in fruits ...
```

```cs
// Which of the following numbers are multiples of 4 or 6
List<int> numbers = new List<int>()
{
    15, 8, 21, 24, 32, 13, 30, 12, 7, 54, 48, 4, 49, 96
};

IEnumerable<int> fourSixMultiples = numbers.Where();
```

### Ordering Operations

```cs
// Order these student names alphabetically, in descending order (Z to A)
List<string> names = new List<string>()
{
    "Heather", "James", "Xavier", "Michelle", "Brian", "Nina",
    "Kathleen", "Sophia", "Amir", "Douglas", "Zarley", "Beatrice",
    "Theodora", "William", "Svetlana", "Charisse", "Yolanda",
    "Gregorio", "Jean-Paul", "Evangelina", "Viktor", "Jacqueline",
    "Francisco", "Tre"
};

List<string> descend = ...
```

```cs
// Build a collection of these numbers sorted in ascending order
List<int> numbers = new List<int>()
{
    15, 8, 21, 24, 32, 13, 30, 12, 7, 54, 48, 4, 49, 96
};
```

### Aggregate Operations

```cs
// Output how many numbers are in this list
List<int> numbers = new List<int>()
{
    15, 8, 21, 24, 32, 13, 30, 12, 7, 54, 48, 4, 49, 96
};
```

```cs
// How much money have we made?
List<double> purchases = new List<double>()
{
    2340.29, 745.31, 21.76, 34.03, 4786.45, 879.45, 9442.85, 2454.63, 45.65
};
```

```cs
// What is our most expensive product?
List<double> prices = new List<double>()
{
    879.45, 9442.85, 2454.63, 45.65, 2340.29, 34.03, 4786.45, 745.31, 21.76
};
```

### Partitioning Operations

```cs
List<int> wheresSquaredo = new List<int>()
{
    66, 12, 8, 27, 82, 34, 7, 50, 19, 46, 81, 23, 30, 4, 68, 14
};
/*
    Store each number in the following List until a perfect square
    is detected.

    Expected output is { 66, 12, 8, 27, 82, 34, 7, 50, 19, 46 } 

    Ref: https://msdn.microsoft.com/en-us/library/system.math.sqrt(v=vs.110).aspx
*/
```

### Using Custom Types
#### Customer.cs
```cs
// Build a collection of customers who are millionaires

using System;

namespace CustomTypeExample 
{

    public class Customer
    {
        public string Name { get; set; }
        public double Balance { get; set; }
        public string Bank { get; set; }
    }
    
}
```
#### Program.cs
```cs

using System;
using System.Collections.Generic;
using System.Linq;

namespace CustomTypeExample 
{
    public class Program
    {
        public static void Main() 
        {
            List<Customer> customers = new List<Customer>() 
            {
                new Customer(){ Name="Bob Lesman", Balance=80345.66, Bank="FTB"},
                new Customer(){ Name="Joe Landy", Balance=9284756.21, Bank="WF"},
                new Customer(){ Name="Meg Ford", Balance=487233.01, Bank="BOA"},
                new Customer(){ Name="Peg Vale", Balance=7001449.92, Bank="BOA"},
                new Customer(){ Name="Mike Johnson", Balance=790872.12, Bank="WF"},
                new Customer(){ Name="Les Paul", Balance=8374892.54, Bank="WF"},
                new Customer(){ Name="Sid Crosby", Balance=957436.39, Bank="FTB"},
                new Customer(){ Name="Sarah Ng", Balance=56562389.85, Bank="FTB"},
                new Customer(){ Name="Tina Fey", Balance=1000000.00, Bank="CITI"},
                new Customer(){ Name="Sid Brown", Balance=49582.68, Bank="CITI"}
            };
        }
    }
}
```

```cs
/*
    Given the same customer set, display how many millionaires per bank.
    Ref: https://stackoverflow.com/questions/7325278/group-by-in-linq

    Example Output:
    WF 2
    BOA 1
    FTB 1
    CITI 1
*/
```

## Challenge

### Introduction to Joining Two Related Collections

As a light introduction to working with relational databases, this example works with two collections of data - `banks` and `customers` - that are related through the `Bank` attribute on the customer. In that attribute, we store the abbreviation for a bank. However, we want to get the full name of the bank when we produce our output.

This is called joining the collections together.

Read the [Cross Join](https://code.msdn.microsoft.com/LINQ-Join-Operators-dabef4e9#crossjoin) example to get started.
> **NOTE**: You might also find this page on the Microsoft Docs site helpful.
> * [Enumerable.Join Method ](https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.join?view=netframework-4.8#System_Linq_Enumerable_Join__4_System_Collections_Generic_IEnumerable___0__System_Collections_Generic_IEnumerable___1__System_Func___0___2__System_Func___1___2__System_Func___0___1___3__)

TASK: As in the previous exercise, you're going to output the millionaires, but you will also display the full name of the bank. You also need to sort the millionaires' names, ascending by their LAST name.
    
```cs
/*
    Example output:
        Tina Fey at Citibank
        Joe Landy at Wells Fargo
        Sarah Ng at First Tennessee
        Les Paul at Wells Fargo
        Peg Vale at Bank of America
*/
```
#### Bank.cs
```cs
using System;

// Define a bank
namespace Challenge 
{
    public class Bank
    {
        public string Symbol { get; set; }
        public string Name { get; set; }
    }
}
```
#### Customer.cs
```cs
using System;

// Define a customer
namespace Challenge 
{
    public class Customer
    {
        public string Name { get; set; }
        public double Balance { get; set; }
        public string Bank { get; set; }
    }
}
```
#### Program.cs
```cs
using System;
using System.Collections.Generic;
using System.Linq;

namespace Challenge 
{
    public class Program
    {
        public static void Main() 
        {
            // Create some banks and store in a List
            List<Bank> banks = new List<Bank>() {
                new Bank(){ Name="First Tennessee", Symbol="FTB"},
                new Bank(){ Name="Wells Fargo", Symbol="WF"},
                new Bank(){ Name="Bank of America", Symbol="BOA"},
                new Bank(){ Name="Citibank", Symbol="CITI"},
            };

            // Create some customers and store in a List
            List<Customer> customers = new List<Customer>() {
                new Customer(){ Name="Bob Lesman", Balance=80345.66, Bank="FTB"},
                new Customer(){ Name="Joe Landy", Balance=9284756.21, Bank="WF"},
                new Customer(){ Name="Meg Ford", Balance=487233.01, Bank="BOA"},
                new Customer(){ Name="Peg Vale", Balance=7001449.92, Bank="BOA"},
                new Customer(){ Name="Mike Johnson", Balance=790872.12, Bank="WF"},
                new Customer(){ Name="Les Paul", Balance=8374892.54, Bank="WF"},
                new Customer(){ Name="Sid Crosby", Balance=957436.39, Bank="FTB"},
                new Customer(){ Name="Sarah Ng", Balance=56562389.85, Bank="FTB"},
                new Customer(){ Name="Tina Fey", Balance=1000000.00, Bank="CITI"},
                new Customer(){ Name="Sid Brown", Balance=49582.68, Bank="CITI"}
            };
            List<ReportItem> millionaireReport = ...

            foreach (var item in millionaireReport)
            {
                Console.WriteLine($"{item.CustomerName} at {item.BankName}");
            }
        }
    }
}
```
#### ReportItem.cs
```cs
using System;

        /*
            You will need to use the `Where()`
            and `Select()` methods to generate
            instances of the following class.
            
        */
        
namespace Challenge 
{
    public class ReportItem
    {
        public string CustomerName { get; set; }
        public string BankName { get; set; }
    }   
}
```
### Visualization of LINQ methods

![linq methods chart](./assets/linq.jpg)
