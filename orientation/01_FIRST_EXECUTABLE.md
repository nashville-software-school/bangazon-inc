# Not Hello, World

## Setup

We're going to get your first C# console application setup and running so that we can review some basics of the language.

Create a directory to hold the application.

```
mkdir ~/workspace/csharp/bangazoncli && cd $_
```

Create a new console application with the `dotnet` command line utility.

```
dotnet new console
```

This will create two files in the directory

1. `bangazoncli.csproj` - This file holds all the packages that you application will be using. It's the `package.json` for C#.
2. `Program.cs` - This is the file that holds your logic. Think of it as your `app.js` from Angular. It's where the logic of your application starts.

Copy this code into your Program.cs, replacing everything there.

```cs
using System;

namespace bangazoncli
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Welcome to Bangazon!");
        }
    }
}

```


> ☞ Unike JavaScript, C# is a compiled language, meaning that you need a compiler to read the source code, parse all the logic, and then construct a new executable file.

Next, you compile the program.

```
dotnet build
```

Now that you have verified that the program will compile without errors, you can execute it.

```
dotnet run
```

You should see `Welcome to Bangazon!` print out in your terminal.

## Strongly Typed Variable in C#

Now replace your source code with the following.

```cs
using System;

namespace bangazon
{
    class Program
    {
        static void Main(string[] args)
        {
            // DateTime is the type of the purchaseData variable.
            DateTime purchaseDate=DateTime.Now;

            /*
                string is the type of the lastName variable. It 
                tells the compiler that the lastName variable can
                ONLY hold a string value.
            */
            string lastName="Smith"; 

            /*
                C# now supports implicitly typing of a variable as well,
                but be careful with it because it will change the 
                type depending on the value assignment.
            */
            var firstName="Bill";

            /* 
              The String.Format() function syntax allows you to
              build the final string, with placeholders, and
              then provide comma-delimited list of variables to
              use in the placeholders.
            */
            Console.WriteLine("{0} {1} purchased on {2}", 
                firstName, 
                lastName, 
                purchaseDate);
        }
    }
}
```

# C# Collections

The C# language has many ways to store a collection of items. You'll quickly see that C# is much more verbose when you write your source code, because the developer needs to provide all of the instructions to the compiler, unlike JavaScript or other dynamically typed languages.

We'll look at a very simple type of collection first - an array of strings. Add the following code to your `Main` method.

```cs
/*
    Not only do you have to say what type the variable is, you also 
    have to instantiate that exact same type of object on assignment.
    This may seem redundant, but it's part of the C# language compiler's 
    type checking constraints.
*/
string[] products = new string[] {
    "Motorcycle",
    "Sofa",
    "Sandals",
    "Omega Watch",
    "iPhone"
};

/*
    This syntax should look very similar to what you did in an Angular
    partial's ng-repeat directive. However, once again you have to 
    explicitly say what type of variable product is. Since the products
    array holds strings, then its type must be string.
*/
foreach (string product in products) {
    Console.WriteLine(product);
}
```

# C# Conditions

Luckily, the `if-then` syntax works exactly like it did in JavaScript. Let's put a condition around what products get displayed. Only products that have a length of 5, or greater.

```cs
foreach (string product in products) {
    if (product.Length > 5) {
        Console.WriteLine(product);
    }
}
```


# Resources

I strongly recommend that you bookmark the following web page.

[C# Programming Guide](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/index)