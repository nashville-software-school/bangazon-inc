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

## Titan of Industry

You work for H.E. Pennypacker, an industry titan that has ammassed a business empire consisting of 5 different factories that produce the following goods. H.E. has diversified the empire to make the company as recession proof as possible.

1. Steel
1. Automobiles
1. Chicken nuggets
1. Insulin
1. Taffy

In each of these factories, potential employees must have a very specialized skillset before they are hired. Here are the coresponding skillsets, represented as types.

1. `SteelWorker`
1. `AutoWorker`
1. `FoodProcessor`
1. `LabTechnician`
1. `Confectioner`

Now, since you are in charge of building a command line application to help the Global HR department manage the hiring of employees for all factories, you want to ensure that each factory has the same properties and the same behaviors _(i.e. methods)_. This means you need an interface.

* Each factory should have a minimum employee count.
* Each factory should have a maximum employee count.
* Each factory should have a method for hiring an employee. Name it `HireEmployee()` per above code.
* Each factory should have a method for hiring multiple employees. Name it `HireEmployees()`.

Since the `HireEmployee()` of each factory must limit the type of employee being hired, it requires that the interface be defined as more dynamic.

1. Steel - `HireEmployee(SteelWorker employee)`
1. Automobiles - `HireEmployee(AutoWorker employee)`
1. Chicken nuggets - `HireEmployee(FoodProcessor employee)`
1. Insulin - `HireEmployee(LabTechnician employee)`
1. Taffy - `HireEmployee(Confectioner employee)`

Since interfaces must also define the arity of a method (if it has one), we run into a roadbloack. If you tightly bind the argument type to a single custom type, then the other factories cannot hire the right employees.

```cs
public interface IFactory
{
    void HireEmployee (SteelWorker employee);
}
```

The Taffy factory can't implement this interface. It needs to hire **`Confectioner`** type people.

```cs
public class TaffyFactory : IFactory
{
    public List<Confectioner> employees { get; set; } = new List<Confectioner>();

    /*
        Compiler error. Can't convert type Confectioner to type SteelWorker.
    */
    public void HireEmployee (Confectioner employee)
    {
        employees.Add(employee);
    }
}
```

Therefore, the interface must generically define the type of employee being hired. This is where Generics come into play. Look at this new syntax.

```cs
public interface IFactory<T>
{
    void HireEmployee (T employee);
}
```

By using generics, the variable of `T` gets replaced by whatever the implemeting class passes in as the type argument. Look at the first line of code below. You will notice that `<Confectioner>` has been added as a type argument to send to the interface. That type will get stored in the variable `T`, which then means that the `employee` argument for `HireEmployee` will be typed appropriately.

```cs
public class TaffyFactory : IFactory<Confectioner>
{
    public List<Confectioner> employees { get; set; } = new List<Confectioner>();

    /*
        No compiler error.
    */
    public void HireEmployee (Confectioner employee)
    {
        employees.add(employee);
    }
}
```

## Practice: Refueling Stations for Gary's Wholesale Garage

1. Create a **`GasStation`** type for gas-powered vehicles.
1. Create a **`BatteryStation`** type for electric-powered vehicles.
1. Create an inteface that both types of stations must implement that ensures that they both have the following properties and methods.
    * `int Capacity`: The number of vehicles that they can refuel at any one time.
    * `void Refuel(List<T> vehicles)`: A method to print a message to the terminal that the vehicle has been refueled. _(e.g. "The white Cessna has been refueled with 200 gallons of gas")_ Each refueling station's `Refuel()` method should accept a list of vehicles that only it can process. **`GasStation.Refuel()`** should only accept a list of gas-powered vehicles. **`BatteryStation.Refuel()`** should only accept a list of electric-powered vehicles.
1. In your main method, make sure you have a list of electric vehicles, and a list of gas vehicles.
1. Create an instance of **`BatteryStation`** and **`GasStation`**.
1. Refuel all the vehicles by sending them to the correct refueling station.
