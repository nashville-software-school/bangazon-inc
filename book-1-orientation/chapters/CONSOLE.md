# Writing to and Reading from the Console

The `Console` object in C# is the way we interact with the terminal. We can write to it - meaning we can print out text, and we can read from it - meaning we can capture user input.

> **NOTE:** The "terminal", "console" and "command line" all refer to the same thing.

The `Console` object is inside the `System` namespace. We have to tell C# we want to "use" it.

```cs
using System;
```

## Writing to the Console

There are two methods for writing to the `Console`. `Write()` and `WriteLine()`.

`Console.WriteLine()`will print it's argument to the console and then add a "newline".

`Console.Write()` will print it's argument without adding a "newline"

```cs
Console.Write("The quick brown");
Console.WriteLine("fox jumps");
Console.Write("over the");
Console.WriteLine("lazy dog");
```

prints

```sh
The quick brownfox jumps
over thelazy dog
```

## Reading from the Console

There are several methods for reading user input from the console, however the method we'll use is `ReadLine()`. It's important to note that the `ReadLine` method is always a string. If the value you actually want from your user is an integer or double, you'll have to take additional steps to parse it as such.

```cs
string input = Console.ReadLine();
```

> **NOTE:** For more information about `Console` methods, check out the [documentation](https://docs.microsoft.com/en-us/dotnet/api/system.console)
