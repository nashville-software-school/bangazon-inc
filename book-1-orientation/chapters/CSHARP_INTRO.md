# Hello, C#

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Define the acronym "CLI"
1. State the purpose of a `*.csproj` file
1. State the purpose of a `*.cs` file
1. Informally distinguish between the terms ".NET 6", ".NET Core" and ".NET Framework".
1. Create a new, empty C# console program
1. Write a simple "Hello World" C# console program
1. Run a C# program using the `dotnet run` command

---

## Your first console application

Let's begin with your first C# console application _(also known as a "command line interface" application or "cli" app)_.

Create a directory to hold the application.

```sh
mkdir -p ~/workspace/csharp/Intro && cd $_
```

Create a new console application with the `dotnet` command line utility.

```sh
dotnet new console -o <projectname> -f net6.0
```

This will create _(a.k.a. "scaffold")_ two files in the directory as well as an `obj` directory. Go ahead and open the `Intro` directory in Visual Studio Code.

1. `intro.csproj` - This is the _C# project file_ that contains certain configuration settings for your application. It's kinda like the `package.json` for C#.

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
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

> **NOTE:** There is a good reason the `dotnet new console` command created all that extra code. We just don't need it for this simple program.

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

## What's in a name? 

> _That which we call .NET by any other name would code as sweet._

We begin our .NET journey with a warning: _Microsoft is bad at naming things._

In your online research you will find references to technologies called **".NET 6", "dotnet", ".NET Core", ".NET Framework"** and just plain old **".NET"**.

Once you get some experience under your belt this will all make (_a little_) more sense, but for now here's all you need to know...

* **dotnet** is the command line tool we'll use during the first part of the course. It will target .NET 6 without us having to do anything special (assuming you added the `global.json` file in the installations chapter).
* **.NET Core** is the _previous version_ of .NET, but it is not very old. If you find documentation, blog posts, Stack Overflow answers, etc... referring to .NET Core, most of the time _**the information will still be accurate and you should use it**_. However, you should pay attention to the _version number_ of .NET Core. Information about versions `2.x` or `3.x` is much better than `1.x`.
* **.NET Framework** is the old, Windows-only version of .NET. It was replaced by .NET Core and then by .NET 6 (and now .NET 6). Even though it's old, it is still used _a lot_, so you'll probably find references to it on the web. _**We will NOT be using .NET Framework in this corse. When you find information that refers to .NET Framework, you should IGNORE IT**_.
* **.NET** is an umbrella term that might refer to _**ANY**_ of the above technologies. Microsoft is _trying_ to re-brand .NET to refer to .NET 6 and later, but that hasn't happened (yet?). When you run into this term you should try to figure out which .NET is refers to. If you can't, ask for help or move on to another resource.
 
In addition to the above terms, you might find online references to **"mono", "xamarin" or "unity"**. These are still current technologies that are related to .NET, but they won't be covered in this course.

## Pushing To Github

Before you push to Github, make sure that you add a gitignore file to your project. In your terminal, from the root of the application run `dotnet new gitignore`.

## Learning a Second Language

Learning your first programming language is hard. It's hard because you're learning more than syntax, you're learning _how to code_ at the same time.

I have some good news. When it comes to learning your second language, you can transfer much of your understanding of your first language. It turns out that much of what you learned in JavaScript will apply to C# as well. There are notable differences and C# has some new concepts to learn, but a lot of the basic building blocks are the same.
