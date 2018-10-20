# Interfaces

An interface in C# is a construct that you define for classes to implement. Think of it as a contract for a class. If a class implements an interface, then it must define a method, property, or event for each one defined in the interface.

## Resources

* [Interface-based programming](https://en.wikipedia.org/wiki/Interface-based_programming)
* [Understanding Interface-based Programming](https://msdn.microsoft.com/en-us/library/aa260635(v=vs.60).aspx)
* [The Dependency Inversion Principle](https://code.tutsplus.com/tutorials/solid-part-4-the-dependency-inversion-principle--net-36872)
* [Interface segregation principle](https://en.wikipedia.org/wiki/Interface_segregation_principle)

## Examples

Imagine a scenario in which you are writing an application in which you need to classify any animal species as ground-based, air-based, or water-based. Also consider that animal species can be any combination of those classifications. To make our code base as flexible as possible, we define the properties and behaviors of each classification (or description) into an interface.

```cs
public interface IAmbulatory
{
    void run();
    void walk();
}

public interface IFlying
{
    void fly();
    void land();
}

public interface IAquatic
{
    int MaximumDepth {get;}
    void swim();
    void float();
}
```

We've defined three interfaces. One for land animals, one for aquatic animals, and one for flying animals. Here's how you would specify that a class must implement an interface.

```cs
public class PaintedDog : IAmbulatory
{
}
```

Since it is a contract, we must implement the methods that were defined in the interface.

```cs
public class PaintedDog : IAmbulatory
{
    public void run()
    {
        Console.WriteLine("Animal is now running");
    }

    public void walk()
    {
        Console.WriteLine("Animal is now walking");
    }
}
```


The `PaintedDog` class has now implemented the two methods required by the inteface that was designated. If you had not written the `walk()` function, the code would not compile and you would get a message like this.

```
'PaintedDog' does not implement interface member 'IAmbulatory.walk()'
```

### Multiple Interfaces

A class can implement more than one interface. Let's use a flying squirrel as an example. They don't truly fly (they glide) but it's close enough for an example.

```cs
class FlyingSquirrel : IAmbulatory, IFlying
{
    public void run()
    {
        Console.WriteLine("Animal is now running");
    }

    public void walk()
    {
        Console.WriteLine("Animal is now walking");
    }

    public void fly()
    {
        Console.WriteLine("Animal is now flying");
    }

    public void land()
    {
        Console.WriteLine("Animal is now on the ground");
    }
}
```

Let's look at another example of a class that would implement all three of the interfaces. Since this is orientation, and you're learning to use Visual Studio Code, we've included an animation that shows you how you can quickly implement interfaces for a class with some boilerplate code.

Paste this code into `Program.cs`, and the interfaces should now be underlined in red.

```cs
public class Seagull: IAquatic, IAmbulatory, IFlying
{

}
```

Watch how to generate the boilerplate code.

![](./assets/interface-implementation.gif)

# Dependency Inversion

Now that we've got a flexible system to define many different kinds of animals, our next task is to define an animal control person. The thing is, the painted dogs keep finding a way to escape their enclosure at a zoo, and we keep needing to hire an animal control specialist that specializes in capturing ground-based animals like dogs, cats, emus, etc.

We need to represent this actor in our software application so we can write logic to keep records of when the specialist captures the dog. Here's an initial code.

```cs
public class AnimalControl
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public double HourlyRate { get; set; }

    public void Capture (PaintedDog dog)
    {
        // Logic to contain, sedate, and return the painted dog
    }
}
```

This certainly solves the problem at hand so we can perform the behavior of capturing an escaped dog. However, the experienced developer that has knowlede of, and practice in, the SOLID principles understand that *in the future*, it is highly like that the animal control specialist will be needed to capture other ground-based animals.

Therefore, the `Capture()` method must be rewritten to allow external code to pass in any ambulatory animal. This is the Dependency Inversion Principle.

```cs
public class AnimalControl
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public double HourlyRate { get; set; }

    public void Capture (IAmbulatory animal)
    {
        // Logic to contain, sedate, and return any ground-based animal
    }
}
```

Now, any object instance based on the `AnimalControl` class can capture any ground-based animal. In the previous code, they were locked into capturing dogs only.
