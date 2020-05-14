# More about Classes

So far we've learned a lot about the power of classes in C#. This includes most of what you'll use on a regular basis, but there are a few more features of classes that you need to understand.

**add something about generics**

## Static

The `static` keyword is used to make class methods and properties usable without creating an instance of the class.

```cs
public class StringUtils
{
    public static string MakeExciting(string source)
    {
        return $"{source}!!!";
    }

    public static string Capitalize(string source)
    {
        char first = source[0];
        char upperFirst = Char.ToUpper(first);
        string rest = source.Substring(1);
        return $"{upperFirst}{rest}";
    }
}

public class Printer
{
    public void PrintSomeStuff()
    {
        string name = "mae";
        string statement = "I like the smell of scentless candles";

        Console.WriteLine(StringUtils.Capitalize(name));
        Console.WriteLine(StringUtils.MakeExciting(statement));
    }
}
```

To reference a `static` method or property, prefix it with the name of the class as we did with the `StringUtils` class in the example above.

## Overriding Properties and Methods

When inheriting from a parent class it is sometimes useful to redefine one or more of the parent class's methods and/or properties.

```cs
// The parent (aka "base") class
public class Person
{
    public string Name { get; set; }
    public virtual void Greet(Person otherPerson)
    {
        Console.WriteLine($"Hello, {otherPerson.Name}. It is a pleasure to meet you. I am {Name}");
    }
}

// The child (aka "sub") class
public class Stoner : Person
{
    public override void Greet(Person otherPerson)
    {
        Console.WriteLine($"Hey fellow human named {otherPerson.Name}. Meeting you is, like, an honor or whatever. They call me, {Name} the unusually awesome.");
    }
}
```

Note that we must mark the `Greet` method in both the parent and child classes. We use the `virtual` keyword in the parent class and the `override` keyword in the child class.

Probably the most famous use of overriding a method in C# is the `ToString()` method. This method is defined in the `System.Object` class and is used any time C# needs to convert an object into a string (for example, for printing with `Console.WriteLine()`). It is common for our custom classes to override `ToString()` in order to control how our objects are converted to strings.

```cs
public class SuperPower
{
    public string Name { get; set; }
    public double Intensity { get; set; }

    public override string ToString()
    {
        return $"Power {Name} with {Intensity}% intensity";
    }
}
```

## Access Modifiers

We've already learned about the  `public` and `private` access modifiers. C# has a few more as well.

### Protected

Methods and properties that have tagged with the `protected` keyword prevent access from outside the class hierarchy (ie. the family); however, `protected` methods are usable from derived classes (i.e. children).

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

* [Accessibility Levels (C# Reference)](https://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx)  
* [Access Modifiers (C# Programming Guide)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers)
