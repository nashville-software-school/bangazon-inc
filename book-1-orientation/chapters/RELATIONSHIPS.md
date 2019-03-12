# Object Inheritance and Object Associations

## References



## Inheritance

Inheritance is for defining straightforward `is-a` relationships. When you have many types in your system, and you discover that several of them share the same properties and/or behaviors, you may want to consider designing an inheritance system.

Consider that you are building software to keep track of sporting equipment. You find yourself defining classes for baseballs, soccer balls, footballs, golf balls, softballs, etc.

After defining each class, you discover that you have defined the same properties on each one. For example:

1. Weight
1. Radius
1. Material

These are properties that **all of them** have in common. You can design your system so that each specific type inherits those properties from a parent class.

```cs
/*
    This parent class will contain properties that
    are common across all of the specific kinds of
    balls in our program.
*/
class Ball
{
    public double radius { get; set; }
    public double weight { get; set; }
}

/*
    By putting `: Ball` after the definition of
    Baseball, any object created from this class
    would automatically have the two properties of
    radius and weight.
*/
class Baseball : Ball
{
    // Stitches is not common to every kind of ball
    public int stitches { get; set; }
}

// All soccer balls will also have radius and weight
class SoccerBall : Ball
{
    // Panels is not common to every kind of ball
    public int panels { get; set; }
}
```

## Association

Inheritance is a mechanism in which a single object obtains properties and methods from 1, or more, parent class. In software, we also deal with situations in which two distinct, separate objects have a relationship with each other. Associations are a `has-a` relationship instead of an `is-a` relationship. There are two flavors of this kind of object relationship.

### Composition

Composition is for things that make up other things. If the container object is destroyed, so will all of its composing parts. The composition pattern describes objects that are made up of other objects, and are tightly coupled, instead of existing independently of each other.

Consider the human body. It is composed of many individual parts that can be defined separately, but canot exist separately from each other.

```cs
class Pancreas
{
    public bool filtering { get; set; }
}

class Liver
{
    public bool poisoned { get; set; }
}

class Body
{
    /*
        Making these private. Don't want anyone
        messing around with my liver and pancreas
    */
    private Pancreas _pancreas;
    private Liver _liver;

    public Body ()
    {
        // Create a brand new pancreas and assign it to this body
        _pancreas = new Pancreas(){
            filtering = true
        };

        // Create a brand new liver and assign it to this body
        _liver = new Liver(){
            poisoned = false
        };
    }
}
```

### Aggregation

Aggregation is for adding objects that are needed for the operation of another object, but both of the objects in the relationship can exist without the other. Consider the relationship between a bank and its customers.

When a bank closes, it doesn't kill the customers. They continue to live happy lives using another bank. Likewise, if a customer dies, the bank doesn't go out of business. It just finds different customers.

A customer `has-a` bank. A bank `has-a` customer. Well, hopefully many customers.

This scenario is aggregation.

```cs
using System;
using System.Collections.Generic;

class Customer
{
    public string AccountNumber { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
}

class Bank
{
    public string Name { get; set; }
    public string Address { get; set; }

    // Customers are aggregated into the bank
    public List<Customer> Customers { get; set; } = new List<Customer>();

}

class Program {
    public static void Main () {
        // Create a bank
        Bank FirstTennessee = new Bank() {
            Name = "First Tennessee",
            Address = "100 Infinity Way"
        };

        // Create a customer
        Customer steve = new Customer();
        steve.FirstName = "Steve";
        steve.LastName = "Brownlee";
        steve.AccountNumber = "110405821101";

        // Add Steve to First Tennessee's list of customers
        FirstTennessee.Customers.Add(steve);

        // Add another customer using in-line, concise syntax
        FirstTennessee.Customers.Add(
            new Customer() {
            FirstName = "Caitlin",
            LastName = "Stein",
            AccountNumber = "0592382394589" }
        );

        // Iterate over the list of customers and display the first name
        foreach (Customer cust in FirstTennessee.Customers)
        {
            Console.WriteLine(cust.firstName);
        }
    }
}

```
