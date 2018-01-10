# Bangazon Orientation

## Interfaces

---

## Instructions

Your job is to think about interfaces that can be used by certain groups of your classes. For example, some employees may be part-time and others may be full-time.

The purpose of this exercise is to avoid a long, brittle inheritance tree where you create a `PartTimeEmployee`, and a `FullTimeEmployee` that both inherit from `Employee`, and then defining a `FullTimeHumanResourcesEmployee` type just to get the properties and methods of both types.

```
              -------------------
             |                   |
             |     Employee      |
             |                   |
              -------------------
                       |
                       |
                      \|/
          ---------------------------
         |                           |
         |     FullTimeEmployee      |
         |                           |
          ---------------------------
                       |
                       |
                      \|/
          ---------------------------
         |                           |
         |  HumanResourcesEmployee   |
         |                           |
          ---------------------------

```

```cs
// Describes full-time employees
public interface IFullTime
{
    double Salary;
}

// Describes part-time employees
public interface IPartTime
{
    double HourlyRate;
}
```

```cs
public class HumanResourcesEmployee: Employee, IFullTime
{
    // Private field
    private double _salary;

    // Public property with accessor/mutator
    public double Salary
    {
        get { return _salary; }
        set
        {
            // We pay HR people between $10/hr and $35/hr
            if (value >= 10 && value <= 35)
            {
                _salary = value;
            } else {
                // If the value is not in the required range, throw
                // and exception that the external code and catch
                throw new ArgumentOutOfRangeException("Cannot set salary to value specified");

            }
        }
    }
}
```

By breaking up your code this way, we've separated the inherent properties of an Employee from the properties that describe their employment status. This is a very fine-grained example of the [Single Responsibility Principle](../../concepts/solid/SINGLE_RESPONSIBILITY_PRINCIPLE.md) and the [Interface Segregation Principle](../../solid/INTERFACE_SEGREGATION_PRINCIPLE.md).


Assume that there is a `Shipping` class that derives from `Employee` and those people work part time. However, a year from now, the company decides to make shipping people full-time employees.

Then the development team simply need to change the `IPartTime` interface to `IFullTime` in the definition, implement the required property, and the change is complete.

## Example for You to Implement

1. Consider separating the location of a department from its inherent properties. Perhaps one location needs an access card, while others don't. One may require people to check in with security and others don't.
1. Consider the possibility that some Employees may have a physical handicap that changes their working conditions. Some handicaps are temporary, and others may be added after the Employees is hired. You don't want those reflected in the base Employee inheritance chain, but in a separate chain altogether.
1. Some employees are seasonal employees with a pre-determined length of employment, while others are not.
1. Some employees will work the day shift, and some, the night shift.
