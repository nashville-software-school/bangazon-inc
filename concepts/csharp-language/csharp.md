# C# Basics 

## Strongly Typed

Unlike JavaScript, which will store any value, in any variable, C# requires that you provide the type of each variable and method (i.e. function) when it is declared.

Here's an example of a method that returns a `string` that contains a variable that will also store a `string`.

```c#
string animalName () {
    string name = "Lizard";
    return name;
}
```

Copy pasta that code into Code, or Visual Studio, and compile.

With this method, you are telling the C# compiler that `animalName()` will always return a `string` value, and that the `name` variable will always contains a `string` value. If you violate this contract, the friendly compiler will tell you.

##### Incorrect return type

```c#
string animalName () {
    string name = "Lizard";
    return 1;
}
```

If you try to run that code, the compiler will provide a message stating that what you attempted to return out of the method could not be converted to a string.

```
(3,12): error CS0029: Cannot implicitly convert type 'int' to 'string'
```

In order for the compiler to accept your code and compile the program would be to change the signature of the method to be of type `int`.

```c#
int animalName () {
    string name = "Lizard";
    return 1;
}
```

### Native Types

Please review the [MSDN article](https://msdn.microsoft.com/en-us/library/ya5y69ds.aspx) that lists the C# built-in types. Click on each one to read its description and see some example usage.

## Classes

[Classes](https://msdn.microsoft.com/en-us/library/0b0thckt.aspx) are how you define your own custom types for your application. Just like in JavaScript, you are going to define some default properties for your class and some default behaviors and functionality for your class. In C# World, however, we don't use the word functions. They are called *methods*.

Let's look at a basic example of defining a class with private state, and some public methods for accessing the private state of a class. Remember the IIFE pattern in JavaScript to emulate private/public variables and functions? In C# you can explicitly declare variables and method as public or private.

```c#
class Animal {
  /*
    Define some private properties of an animal.
    In C# Land, the common convention for private variable naming
    is to precede it with an underscore.
  */
  private string _name = "";
  private int _legs = 0;
  private double _speed = 0.0;
  private bool _isMoving = false;

  // Getters and setters in C# have concise syntax
  public int legs {
    get { return _legs; }
    set {
      if (value > 0) {
        _legs = value; // What is value?
      }
    } 
  }

  public double speed {
    get { return _speed; }
    set { _speed = value; }
  }

  // You can also define simple properties where no logic is needed
  public string species { get; set; }

  // Define some behavior. Methods are also typed.
  // `void` is a valid return type, and it means that
  // there is no return type at all.
  public void walk () {
    _isMoving = true;
    _speed = _speed + (0.1 * _legs);
  }
}
```

Copy pasta that code into Code, or Visual Studio and compiled.

Then type in the following code and compile again.

```c#
Animal lizard = new Animal();
lizard.species = "Reptile";
lizard.legs = 4;
lizard.walk();
Console.WriteLine(lizard.species + " walking at speed " + lizard.speed);
```

You will see output of `Reptile walking at speed 0.4`.

Let's talk about that code you just typed in. It looks very familiar to JavaScript code that you're used to typing.

```c#
/*
  In JavaScript, you didn't need to prepend a variable with the
  data type that it would contain, but in C# you do. The `new`
  keyword works here just like it did in JavaScript. It creates
  a new object of type Animal. Therefore, we need to tell the
  compiler that `lizard` is an Animal.
*/
Animal lizard = new Animal();

/*
  Setting some properties via the setters
 */
lizard.species = "Reptile";
lizard.legs = 4;

/*
  Next, we invoke the walk() method on the lizard, which is only
  possible because we declared it as a `public` method.
 */
lizard.walk();

/*
  Instead of `console.log()`, you use `Console.WriteLine()` to output
  the return value of invoking the `speed()` method.

  String concatenation works very similar to JavaScript. Either with 
  the + symbol
 */
Console.WriteLine(lizard.species + " walking at speed " + lizard.speed);

/*
  or with interpolation
 */
Console.WriteLine("{0} walking at speed {1}", lizard.species, lizard.speed);
```


## Namespaces

A namespace is simply a way to group classes and other types into a logical grouping. Think back to the front end course and how you avoided polluting the global scope by creating a single variable name, like in the Gauntlet group project, and put all other objects as properties of that one variable.

That's called namespacing.

Luckily, in C#, you can use the `namespace` keyword to create different namespaces.


# External Resources

+ [C# Fundamentals with Visual Studio 2015](https://app.pluralsight.com/library/courses/c-sharp-fundamentals-with-visual-studio-2015/table-of-contents)
+ [Command Line Parameters](https://github.com/CoryFoy/DotNetKoans)
+ [Arrays](https://msdn.microsoft.com/en-us/library/aa288453%28v=vs.71%29.aspx)
+ [Lynda C# Tutorials](http://www.lynda.com/C-sharp-training-tutorials/1022-0.html)