# Strongly Typed Variables

Consider the following JavaScript code:

```js
let num = 42;
```

We say that `num` is a variable whose value is `42`. In Javascript the value, `42`, has a the type `number`, therefore we say that the variable `num` also has the type `number`.

However, in JavaScript, this is legal:

```js
num = "forty-two";
```

Now the value of `num` is of type `string`. So `num` is now a `string`.

Because of the ability to change the types of variables, we call JavaScript a _"loosely typed"_ language.

## C# is Strongly Typed

In C# we must specify the type of a variable when we create it. This means that once you create a variable in C#, you're committed to **only assign values of one type to the variable**.

```cs
string name = "Julio";
int num = 42;
List<bool> boolList = new List<bool>();
double percentage = 0.99;
```

## Types All the Way Down

In C# some types are more complex than others. An example of a complex type is a `Dictionary<,>`. A dictionary is similar to an `object` in JavaScript. It is a collection of key/value pairs. However, since C# is strongly typed, we must be explicit about the type of the key and the type of the value.

```cs
Dictionary<string, int> bowlingScores = new Dictionary<string, int>();

bowlingScores.Add("Marvin", 80);
bowlingScores.Add("Denise", 290);
bowlingScores.Add("Alef", 220);
bowlingScores.Add("Wilma", 200);
```

Note the `<string, int>` portion of the type. In this case `string` and `int` are referred to as "type parameters". These type parameters tell C# we want a Dictionary whose keys are strings and whose values are integers.

`Dictionary<,>` is an example of "generic" type. This is because it works "generically" with any other type.

## Custom Types

C# provides us with the ability to create custom types. These are types beyond strings, integers, booleans, lists, etc... In C# we create custom types with classes. We'll talk about classes in great detail soon, but for now here's an example of creating and using a class.

`Dog.cs`

```cs
public class Dog
{
    public string Breed { get; set; }
    public string Name { get; set; }
    public int Age { get; set; }
    public bool HasShots { get; set; }
}
```

`Program.cs`

```cs
using System;

namespace MyApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Dog rusty = new Dog()
            {
                Breed = "mut",
                Name = "Rusty",
                Age = 10,
                hasShots = true
            };

            Console.WriteLine(rusty.Name);
        }
    }
}
```
