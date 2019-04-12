# Lean and Mean Interfaces

You want your interfaces to be as focused and specific as possible. A trap that some developers fall into is making interfaces that are too generic and broad in scope.

Consider the interfaces you've written so far for your animals. A naïve interface implementation that some developer could make would be an `IAnimal` interface.

```cs
public interface IAnimal
{
    int MaximumDepth {get;}

    void run();
    void walk();
    void swim();
    void fly();
    void dig();
}
```

This interface definitely describes common behaviors and properties for animals. The result, however, is that every specific animal class become what is called a "fat" class. Each would be forced to implement methods that would never be used.

```cs
public class Snake : IAnimal
{
    public void Fly()
    {
        throw new NotImplementedException();
    }

    public void Walk()
    {
        // Only useful implementation since snakes slither (i.e. "walk")
    }

    public void Run()
    {
        throw new NotImplementedException();
    }

    public void Swim()
    {
        throw new NotImplementedException();
    }

    public void Dig()
    {
        throw new NotImplementedException();
    }
}
```

This is bad because every time a snake is created, memory has to be allocated for each of those unused methods.

Avoiding this problem by breaking down your interfaces to be as specific as possible is an implementation of a SOLID Principle - the [Interface Segregation Principle](https://en.wikipedia.org/wiki/Interface_segregation_principle).

## Practice: Cleaning Gary's Garage

Use your knowledge of the Interface Segregation Principle and the Dependency Inversion Principle to convert the code below into a system that is more flexible and extensible to accomodate any kind of vehicle class. Each class should only implement code that it needs.

### Setup

```sh
mkdir -p ~/workspace/csharp/exercises/vehicle-interfaces && cd $_
dotnet new console -n Garage -o .
touch JetSki.cs Motorcycle.cs Cessna.cs
```

1. Create at least two types of each vehicle (water based, ground based, and air based). I've given you one of each kind.
1. Complete the tasks in the comments of the `Main()` method below.

```cs
using System;
using System.Linq;
using System.Collections.Generic;


public interface IVehicle
{
    int Wheels { get; set; }
    int Doors { get; set; }
    int PassengerCapacity { get; set; }
    bool Winged { get; set; }
    string TransmissionType { get; set; }
    double EngineVolume { get; set; }
    double MaxWaterSpeed { get; set; }
    double MaxLandSpeed { get; set; }
    double MaxAirSpeed { get; set; }
    void Start();
    void Stop();
    void Drive();
    void Fly();
}

public class JetSki : IVehicle
{
    public int Wheels { get; set; }
    public int Doors { get; set; }
    public int PassengerCapacity { get; set; }
    public bool Winged { get; set; }
    public string TransmissionType { get; set; }
    public double EngineVolume { get; set; }
    public double MaxWaterSpeed { get; set; }
    public double MaxLandSpeed { get; set; }
    public double MaxAirSpeed { get; set; }

    public void Drive()
    {
        Console.WriteLine("The jetski zips through the waves with the greatest of ease");
    }

    public void Fly()
    {
        throw new NotImplementedException();
    }

    public void Start()
    {
        throw new NotImplementedException();
    }

    public void Stop()
    {
        throw new NotImplementedException();
    }
}

public class Motorcycle : IVehicle
{
    public int Wheels { get; set; } = 2;
    public int Doors { get; set; } = 0;
    public int PassengerCapacity { get; set; }
    public bool Winged { get; set; } = false;
    public string TransmissionType { get; set; } = "Manual";
    public double EngineVolume { get; set; } = 1.3;
    public double MaxWaterSpeed { get; set; }
    public double MaxLandSpeed { get; set; } = 160.4;
    public double MaxAirSpeed { get; set; }

    public void Drive()
    {
        Console.WriteLine("The motorcycle screams down the highway");
    }

    public void Fly()
    {
        throw new NotImplementedException();
    }

    public void Start()
    {
        throw new NotImplementedException();
    }

    public void Stop()
    {
        throw new NotImplementedException();
    }
}

public class Cessna : IVehicle
{
  public int Wheels { get; set; } = 3;
  public int Doors { get; set; } = 3;
  public int PassengerCapacity { get; set; } = 113;
  public bool Winged { get; set; } = true;
  public string TransmissionType { get; set; } = "None";
  public double EngineVolume { get; set; } = 31.1;
  public double MaxWaterSpeed { get; set; }
  public double MaxLandSpeed { get; set; }
  public double MaxAirSpeed { get; set; } = 309.0;

  public void Drive()
  {
    throw new NotImplementedException();
  }

  public void Fly()
  {
    Console.WriteLine("The Cessna effortlessly glides through the clouds like a gleaming god of the Sun");
  }

  public void Start()
  {
    throw new NotImplementedException();
  }

  public void Stop()
  {
    throw new NotImplementedException();
  }
}


public class Program
{

    public static void Main() {

        // Build a collection of all vehicles that fly

        // With a single `foreach`, have each vehicle Fly()



        // Build a collection of all vehicles that operate on roads

        // With a single `foreach`, have each road vehicle Drive()



        // Build a collection of all vehicles that operate on water

        // With a single `foreach`, have each water vehicle Drive()
    }

}
```