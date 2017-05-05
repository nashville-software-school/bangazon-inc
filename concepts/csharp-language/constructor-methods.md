# Constructor Methods

The purpose of the constructor method is identical to its purpose in JavaScript, to run some initialization code when you create an object. Let's look at an example.

```cs
// Simple class
class Car
{
    // Simple public properties
    public int wheels { get; set; }
    public string color { get; set; }
    public string make { get; set; }
    public string model { get; set; }
}
```

That's a simple class that defines what properties will be on a new Car object.

```cs
// Create a new instance of a Car
Car impala = new Car();

// Set the properties
impala.wheels = 4;
impala.color = "black";
impala.make = "Chevrolet";
impala.model = "Impala";
```

However, we can make an assumption that a car will have four wheels by default when a new one is created, and that can then be reassigned later if need be. A constructor method allows us to set that default value for every new Car object.

A constructor method's access modifier must be `public` and the name of the method is the exact same name as the class.

```cs
class Car
{
    // Simple public properties
    public int wheels { get; set; }
    public string color { get; set; }
    public string make { get; set; }
    public string model { get; set; }

    // Constructor method for every Car
    public Car () 
    {
        this.wheels = 4;
    }

}
```

Hey, look!  It's the `this` keyword again! It means the same thing here as it did in JavaScript. `this` is a reference to the object you created, so this constructor method will set the value of the `wheels` property to 4 for every Car.

```cs
Car accord = new Car();
Console.WriteLine(accord.wheels); // This will output 4
```