# Bangazon Orientation

## Method Overloading

---

Method overloading allows a single method to be called in different ways, and exhibit different behavior. Each method definition will have a different signature, or arity.

```cs
/*
    Since the variable type in each of these eat() methods is different,
    we have overloaded the method. The behavior of the tree is the same,
    eating, but the input can now be three different types.

    Tree frontYardOak = new Tree();

    Rainfall rain = new Rainfall(2.25);
    Energy sunshine = new Energy(5);
    Mineral phosphorous = new Mineral(0.233);

    frontYardOak.eat(rain);
    frontYardOak.eat(sunshine);
    frontYardOak.eat(phosphorous);
*/
public class Tree
{
    public void eat(Energy sunshine)
    {
        // Modify growth of tree based on hours of sunshine
    }

    public void eat(Rainfall rain)
    {
        // Modify growth of tree based on amount of rainfall
    }

    public void eat(Mineral mineral)
    {
        // Modify growth of tree based on type of mineral in soil
    }
}
```

## Instructions

1. Create a new class to represent an Employee.
1. It's constructor should accept two parameters.
    1. First name of employee
    1. Last name of employee
1. Define a method named `eat()` that will allow it to be invoked with the following four signatures.
    1. `eat()` - Will select a random restaurant name from a list of strings, print to console that the employee is at that restaurant, and also return the restaurant.
    1. `eat(string food)` - Will output that the employee ate that specific food at the office.
    1. `eat(List<Employee> companions)` - Will select a random restaurant name from a list of strings, print to console that the employee is at that restaurant, and also output the first name of each employee in the specified list.
    1. `eat(string food, List<Employee> companions)` - Will select a random restaurant name from a list of strings, print to console that the employee at that restaurant, and ordered the specified food, with the first name of the teammates specified in the list.
