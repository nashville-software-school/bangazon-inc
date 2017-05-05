# Object Oriented Programming 

There are four tenets of object oriented programming, and you encountered all of them during your experience with JavaScript, which itself is an object oriented language.

## Inheritance with Classes

We taught you in the front end course how to handle inheritance in JavaScript with the prototypal style. In C#, you inherit with classes.

```c#
// Base class
class Animal {
    // Simple properties
    public double speed = { get; set; }
    public string species { get; set; }
    public int legs { get; set; }


    // Public method
    public void walk () {
        Console.WriteLine("Base class walk method");
        speed = speed + (0.1 * legs);
    }
}

// Derived class
class Lizard : Animal {
    // Adding additional properties to what is inherited from Animal
    public string scaleColor { get; set; }
    public bool camouflage { get; set; }
}

Lizard larry = new Lizard();
larry.legs = 4;
larry.scaleColor = "Brown";
larry.camouflage = false;
larry.walk();
Console.WriteLine("A {0} lizard moving at {1} m/s", larry.scaleColor, larry.speed);
```

## Polymorphism

[Polymorphism](https://msdn.microsoft.com/en-us/library/ms173152.aspx) means that different objects may share the same set of properties and methods, but each may use those properties and methods to achieve different behavior.

For example, in your base class of Animal, you define a general rule of how fast an Animal can walk. However, in the derived Lizard class, you can override that rule to give Lizards a slightly different behavior. For every leg they have, they can move twice as fast as a generic Animal.

In C#, you use the `virtual` keyword on a method, which allows any derived class to have its own implementation. The derived class can then use the `override` keyword to tell the compiler that it is redefining the base class' method.

```c#
// Base class
class Animal {
    // Simple properties
    public double speed { get; set; }
    public string species { get; set; }
    public int legs { get; set; }


    // Public method that can be redefined by derived classes
    public virtual void walk () {
        Console.WriteLine("Animal class walk method");
        speed = speed + (0.1 * legs);
    }
}

// Derived class
class Lizard : Animal {
    // Adding additional properties to what is inherited from Animal
    public string scaleColor { get; set; }
    public bool camouflage { get; set; }

    // Redefining the base class implementation
    public override void walk () {
        Console.WriteLine("Lizard class walk method");
        speed = speed + (0.2 * legs);
    }
}

// Create a Lizard
Lizard larry = new Lizard();
larry.legs = 4;
larry.scaleColor = "Brown";
larry.camouflage = false;
larry.walk();

Console.WriteLine("A {0} lizard moving at {1} m/s", larry.scaleColor, larry.speed);

// Create an Animal
Animal andy = new Animal();
andy.legs = 4;
andy.walk();

Console.WriteLine("An animal moving at {0} m/s", andy.speed);

```

## Encapsulation

The encapsulation concept is all about defining what data needs to be manipulated, defining the methods that need to be exposed to manipulate the data, and then hiding the internal representation of that data. Our current code encapsulates all of the functionality needed to create a basic animal and make it walk.

However, we hide the implementation of setting the speed of the animal since we want to control how it is set based on the simple algorithm in the `walk()` method.  That's called Information Hiding because no external actor (i.e. code) can access, or set, the walking speed of the animal. It can only specify the number of legs that the animal has.


## Abstraction

As your code becomes more complex, Abstraction is the process that you, the developer, will go through to provide the most general, and hopefully simplest, way possible. This is done via multiple refactors of your code as complexity slowly works its way in.

With our current code, the `Animal` class is an abstraction of more specific animals that we create later, such as the Lizard.


## Resources
* https://en.wikipedia.org/wiki/Object-oriented_programming
* https://msdn.microsoft.com/en-us/library/dd460654.aspx
* http://people.cs.aau.dk/~normark/oop-csharp/pdf/all.pdf
* http://people.cs.aau.dk/~normark/oop-csharp/html/notes/theme-index.html