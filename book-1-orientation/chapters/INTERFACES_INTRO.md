# Interfaces

An interface in C# is a construct that you define for classes to implement. Think of it as a contract for a class. If a class implements an interface, then it must define a method, property, or event for each one defined in the interface.

## Why Are You Learning This?

You will use interfaces to provide much more flexibility to your project to work with disparate types. It's one of the most powerful features of the C# language, and languages like it (e.g. Java).

You will also likely be asked about interfaces during the interview process. After working with interfaces during your time at Nashville Software School, you should be able to describe interfaces in the following ways.

1. Interfaces are a mechanism to introduce polymorphism into your system. They provide additional types to your classes.
1. They allow you to define common properties and behaviors among different classes in your system so that you can group them together into collections.
1. They are contracts that you and your team decide upon to ensure consistency and quality in the classes that you author.
1. Interfaces define what your class **should** do, but they can't specify **how** your class will do it.

## Zoological Zaniness

Imagine a scenario in which you are writing an application in which you need to classify any animal species as ground-based, air-based, or water-based. Also consider that animal species can be any combination of those classifications.

For example, a platypus both walks on the ground and swims in the water. Most birds are both air and ground. Cats are ground only. Dolphins are water only. Seagulls are air, ground, and water (they can dive to amazing depths and are great swimmers). So many possible combinations of behavior in the animal kingdom!

🐯 🦅 🐎 🦈 🙎🏾‍♀️ 🦉

This diversity of combinations adds quite a bit of complexity when it comes to building classes.

Sure we could do something like this...

```cs
public class Platypus
{
    public void Walk()
    {
        Console.WriteLine("Walk around");
    }

    public void Run()
    {
        Console.WriteLine("You can't catch me!");
    }

    public int MaximumDepth { get; } = 10;

    public void Swim()
    {
        Console.WriteLine("Swim, Swim");
    }
}
```

```cs
public class Pigeon
{
    public void Walk()
    {
        Console.WriteLine("Walk around");
    }

    public void Run()
    {
        Console.WriteLine("You can't catch me!");
    }

    public void Fly()
    {
        Console.WriteLine("I'm in the air!");
    }
}
```

```cs
public class Dolphin
{
    public int MaximumDepth { get; } = 1000;

    public void Swim()
    {
        Console.WriteLine("Swim, Swim");
    }
}
```

```cs
public class Cat
{
    public void Walk()
    {
        Console.WriteLine("Walk around");
    }

    public void Run()
    {
        Console.WriteLine("You can't catch me!");
    }
}
```

```cs
public class Seagull
{
    public void Walk()
    {
        Console.WriteLine("Walk around");
    }

    public void Run()
    {
        Console.WriteLine("You can't catch me!");
    }

    public void Fly()
    {
        Console.WriteLine("I'm in the air!");
    }

    public int MaximumDepth { get; } = 10;

    public void Swim()
    {
        Console.WriteLine("Swim, Swim");
    }
}
```

The above classes would work just fine...for a while. But what would happen if we wanted to group animals based on their type of movement? For example, what if we wanted to create a list of all the flying animals?

As you know C# won't let us create a list that contains objects of more than one type. So we cannot do something like this:

```cs
Pigeon p = new Pigeon();
Seagull s = new Seagull();

List<???> birds = new List<???>() { p, s };
```

The code above is clearly incorrect. What do we put for the `???` in `List<???>`?

This is where **_interfaces_** can help.

So far we've discussed how C# classes are a way of creating a **_type_**. Turns out classes aren't the only way. In C# an _interface_ is another way of creating a **_type_**.

To make our code base as flexible as possible, we define the properties and behaviors of each classification (or description) into an interface. You are going to start with interfaces for animals that can walk and those that can swim.

```cs
public interface IWalking
{
    void Run();
    void Walk();
}

public interface ISwimming
{
    int MaximumDepth { get; }
    void Swim();
}

public interface IFlying
{
    void Fly();
}
```

Notice that interfaces look a bit like classes with a few distinguishing elements.

1. Use the `interface` keyword instead of `class`
1. The name starts with the letter `I` to indicate that it is an interface.
1. Do not use the `public` keyword on methods and properties. Methods and properties on an interface are _always_ public.
1. Methods and properties _contain **no** definition. We only see the **_signature_** of the method or property. The 

Now you can define a class as an implementation of the interface for a walking animal. You can start with an African Painted Dog.

```cs
public class PaintedDog : IWalking
{
}
```

Since it is a contract, we must implement the methods that were defined in the interface.

> **NOTE:** The compiler will make sure that the you implement everything in the interface, or the code won't compile.

