# Static classes, methods and properties

In C# all your code must be inside a `class`. Normally a class acts as a blueprint for creating objects within your program. However, there are times when you don't need to create a new object in order get your work done. Sometimes you just need a function or a property without the "context" of an object.

This is where the `static` classes come in.

Consider the following:

```csharp
public static class MathUtils {
    public static double PI {
        get {
            return 3.14159;
        }
    }

    public static int Pow(int num, int exponent) {
        int result = 1;
        for(int i=0; i<exponent; i++) {
            result = result * num;
        }
        return result;
    }
}
```

Note the use of the `static` keyword in the code above.

When applied to a `class` (as in `public static class MathUtils`), it tells C# that the class **cannot** be instantiated. Meaning it is impossible to make a `new MathUtils()` object.

When applied to a `property` or `method` the `static` keyword tells C# that you can use the property or method without an instance of a class. That is, without an object.

So, if we don't have an object, how do we use static properties and methods?

```cs
static void Main(string[] args) {
    int eight = MathUtils.Pow(2, 3);
    double pi = MathUtils.PI;

    Console.WriteLine($"I {eight} some {pi}.");
}
```
To access a static property or method, prefix it with the name of the class followed by a dot (.)

> **NOTE:** You might imagine other math-y utilities as well. In fact, Microsoft already thought of a few: https://docs.microsoft.com/en-us/dotnet/api/system.math

## Static methods and properties on non-static classes

A non-static class may contain static methods and properties.

```cs
public class Person {
    public string Name { get; set; }
    public int Age { get; set; }

    public static Person WhoIsOlder(Person a, Person b) {
        if (a.Age > b.Age) {
            return a;
        } else {
            return b;
        }
    }
}
```

We use static properties and methods in non-static classes the same way we use them in static classes.

```cs
Person oldRoy = new Person() { Name = "Roy", Age = 91 };
Person kidRay = new Person() { Name = "Ray", Age = 19 };

Person olderPerson = Person.WhoIsOlder(kidRay, oldRoy);
```

> **NOTE:** **All** methods and properties of a `static class` **must** also be marked as `static`.

## Practice

1. Given the following `StringUtils` class, add a method to capitalize all words in an `IEnumerable<string>`.
    ```cs
    public static class StringUtils {
        public static string ToCapitalized(string word) {
            if (string.IsNullOrWhiteSpace(word)) {
                return word;
            }

            string capitalizedWord = word[0].ToString().ToUpper();
            foreach(char letter in word.Skip(1)) {
                capitalizedWord += letter.ToString().ToLower();
            }

            return capitalizedWord;
        }

        public static IEnumerable<string> CapitalizeAll(IEnumerable<string> words) {
            // write the code for this method
        }
    }
    ```
1. Build a `PrintUtils` class with the following static methods.
    * A method to print each element in a `IEnumerable<string>` to the console.
    * A method to print each element in a `IEnumerable<int>` to the console.



> **NOTE:** You might want to keep the `PrintUtils` class around and use it in future exercises.
