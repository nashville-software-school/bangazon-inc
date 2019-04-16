# Introduction to Generic Typing

Now that you have learned that basics of being able to designate various types for an object using inheritance and interfaces, you should have some basic comfort with the concept of type, and that C# is a strongly-typed language. Now it is time to learn about another level of flexibility that the language provides - variables for types.

## Why Are You Learning This?

Since interfaces specify the rules for classes to follow, you very often specify methods in the interface to ensure that all implementing classes have the same behavior. Methods often define arguments. Arguments have types.

However, since the implementing classes can often take define different types for their arguments, learning generic typing will make your interfaces more powerful and flexible.

## Generics

In C#, it's called Generics, and you use the mechanism in a situation where you can't specify what the exact type for a variable will be, but rather have a placeholder for the type, and the developer will provide its value. It's much like a method argument variable. You specify a variable, not knowing what it's value will be. When a developer invokes the method, the value is passed in.

Generics are much the same, but for the type!

The truly weird thing that you will need to get used to is the syntax for it. The type is passed into an object via the class, or interface, name itself rather than the typical parenthesis after a method name.

##### Method Argument

```cs
public class CarFactory
{
    public List<Autoworker> employees { get; set; } = new List<Autoworker>();

    /*
        Standard argument defined for a method, with a
        pre-defined, concrete type and a variable name.
    */
    public void HireEmployee (Autoworker employee)
    {
        employees.add(employee);
    }
}
```

##### Generic Type Argument

```cs
// The `T` here is the variable name. It's value will be a type.
public interface IFactory<T>
{
    /*
        The type is used in the method signature to specify
        that the `employee` variable will be of *some* type,
        but I don't know ahead of time what that will be.
    */
    void HireEmployee (T employee);
}
```

## Practice: Refueling Stations for Gary's Wholesale Garage

1. Create a **`GasStation`** type for gas-powered vehicles.
1. Create a **`BatteryStation`** type for eletric-powered vehicles.
1. Create an inteface that both types of stations must implement that ensures that they both have the following properties and methods.
    * `int Capacity`: The number of vehicles that they can refuel at any one time.
    * `void Refuel(List<T> vehicles)`: A method to print a message to the terminal that the vehicle has been refueled. _(e.g. "The white Cessna has been refueled with 200 gallons of gas")_ Each refueling station's `Refuel()` method should accept a list of vehicles that only it can process. **`GasStation.Refuel()`** should only accept a list of gas-powered vehicles. **`BatteryStation.Refuel()`** should only accept a list of electric-powered vehicles.
1. In your main method, make sure you have a list of electric vehicles, and a list of gas vehicles.
1. Create an instance of **`BatteryStation`** and **`GasStation`**.
1. Refuel all the vehicles by sending them to the correct refueling station.
