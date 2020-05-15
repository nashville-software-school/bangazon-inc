# Not Hello, World

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

This will create two files in the directory

1. `intro.csproj` - This file holds all the packages that you application will be using. It's the `package.json` for C#.
1. `Program.cs` - This is the file that holds your logic. Think of it as your `main.js`. It's where the logic of your application starts.

Copy this code into your Program.cs, replacing everything there.

```cs
using System;

namespace Intro
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.Write("What is your name? ");
            string name = Console.ReadLine();
            Console.WriteLine($"Hello, {name}! I'm glad to meet you.");
        }
    }
}
```

Run the program.

```sh
dotnet run
```

Enter a name and marvel at the warm greeting you receive.

What else would you like app to say? Take a few minutes and play with this code. What deep, philosophical truths can you make this app reveal?

## Learning a Second Language

Learning your first programming language is hard. It's hard because you're learning more than syntax, you're learning _how to code_ at the same time.

I have some good news. When it comes to learning your second language, you can transfer much of your understanding of your first language. It turns out that much of what you learned in JavaScript will apply to C# as well. There are notable differences and C# has some new concepts to learn, but a lot of the basic building blocks are the same.
