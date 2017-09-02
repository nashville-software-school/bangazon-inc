# Object Oriented Programming 

There are four tenets of object oriented programming, and you encountered all of them during your experience with JavaScript, which itself is an object oriented language.

## Inheritance with Classes

We taught you in the front end course how to handle inheritance in JavaScript with the prototypal style. In C#, you inherit with classes.

```c#
// Base class
class Animal {
    // Simple properties
    public double Speed { get; set; }
    public string Species { get; set; }
    public int Legs { get; set; }

    // Public method that can be redefined by derived classes
    public virtual void Walk () {
        Console.WriteLine("Animal class walk method");
        Speed = Speed + (0.1 * Legs);
    }
}

// Derived class
class Lizard : Animal {
    // Adding additional properties to what is inherited from Animal
    public string ScaleColor { get; set; }
    public bool Camouflage { get; set; }
}

Lizard larry = new Lizard();
larry.Legs = 4;
larry.ScaleColor = "Brown";
larry.Camouflage = false;
larry.Walk();
Console.WriteLine("A {0} lizard moving at {1} m/s", larry.ScaleColor, larry.Speed);
```

## Polymorphism

Class based inheritance is one example of polymorphism, but methods can be polymorphic as well, but overloading them.

### Method Based Polymorphism

A method's arity, or signature, can be overloaded. This is very different from JavaScript, when a function can only be defined once. This is not a rule in C#.

Let's make our `Animal.Walk()` method more flexible. As it was written above, it makes the assumption that the `Speed` and `Legs` properties have been set by the developer who created an instance. That's a bad assumption, so let's write code that will handle that case, but also allow the speed and legs values to be sent as parameters to the method.

```c#
class Animal {
    // Simple properties
    public double Speed { get; set; }
    public string Species { get; set; }
    public int Legs { get; set; }

    // Public method that can be redefined by derived classes
    public virtual void Walk () {
        Console.WriteLine("Animal class walk method");
        Speed = Speed + (0.1 * Legs);
    }

    public virtual void Walk (double speed, int legs) {
        Console.WriteLine("Animal class walk method that accepts parameters");

        // Set the object instance properties to the parameter values
        Legs = legs;
        Speed = Speed + (0.1 * Legs);
    }
}

Animal abilgail = new Animal(){
    Speed = 0.44,
    Legs = 2
};
abigail.walk();  // This works because the properties have values

Animal aaron = new Animal();
aaron.walk();  // This will throw an exception because the properties are null
aaron.walk(0.38, 4);  // This will work
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