```cs
public class PaintedDog : IWalking
{
    public void Run()
    {
        Console.WriteLine("Animal is now running");
    }

    public void Walk()
    {
        Console.WriteLine("Animal is now walking");
    }
}
```

The `PaintedDog` class has now followed the rules of the interface, and implemented the two required methods that are required.

### Multiple Interfaces

A class can implement more than one interface. Let's use a Sea Turtle as an example, since they both swim in the ocean and walk on land.

```cs
class SeaTurtle : IWalking, ISwimming
{
    public int MaximumDepth { get; } = 100;

    public void Run()
    {
        Console.WriteLine("Animal is now running");
    }

    public void Walk()
    {
        Console.WriteLine("Animal is now walking");
    }

    public void Swim()
    {
        Console.WriteLine("Animal is now swimming");
    }
}
```
Because you specified two interfaces, you had to provide an implementation for the properties and methods from both of them.

And now, finally, we can revisit and answer the `List<???>` question.

```cs
Pigeon p = new Pigeon();
Seagull s = new Seagull();

List<IFlying> birds = new List<IFlying>() { p, s };
```

## Resources

- [Interface-based programming](https://en.wikipedia.org/wiki/Interface-based_programming)
- [Understanding Interface-based Programming](<https://msdn.microsoft.com/en-us/library/aa260635(v=vs.60).aspx>)

## Practice: More Gary's Wholesale Garage

> this exercise will build on the C# project you build in the previous chapter.

Here are some types of vehicles from **Gary's Wholesale Garage**.

1. Scooter
1. Car
1. Jetski
1. RV
1. Motorcycle
1. Boat
1. Truck
1. Light aircraft

Now, all of these types of things have some attributes and behaviors in common.

- They all have an engine
- They all carry one, or more, passenger
- They all move
- They all accelerate in any direction

There are other attributes and behaviors that **some** specific kinds of these vehicles share, but others don't.

- Some use gas
- Some are electric
- Some use a propeller to move
- Some have wheels
- Some have doors
- Some use a jet to move

## Gas Fueling Problem

In your project you should have classes that resemble the code below.

```cs
public class Zero : Vehicle // Electric motorcycle
{
    public double BatteryKWh { get; set; }

    public void ChargeBattery()
    {
        // method definition omitted
    }
}
```

```cs
public class Cessna : Vehicle // Propellor light aircraft
{
    public double FuelCapacity { get; set; }

    public void RefuelTank()
    {
        // method definition omitted
    }
}
```

```cs
public class Tesla : Vehicle // Electric car
{
    public double BatteryKWh { get; set; }

    public void ChargeBattery()
    {
        // method definition omitted
    }
}
```

```cs
public class Ram : Vehicle // Gas powered truck
{
    public double FuelCapacity { get; set; }

    public void RefuelTank()
    {
        // method definition omitted
    }
}
```

Your challenge is to replace your `Main` method with the following code and make the appropriate changes and additions to your project in order to make this `Main` method work.

> **HINT:** An example addition to your code might be an `IElectricVehicle` interface.

```cs
namespace Garage
{
    class Program
    {
        static void Main (string[] args)
        {
            Zero fxs = new Zero();
            Zero fx = new Zero();
            Tesla modelS = new Tesla();

            List<???> electricVehicles = new List<???>() {
                fx, fxs, modelS
            };

            Console.WriteLine("Electric Vehicles");
            foreach(??? ev in electricVehicles)
            {
                Console.WriteLine($"{ev.CurrentChargePercentage}");
            }

            foreach(??? ev in electricVehicles)
            {
                // This should charge the vehicle to 100%
                ev.ChargeBattery();
            }

            foreach(??? ev in electricVehicles)
            {
                Console.WriteLine($"{ev.CurrentChargePercentage}");
            }

            /***********************************************/

            Ram ram = new Ram ();
            Cessna cessna150 = new Cessna ();

            List<???> gasVehicles = new List<???>() {
                ram, cessna150
            };

            Console.WriteLine("Gas Vehicles");
            foreach(??? gv in gasVehicles)
            {
                Console.WriteLine($"{gv.CurrentTankPercentage}");
            }

            foreach(??? gv in gasVehicles)
            {
                // This should completely refuel the gas tank
                gv.RefuelTank();
            }

            foreach(??? gv in gasVehicles)
            {
                Console.WriteLine($"{gv.CurrentTankPercentage}");
            }
        }
    }
}
```

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

[ø](https://github.com/nashville-software-school/bangazon-inc/wiki/InterfaceStrategy)
