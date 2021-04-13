# Anatomy of a C# Program

This is a high-level overview of the basic structure of a C# program. Much of what is covered here will be confusing, but don't worry we will cover it in more detail as we move throughout the course.

## File Structure

Every C# program is made up of at least two files: a project file and a C# file.

For example, a "Fortune Telling" app might have this structure.

```sh
FortuneTeller/
├── FortuneTeller.csproj
└── Program.cs
```

The `*.csproj` file is the project file. It contains configuration information about the application. There is only one project file per project.

A `*.cs` file is a C# source code file. This is where your C# code goes. There can be many `*.cs` files. A large project could easily have hundreds or more.

In addition to these files you will also find two folders called `bin` and `obj`. These folders contain the output of compiling your C# code.

## Program.cs

`Program.cs` is _usually_ the starting point of you C# program. It contains a class called `Program` with method called `Main`. The `Main` method is always where the code starts executing.

```cs
using System;

namespace FortuneTeller
{
    class Program
    {
        static void Main(string[] args)
        {
            string fortune = "Everything will be ok.";
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