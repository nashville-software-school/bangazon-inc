# Inheritance, Composition, and Aggregation

## Inheritance

Inheritance is for straightforward is-a relationship.

A baseball is a ball.

A skyscaper is a building.

```cs
class Ball
{
    public double radius { get; set; }
    public double weight { get; set; }
}

class Baseball : Ball
{
    public int stitches { get; set; }
}

class SoccerBall : Ball
{
    public int panels { get; set; }
}
```

## Composition

Composition is for things that make up other things. If the container object is destroyed, so will all of its composing parts. Composition is the pattern for part-of relationships.

A pancreas is part of a body.

A room is part of a building.

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
    public double height { get; set; }
    public double weight { get; set; }

    public Body ()
    {
        Pancreas pancreas = new Pancreas();
        Liver liver = new Liver();
    }
}
```

## Aggregation

Aggregation is for adding objects that are needed for the operation of another object, but should exist independently of it should it be destroyed. Aggregation is the pattern for has-a relationships.

```cs
using System;
using System.Collections.Generic;

class Customer
{
    public string accountNumber { get; set; }
    public string firstName { get; set; }
    public string lastName { get; set; }
}

class Bank
{
    public string name { get; set; }
    public string address { get; set; }
 
    // Customers are aggregated into the bank
    public List<Customer> customers { get; set; }

    public Bank ()
    {
        /*
        Other objects that are part of a bank are 
        composed during construction.
         */
        Building coolSprings = new Building();
        ATM driveThru = new ATM();
    }
}

// Create a bank
Bank FirstTennessee = new Bank();

// Create a customer
Customer steve = new Customer();
steve.firstName = "Steve";
steve.lastName = "Brownlee";
steve.accountNumber = "000000000";

// Add customer to a List of customers
List<Customer> FTCustomers = new List<Customer>();
FTCustomers.Add(steve);

// Add another customer using in-line, concise syntax
FTCustomers.Add(
    new Customer() { 
    firstName = "Caitlin",
    lastName = "Stein",
    accountNumber = "000000000" }
);

// Set the customers property of the bank to the created list
FirstTennessee.customers = FTCustomers;

// Iterate over the list of customers and display the first name
foreach (Customer cust in FTCustomers)
{
    Console.WriteLine(cust.firstName);
}
```

In this last example, the Customer you created would not cease to exist should the Bank in which it had an account went bankrupt and closed.




