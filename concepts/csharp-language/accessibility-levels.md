# Accessibility Levels

In C#, there are five accessibility levels that can be applied to Classes, Methods, Properties and Data Members:

- public
- private
- protected
- internal
- protected internal

## Public

Classes and Methods that have tagged with the `public` keyword are accessibile without restriction. `public` methods are usable from derived classes (i.e. children) and from outside the inheritance heirarchy (i.e. family).

In some `Automobile.cs`:

```c#
// Base class
class Automobile {

    public string Accelerate() {
        return "zoom!";
    }

}

// Derived class
class Car : Automobile {
}
```

In some `Program.cs`:

```c#
Automobile generic_auto = new Automobile();
Console.WriteLine("Automobiles go {0}", generic_auto.Accelerate());

Car stella = new Car();
Console.WriteLine("Cars go {0}", stella.Accelerate());
```

## Private

Classes and Methods that have tagged with the `private` keyword are only accessible from within the class where it's defined. This means that private methods can not be called from anywhere outside the class, including derived classes (children).

Private methods are intended to be internal functionality. Consider the classes below:


```c#
// Base class
class Automobile {

    public string Accelerate() {
        this.InjectFuel();
        return "zoom";
    }

    private string InjectFuel() {
        return "fueling";
    }
}

// Usage Example in a Program.cs file somewhere

Automobile generic_auto = new Automobile();
Console.WriteLine("Automobiles go {0}", generic_auto.Accelerate());

// However, the following line of code does not compile
generic_auto.InjectFuel();
```


```c#
// Given a Derived class, the follow code does not compile
class Car : Automobile {

    public string CallAPrivateParentMethod {
        this.InjectFuel(); // Can not call InjectFuel b/c it's listed as private its parent class, Automobile
    }
}

// Usage Example in a Program.cs file somewhere
Car stella = new Car();

// Again, the following line of code does not compile
stella.InjectFuel();
```

## Protected

Classes and Methods that have tagged with the `protected` keyword prevent access from outside the class heirarchy (ie. the family); however, `protected` methods are usable from derived classes (i.e. children).

```c#
// Base class
class Automobile {

    public string Break() {
        this.SqueezeBreakPads();
        return "skuuuuuur";
    }

    protected string SqueezeBreakPads() {
        return "";
    }
}

// Derived class
class Car : Automobile {

    public string UseEmergencyBreak() {
        this.SqueezeBreakPads();
        return "skreeech!";
    }
}

// Usage Example in a Program.cs file somewhere
Car stella = new Car();

// UseEmergencyBreak method can use the protected SqueezeBreakPads from the Automobile class.
Console.WriteLine("Applying the break: {0}", stella.UseEmergencyBreak());
```


## Internal

Classes and Methods that have tagged with the `internal` keyword allow access from anywhere within the same compiled DLL (assembly).

For more information: https://msdn.microsoft.com/en-us/library/7c5ka91b.aspx

## Protected Internal

`protected internal` is the only allowed combination of multiple access modifiers.

## Resources
* https://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx