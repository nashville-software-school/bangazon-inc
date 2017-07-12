# Interfaces and SOLID

## Setup

```
mkdir -p ~/workspace/csharp/exercises/vehicles && cd $_
dotnet new console
dotnet restore
```

## References

* [D is for the Dependency Inversion Principle](https://news.realm.io/news/donn-felker-solid-part-5/)
* [I is for the Interface Segregation Principle](https://news.realm.io/news/donn-felker-solid-part-4/)
* [What does “program to interfaces, not implementations” mean?
](https://stackoverflow.com/questions/2697783/what-does-program-to-interfaces-not-implementations-mean)
* [An Absolute Beginner's Tutorial on Dependency Inversion Principle](https://www.codeproject.com/Articles/615139/An-Absolute-Beginners-Tutorial-on-Dependency-Inver)
* [Interface Segregation Principle - A Walk Through History](https://www.codeproject.com/Tips/766045/Interface-Segregation-Principle-ISP-of-SOLID-in-Cs)

## Instructions

1. Use your knowledge of the Interface Segregation Principle and the Dependency Inversion Principle to convert the code below into a system that is more flexible and extensible to accomodate an kind of vehicle class. Each class should only implement code that it needs.
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