# User Defined Types

In a programming language a **type** is a blueprint, or a template, for creating an object instance in memory. A type defines the capabilities of an object. C# and the .NET Framework provide many types, such as `int`, `decimal`, `bool`, `Datetime`, `string`, `Dictionary`, `List`, etc... There are literally thousands of them!

While these types provide a lot of functionality, each C# application must also provide its own, custom types to do the specific work it needs to do.

In C# the most common way to create a new type is with a `class`.

> **Further reading:** [Types in C#](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/types)

```cs
public class Writer
{
    public Writer(string prefix) {
        Prefix = prefix;
    }

    public string Prefix {get; set;}

    public void Write (string message)
    {
        Console.WriteLine(Prefix + message);
    }
}

// The output variable's type is `string` -- a built in type
string output = "Nashville Software School";

// The author variable's type is Writer -- a custom type you defined
Writer author = new Writer("I do declare: ");
author.Write(output);

author.Prefix = "That's right, I said: ";
author.Write(output);
```
The above code would print the following:

    I do declare: Nashville Software School
    That's right, I said: Nashville Software School

## Accessibility Levels

In C#, there are five accessibility levels that can be applied to Classes, Methods, Properties and Data Members:

- public
- private
- protected
- internal
- protected internal

## Public

Classes and Methods that have tagged with the `public` keyword are accessibile without restriction. `public` methods are usable from derived classes (i.e. children) and from outside the inheritance heirarchy (i.e. family).

In some `Automobile.cs`:

```cs
// Base class
public class Automobile {

    public string Accelerate() {
        return "zoom!";
    }

}

// Derived class
public class Car : Automobile { }
```

> `Program.cs`:

```cs
Automobile generic_auto = new Automobile();
Console.WriteLine($"Automobiles go {generic_auto.Accelerate()}");

Car stella = new Car();
Console.WriteLine($"Cars go {stella.Accelerate()}");
```

## Private

Classes and Methods that have tagged with the `private` keyword are only accessible from within the class where it's defined. This means that private methods can not be called from anywhere outside the class, including derived classes (children).

Private methods are intended to be internal functionality. Consider the classes below:

```cs
// Base class
public class Automobile {

    public string Accelerate() {
        InjectFuel();
        return "zoom";
    }

    private string InjectFuel() {
        return "fueling";
    }
}

// Usage Example in a Program.cs file somewhere

Automobile generic_auto = new Automobile();
Console.WriteLine($"Automobiles go {generic_auto.Accelerate()}");

// However, the following line of code does not compile
generic_auto.InjectFuel();
```

```cs
// Given a Derived class, the follow code does not compile
public class Car : Automobile {

    public string CallAPrivateParentMethod {
        this.InjectFuel(); // Can not call InjectFuel b/c it's listed as private its parent class, Automobile
    }
}

// Usage Example in a Program.cs file somewhere
Car stella = new Car();

// Again, the following line of code does not compile
stella.InjectFuel();
```

## Protected

Classes and Methods that have tagged with the `protected` keyword prevent access from outside the class heirarchy (ie. the family); however, `protected` methods are usable from derived classes (i.e. children).

```cs
// Base class
public class Automobile {

    public string Break() {
        SqueezeBreakPads();
        return "skuuuuuur";
    }

    protected string SqueezeBreakPads() {
        return "";
    }
}

// Derived class
public class Car : Automobile {

    public string UseEmergencyBreak() {
        SqueezeBreakPads();
        return "skreeech!";
    }
}

// Usage Example in a Program.cs file somewhere
Car stella = new Car();

// UseEmergencyBreak method can use the protected SqueezeBreakPads from the Automobile class.
Console.WriteLine($"Applying the break: {stella.UseEmergencyBreak()}");
```

## Internal

Classes and Methods that have tagged with the `internal` keyword allow access from anywhere within the same compiled DLL (assembly).

## Protected Internal

`protected internal` is the only allowed combination of multiple access modifiers.

## Resources

> [Accessibility Levels (C# Reference)](https://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx)
> [Access Modifiers (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers)

# Parts of a Class

## Properties

Class properties are the interface you provide to external code to get, and modify, the values of the private fields.

```cs
public class Customer
{
    /*
        Properties should have public accessibility
    */
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

## Methods

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
            Console.WriteLine($"Product delivered by {this.TransitType} to {customer.FullName}");
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

## Fields

Much like **properties**, **Fields** are use to store values in an object. Unlike properties fields are usually private and cannot be accessed outside the object. The concept of storing private data that is only accessible inside the object is referred to as **encapsulation**.

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

## Constructors

A constructor is special method in a class that is called when a new instance of the class is created. The role of a constructor is to make sure the new object is setup and ready for use immediately after it is created.

```cs
public class Store {
    public Store(string name, List<string> initialInventory) {
        Name = name;
        Inventory = initialInventory;
    }

    public sting Name {get; set;}
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

* [C# Classes Tutorial](https://youtu.be/ZqDtPFrUonQ?t=139)
* [How to program in C# - CLASSES - Beginner Tutorial](https://youtu.be/s2hHjpZaSyI?t=117)
* [Properties (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties)

---

## Practice: Urban Planner

### Setup

```sh
mkdir -p ~/workspace/csharp/exercises/planner && cd $_
dotnet new console -n Planner -o .
touch Building.cs
```

In this exercise, you are going to define your own **`Building`** type and create several instances of it to design your own virtual city. Create a class named **`Building`** in the `Building.cs` file and define the following fields, properties, and methods.

Also make sure that the class is defined in the same namespace as your program.

```cs
namespace Planner
{
    // Define class here
}
```

### Private Fields

* `_designer` of type `string`. It will hold your name.
* `_dateConstructed` of type `DateTime`. This will hold the exact time the building was created.
* `_address` of type string.
* `_owner` of type string. This will store the same of the person who owns the building.

### Public Properties

* `Stories` typed as an integer.
* `Width` typed as a double.
* `Depth` typed as a double.
* `Volume` should be read-only and should return _width * depth * (3 * # of stories)_. Each story is 3 meters high.

### Constructor

Define a constructor method that accepts a single string argument - `address` - so that you can send as a parameter when you create each instance with `new Building("800 8th Street");`.

* The constructor's logic should set the `_address` field's value to the argument value

### Public Methods

* Define a `Construct()` method. The method's logic should set the `_dateConstructed` field's value to `DateTime.Now`.
* Define a `Purchase()` method. The method should accept a single string argument of the name of the person purchasing a building. The method should take that string and assign it to the private `_owner` field.

Neither of these methods will return a value.

### Build Your City

1. Create several buildings in the `Main()` method of `Program.cs`.
    ```cs
    Building FiveOneTwoEigth = new Building("512 8th Avenue");
    ```
1. Give each building a width, height, and number of stories.
1. Construct each building.
1. Have business people in your city purchase each of your buildings.

After all of the buildings have been purchased, display the following information to the console for each building.

```sh
100 Main Street
---------------
Designed by Steve Brownlee
Constructed on 2/1/18 7:19:08 AM
Owned by Bob Ross
16128 cubic meters of space
```

## Practice: Urban Planner II

Now you need to create a type to represent your city. Here are the requirements for the class. You determine if/when to use fields, properties, a constructor, and methods.

1. Name of the city.
1. The mayor of the city.
1. Year the city was established.
1. A collection of all of the buildings in the city.
1. A method to add a building to the city.

Remember, each class should be in its own file. Create a `City.cs` file and define the **`City`** class in there. Make sure it's in the same namespace as your other classes.

Once the class is defined to your liking, refactor your code in `Main()` to create a new city instance and add your buildings to it. Once all buildings are in the city, refactor your code that outputs the building info to the console to be inside a `foreach` loop that iterate the city's building collection.

##### Example

```cs
City megalopolis = new City();

...

foreach (Building building in megalopolis.Buildings) {
    Console.WriteLine(...);
}
```

## Practice: List employees working at a company

### Setup

```
mkdir -p ~/workspace/csharp/exercises/classes && cd $_
dotnet new console
```

Using C# classes, you need to create custom types to represent an **`Employee`** and a **`Company`**. Then you will create some employees, hire them into the company and then display a simple report showing the employee names and their titles.

![employee list](./assets/AXf6v0ajv6.gif)

### Instructions

1. Create a custom type for `Employee`. An employee has the following properties.
    1. First name (_string_)
    1. Last name (_string_)
    1. Title (_string_)
    1. Start date (_DateTime_)
1. Create a custom type for `Company`. A company has the following properties.
    1. Date founded (_DateTime_)
    1. Company name (_string_)
    1. Employees (_List\<Employee\>_)
1. The `Company` class should also have a `ListEmployees()` method which outputs the name of each employee to the console.
1. In the `Main` method of your console application, create a new instance of Company, and three instances of Employee. Then assign the employees to the company.

---

Copy this `Company` class into your `Program.cs` file to get started. You will define the `Employee` type.

```cs
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
```
