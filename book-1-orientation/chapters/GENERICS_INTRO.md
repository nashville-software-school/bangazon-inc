# Introduction to Generic Typing

Now that you have learned that basics of being able to designate various types for an object using inheritance and interfaces, you should have some basic comfort with the concept of type, and that C# is a strongly-typed language. Now it is time to learn about another level of flexibility that the language provides - variables for types.

## Why Are You Learning This?

Since interfaces specify the rules for classes to follow, you very often specify methods in the interface to ensure that all implementing classes have the same behavior. Methods often define arguments. Arguments have types.

However, since the implementing classes can often take different types for their arguments, learning generic typing will make your interfaces more powerful and flexible.

## Generics

In C#, it's called Generics, and you use the mechanism in a situation where you can't specify what the exact type for a variable will be, but rather have a placeholder for the type, and the developer will provide its value. It's much like a method argument variable. You specify a variable, not knowing what it's value will be. When a developer invokes the method, the value is passed in.

Generics are much the same, but for the type!

The truly weird thing that you will need to get used to is the syntax for it. The type is passed into an object via the class, or interface, name itself rather than the typical parenthesis after a method name.

## Back to Gary's Garage

Gary's Garage is expanding. He now needs one garage for his electric vehicles, so he can recharge them appropriately, and another one for gas-powered vehicles. Finally, Gary needs a third showroom garage that can hold electric _and_ gas powered vehicles.

All three of his garages must have the following things:

1. A list of cars
2. A method to add cars to the garage
3. A method to list all of the cars in that garage to the console

The class for our electric garage might look something like this:

```cs
public class ElectricGarage
    {
        public List<IElectric> cars { get; set; }

        public void AddCarToGarage(IElectric car)
        {
            cars.Add(car);
        }

        public void listCars()
        {
            cars.ForEach(singleCar=> Console.WriteLine(singleCar));
        }
    }
```

Since all of our garage classes need to have similar properties and methods, we might start thinking about using inheritance or interfaces to structure our code. But we'll run into a problem very quickly where an instance of an `ElectricGarage` needs to manage electric vehicles, but an instance of our gas powered garage class will need to manage gas powered vehicles.

For example, in our `GasPoweredGarage.cs` class, we might end up with a list that looks like this:

```cs
public List<IGasPowered> cars { get; set; }
```

And in our show room garage, that can contain all types of vehicles, our list might look like this:

```cs
public List<IVehicle> cars { get; set; }
```

They all have a list called cars, but the lists contain different types of cars. We're totally screwed! We might as well microwave our computer and call it a day.

**Da daaa! Generics to save the day!**

> > Generic Interface for garages

```cs
  public interface IGarage<T> // The <T> stands for type. This means that we don't know or care what _type_ of car the garage is going to deal with-- we can decide that when we implement the interface
    {

        // This could be a list of IVehicles, or IElectric, or IGasPowered. The <T> is like a placeholder.
        public List<T> cars {get; set;}

        public void AddCarToGarage(T car);

        public void listCars();
    }
```

Here's what it looks like when we implment our interface to build our `GasPoweredGarage` class.

```cs
    public class GasPoweredGarage : IGarage<IGasPowered>
    {
        public List<IGasPowered> cars { get; set; }

        public void AddCarToGarage(IGasPowered car)
        {
            cars.Add(car);
        }

        public void listCars()
        {
            cars.ForEach(singleCar => Console.WriteLine(singleCar));
        }
    }

```

## Practice: Titan of Industry

> Note: Please read all of the instructions before starting.

You work for H.E. Pennypacker, an industry titan that has ammassed a business empire consisting of 5 different factories that produce the following goods. H.E. has diversified the empire to make the company as recession proof as possible.

1. Steel
1. Automobiles
1. Chicken nuggets


In each of these factories, potential employees must have a very specialized skillset before they are hired. Here are the coresponding skillsets, represented as classes.

1. `SteelWorker`
1. `AutoWorker`
1. `FoodProcessor`

### Step One: Workers
Create custom types for each type of worker. Each worker has the following properties:
1. A full name
1. A date hired
1. A pay rate

Steel workers should additionally have a method called `MakeSteel()`. Auto workers should have a method called `MakeCar()`. Food processors should have a method called `MakeChicken()`. The methods don't have to do anything right now-- a `Console.WriteLine()` is fine.

> Do you notice that all of your workers have some properties in common? This would be a good time to use inheritance. If you want extra practice, create a `Worker` base class and have each individual worker inherit from `Worker`.


### Step Two: Factories
Now, since you are in charge of building a command line application to help the Global HR department manage the hiring of employees for all factories, you want to ensure that each factory has the same properties and the same behaviors _(i.e. methods)_. This means you need an interface.

- Each factory should have a minimum employee count.
- Each factory should have a maximum employee count.
- Each factory should have a method for hiring an employee. Name it `HireEmployee()` per above code.
- Each factory should have a method for hiring multiple employees. Name it `HireEmployees()`.

Since the `HireEmployee()` of each factory must limit the type of employee being hired, it requires that the interface be defined as more dynamic.

1. Steel - `HireEmployee(SteelWorker employee)`
1. Automobiles - `HireEmployee(AutoWorker employee)`
1. Chicken nuggets - `HireEmployee(FoodProcessor employee)`

Since interfaces must also define the arity of a method (if it has one), we run into a roadbloack. If you tightly bind the argument type to a single custom type, then the other factories cannot hire the right employees.

```cs
public interface IFactory
{
    void HireEmployee (SteelWorker employee);
}
```

The Chicken Nugget factory can't implement this interface. It needs to hire **`FoodProcessor`** type people. _You're going to need a Generic._

- Create a Generic Interface to reprsent a factory
- Create three custom types to represent each type of factory, and make sure you implement your interface

### Step Three: Hiring Some People
1. In `Program.cs`, create at least one instance of each type of employee and each type of factory.
1. Call the `HireEmployee()` method for each factory and make sure that they can hire the correct type of employee.

### Challenge: Command Line Interface
> Please do not attempt this challenge unless you have completed all of the exercises so far, and are feeling confident and not burnt out.
Build a CLI for H.E. Pennypacker Industries. When the user runs the CLI, they should be presented with a menu that lists the following options:

```
Welcome to H.E. Pennypacker Industries!
1. View employees at a factory
2. Hire a new employee
```
If the user selects option 1, they should be presented with a list of factories. When they select a factory from the list, they should see all of the workers at that factory printed to the console.

If the user selects option 2, they should see a list of possible factories where they could hire an employee. Once they select a factory, they should be prompted for first name, last name, and pay rate. The hire date of the employee should be added automatically. Once they enter the new worker's information, that worker should be added to the appropriate factory, and they should be shown a confirmation message.

