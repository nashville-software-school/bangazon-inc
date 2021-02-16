# Hello, C#

## Getting Started Guide

Please read and complete the steps in the official [Get Started with C# and Visual Studio Code](https://docs.microsoft.com/en-us/dotnet/core/tutorials/with-visual-studio-code) guide.

## Your first console application

Let's begin with your first C# console application _(also known as a "command line interface" application or "cli" app)_.

Create a directory to hold the application.

```sh
mkdir -p ~/workspace/csharp/Intro && cd $_
```

Create a new console application with the `dotnet` command line utility.

```sh
dotnet new console
```

This will create _(a.k.a. "scaffold")_ two files in the directory.

1. `intro.csproj` - This is the _C# project file_ that contains certain configuration settings for your application. It's kinda like the `package.json` for C#.

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net5.0</TargetFramework>
    </PropertyGroup>

    </Project>
    ```

1. `Program.cs` - This is a _C# source file_. It's the file that holds your C# source code. _(note the `.cs` file extension)_ Think of it as your `main.js`. It's where the logic of your application starts.

    ```cs
    using System;

    namespace Intro
    {
        class Program
        {
            static void Main(string[] args)
            {
                Console.WriteLine("Hello World!");
            }
        }
    }
    ``  `

Before we dig any deeper, let's run our new application. Back in your terminal run this command.

```sh
dotnet run
```

### So much code...

I suspect you weren't surprised by what happened when you ran the code. But you might be surprised at just how much code it took to simply write "Hello World!" to the screen.

It turns out it doesn't _actually_ take that much code. Let's refactor the `Program.cs` file so that the code is as minimal as possible while still doing the same thing.

Replace everything in `Program.cs` with this code and run the program again.

```cs
System.Console.WriteLine("Hello World!");
```

That's a lot shorter.

Yes, it's still a little more code than you'd write in JavaScript, but there are benefits to the verbosity of C#. Trust me.

> **NOTE:** There is a good reason the `dotnet new console` command created all that extra code. We just don't it for this simple program.

### Making things a little more interesting

Copy this code into your `Program.cs` file, replacing everything there.

```cs
System.Console.Write("Who would you like to say hello to? ");

string name = System.Console.ReadLine();

if (string.IsNullOrWhiteSpace(name))
{
    System.Console.WriteLine("Fine, don't say 'hello'!");
}
else
{
    System.Console.WriteLine($"Hello, {name}!");
}
```

Take a moment to read this code. Can you predict what it will do?

Once you've made your prediction, run the program.

```sh
dotnet run
```

Enter a name and marvel at the warm greeting you receive.

What happens when you don't enter a name?

### Using `using`

Before we move on, let's do one last refactor of our code to make it a little easier to read.

Update your `Program.cs` file with this code.

```cs
using System;

Console.Write("Who would you like to say hello to? ");

string name = Console.ReadLine();

if (string.IsNullOrWhiteSpace(name))
{
    Console.WriteLine("Fine, don't say 'hello'!");
}
else
{
    Console.WriteLine($"Hello, {name}!");
}
```

What did we change? What do you think the `using` statement does?

## Pushing To Github

Before you push to Github, make sure that you add a gitignore file to your project. In your terminal, from the root of the application run `dnignore`. If you get an error saying the command is not found, be sure to go back to the installation chapter and get that added to your bashrc file.

## Learning a Second Language

Learning your first programming language is hard. It's hard because you're learning more than syntax, you're learning _how to code_ at the same time.

I have some good news. When it comes to learning your second language, you can transfer much of your understanding of your first language. It turns out that much of what you learned in JavaScript will apply to C# as well. There are notable differences and C# has some new concepts to learn, but a lot of the basic building blocks are the same.
