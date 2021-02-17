# Anatomy of a C# Program

This is a high-level overview of the basic structure of a C# program.

> **NOTE:** Up to now, we've taken advantage of C#'s top-level statement feature to write simple programs, but as we begin writing more complex programs, we'll switch to using the more standard, _idiomatic_ structure.

## File Structure

Every C# program is made up of at least two files: a project file and a C# file.

For example, a "Fortune Telling" app might have this structure.

```sh
FortuneTeller/
├── FortuneTeller.csproj
└── Program.cs
```

The `*.csproj` file is the project file. It contains configuration information about the application. There is only one project file per project, but a medium to large program may be made up of multiple projects.

A `*.cs` file is a C# source code file. This is where your C# code goes. There can be many `*.cs` files. A large project could easily have hundreds or more.

In addition to these files you will also find two directories called `bin` and `obj`. These directories contain the output of compiling your C# code.

> **NOTE:** The terms "program", "application" and "app" are synonyms.

## Program.cs

`Program.cs` is _usually_ the starting point of you C# program. It contains a class called `Program` with method called `Main`. The `Main` method is always where the code starts executing.

The code you have been writing at the top of the `Program.cs` file, should go inside the `Main` method from now on.

> **NOTE:** This is where things begin diverge from top-level statements. In standard C# applications, we write our code inside classes.

> **NOTE:** When we write a function as part of a class we call it a _method_. In C# we use the term _method_ the vast majority of the time.

```cs
using System;

namespace FortuneTeller
{
    class Program
    {
        static void Main(string[] args)
        {
            string fortune = "Everything will be ok... unless it isn't.";
            Console.WriteLine(fortune);
        }
    }
}

```

Let's walk through this code

```cs
using System;
```

This is the way we "import" parts of the .net class library. The `System` "namespace" contains the `Console` object that we use later in the program.

```cs
namespace FortuneTeller
```

A `namespace` is a collection of related classes.

When we need to use a class from one file inside of another file we _use_ the namespace in which the class is defined.

> **NOTE:** Students often find namespaces confusing at first. Just try to remember the definition for now. The understanding will come.

```cs
class Program
```

Almost all C# code must be contained inside a `class`. It is convention to use the same name for the class and the `*.cs` file.

```cs
static void Main(string[] args)
```

`Main` is a "method" in the `Program` class. A method is a function that exists inside a class. `Main` is a "static" method. This means we do not need to create a `Program` object in order to use it.

```cs
string fortune = "Everything will be ok.";
Console.WriteLine(fortune);
 ```

These lines make up the "body" of the `Main` method. The "body" of a method contains the executable C# code. Here we create a `string` variable and print it to the `Console`.

> **NOTE:** Remember the code we used to put at the top of the `Program.cs` file will now be placed in the `Main` method. C# will _automatically_ call this method for us. We do NOT invoke it ourselves.
