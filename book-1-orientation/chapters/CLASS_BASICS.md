# User Defined Types

In a programming language a **type** is a blueprint, or a template, for creating an object instance in memory. A type defines the capabilities of an object. C# and the .NET Framework provide many types, such as `int`, `decimal`, `bool`, `Datetime`, `string`, `Dictionary`, `List`, etc... There are literally thousands of them!

While these types provide a lot of functionality, each C# application must also provide its own, custom types to do the specific work it needs to do.

In C# the most common way to create a new type is with a `class`.

> **Further reading:** [Types in C#](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/types)

```cs
public class Writer
{
    public Writer(string prefix)
    {
        Prefix = prefix;
    }

    public string Prefix {get; set;}

    public void Write (string message)
    {
        Console.WriteLine(Prefix + message);
    }
}
```

```cs
// The output variable's type is `string` -- a built in type
string output = "Nashville Software School";

// The author variable's type is Writer -- a custom type you defined
Writer author = new Writer("I do declare: ");
author.Write(output);

author.Prefix = "That's right, I said: ";
author.Write(output);
```

The above code would print the following:

```txt
I do declare: Nashville Software School
That's right, I said: Nashville Software School
```

## Classes vs Objects

The difference between a class and an object is not always easy to see at first. Let's try to clear things up with an analogy.

Let's imagine that you drive a [1994 Ford Taurus](https://www.google.com/search?tbm=isch&q=1994%20ford%20taurus&tbs=imgo:1). Of course, you love it. And, you know you're not alone. Plenty of other people _(dozens)_ also drive 1994 Ford Tauruses. But do they drive **your** 1994 Ford Taurus? No, of course not, You wouldn't let anyone drive your precious baby.

In C# a class is like the _make and model_, 1994 Ford Taurus. An object, on the other hand, is like **your** 1994 Ford Taurus. The object is the real, specific car. The class is the _**type**_ of the car. We say that **your** car is an _"instance of"_ a 1994 Ford Taurus. If your buddy down the street also has a 1994 Ford Taurus, that would be considered another _instance of_ a 1994 Ford Taurus.

In the C# example above. the class is `Writer` and we create a new `Writer` object to assign to the `author` variable.

```cs
Writer author = new Writer("I do declare: ");
```

## Parts of a Class

### Properties

Class properties are the interface you provide to external code to get, and modify, the data stored inside the object.

```cs
public class Customer
{
    public string FirstName { get; set; }

    public string LastName { get; set; }

    public bool IsLocal { get; set; }

    // Calculated property that has no setter. It is readonly.
    public string FullName {
        get
        {
            return $"{FirstName} {LastName}";
        }
    }
}
```

> **Resource:** [Properties (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties)

### Methods

Methods are the new name for functions. They are code blocks on a class that performs a series of logic. Think of them as the behaviors of your custom type. Copy pasta this example code into your `Program.cs` file.

```cs
using System;
using System.Collections.Generic;

namespace Classes
{
    public class Customer
    {
        // Public Properties
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public bool IsLocal { get; set; }

        public string FullName
        {
            get
            {
                return $"{FirstName} {LastName}";
            }
        }
    }

    public class DeliveryService
    {
        /*
          Properties
        */
        public string Name { get; set; }

        public string TransitType { get; set; }

        /*
          Methods
        */
        public void Deliver(Product product, Customer customer)
        {
            Console.WriteLine($"Product delivered by {TransitType} to {customer.FullName}");
        }
    }

    public class Product
    {
        /*
          Properties
        */
        public string Title { get; set; }

        public string Description { get; set; }

        public double Price { get; set; }

        public int Quantity { get; set; }

        /*
          Methods
        */
        public void Ship(Customer customer, DeliveryService service)
        {
            if (!customer.IsLocal)
            {
                service.Deliver(this, customer);
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Product tinkerToys = new Product()
            {
                Title = "Tinker Toys",
                Description = "You can build anything you want",
                Price = 32.49,
                Quantity = 25
            };

            Customer marcus = new Customer()
            {
                FirstName = "Marcus",
                LastName = "Fulbright",
                IsLocal = false
            };

            DeliveryService UPS = new DeliveryService()
            {
                Name = "UPS",
                TransitType = "train"
            };

            // Ship the tinker toys to Marcus using UPS
            tinkerToys.Ship(marcus, UPS);
        }
    }
}
```

### Fields

Much like **properties**, **Fields** are use to store values in an object. Unlike properties fields are usually marked as **`private`** meaning they cannot be accessed outside the object. The concept of storing private data that is only accessible inside the object is referred to as **encapsulation**.

```cs
public class Box {
    private string _secret = "Sometimes I sing Aretha Franklin songs in the shower.";

    public string GetSecret(string magicWord) {
        if (magicWord == "please") {
            return _secret;
        } else {
            return "I'm not telling you!";
        }
    }
}
```

```cs
Box box = new Box();
// The following line would cause an error. _secret is not accessible.
// Console.WriteLine(box._secret);

// But public methods and properties can access a private fields.
Console.WriteLine(box.GetSecret("please"));
```

### Constructors

A constructor is special method in a class that is called when a new instance of the class is created. The role of a constructor is to make sure the new object is setup and ready for use immediately after it is created.

```cs
public class Store {
    public Store(string name, List<string> initialInventory) {
        Name = name;
        Inventory = initialInventory;
    }

    public string Name {get; set;}
    public List<string> Inventory {get; set;}
}
```

We call a constructor when we use the `new` keyword.

```cs
List<string> inventory = new List<string>();
inventory.Add("batteries");
inventory.Add("golf tees");
inventory.Add("zippers");
inventory.Add("cabin accessories"};

// Make a new instance of a Store
Store myStore = new Store("Stuff 'n' Things", inventory);
```

A constructor is not required in a class. If a class does not have a constructor it will be given a hidden, "default" constructor that accepts no parameters and does nothing.

## Resources

- [C# Classes Tutorial](https://youtu.be/ZqDtPFrUonQ?t=139)
- [How to program in C# - CLASSES - Beginner Tutorial](https://youtu.be/s2hHjpZaSyI?t=117)
- [Properties (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties)

---

## Practice: List employees working at a company

### Setup

```
mkdir -p ~/workspace/csharp/exercises/Classes && cd $_
dotnet new console
```

Using C# classes, you need to create custom types to represent an **`Employee`** and a **`Company`**. Then you will create some employees, hire them into the company and then display a simple report showing the employee names and their titles.

![employee list](./assets/AXf6v0ajv6.gif)

### Instructions

Copy the following starter code into your `Program.cs` file to get started.

> Program.cs

```cs
using System;

namespace Classes
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create an instance of a company. Name it whatever you like.

            // Create three employees

            // Assign the employees to the company

            /*
                Iterate the company's employee list and generate the
                simple report shown above
            */
        }
    }
}
```

---

Create a `Company.cs` file and copy the following code into the file to continue.

> Company.cs

```cs
using System;

namespace Classes
{
    public class Company
    {

        // Some readonly properties (let's talk about gets, baby)
        public string Name { get; }
        public DateTime CreatedOn { get; }

        // Create a public property for holding a list of current employees

        /*
            Create a constructor method that accepts two arguments:
                1. The name of the company
                2. The date it was created

            The constructor will set the value of the public properties

        */
    }
}
```

1. Expand on the `Company` class code by
    1. Adding an **Employees** property (Its type should be **`List<Employee>`**)
    1. Setting the value of **Employees** in the constructor as a `new List<Employee>` (News Flash: Declaring a property gives it an initial vlaue of `null`). This will allow you to add newly created employees to the Employees list in the final step below.
1. Create an `Employee.cs` file and then define a class for `Employee`. An employee has the following properties.
    1. First name (_string_)
    1. Last name (_string_)
    1. Title (_string_)
    1. Start date (_DateTime_)
1. The `Company` class should also have a `ListEmployees()` method which outputs a string about each employee, such as _"Jane Doe works for Acme, Inc. as Lion Tamer since 3/23/15."_
1. In the `Main` method of your console application, create a new instance of Company, and three instances of Employee. Then assign the employees to the company.


## Practice: An Adventurer's Quest

Follow [this link](./QUEST.md) to begin your quest.

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

[ø](https://github.com/nashville-software-school/bangazon-inc/wiki/ClassStrategy)
