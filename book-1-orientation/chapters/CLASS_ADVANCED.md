# More about Classes

So far we've learned a lot about the power of classes in C#. This includes most of what you'll use on a regular basis, but there are a few more features of classes that you need to understand.

## Static

## Overriding Properties and Methods

## Access Modifiers

We've already learned about the  `public` and `private` access modifiers. C# has a few more as well. 

### Protected

Classes and Methods that have tagged with the `protected` keyword prevent access from outside the class hierarchy (ie. the family); however, `protected` methods are usable from derived classes (i.e. children).

```cs
// Base class
public class Automobile {

    public string Break() {
        SqueezeBreakPads();
        return "skuuuuuur";
    }

    protected string SqueezeBreakPads() {
        return "";
    }
}

// Derived class
public class Car : Automobile {

    public string UseEmergencyBreak() {
        SqueezeBreakPads();
        return "skreeech!";
    }
}

// Usage Example in a Program.cs file somewhere
Car stella = new Car();

// UseEmergencyBreak method can use the protected SqueezeBreakPads from the Automobile class.
Console.WriteLine($"Applying the break: {stella.UseEmergencyBreak()}");
```

### Internal

Classes, methods and properties tagged with the `internal` keyword allow access from anywhere within the same compiled assembly (DLL or EXE).

### Protected Internal

`protected internal` is the only allowed combination of multiple access modifiers. A `protected internal` method or property is accessible from the current assembly or from classes that are derived from the containing class.

## Resources

> [Accessibility Levels (C# Reference)](https://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx)
> [Access Modifiers (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers)
