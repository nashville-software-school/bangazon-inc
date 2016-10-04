#CSharp Tour

###What you will learn
You will about the application structure and code for a simple command line application. 

###Main Method
All command line applications use the Main method as their entry point to an application. Arguments can be passed to the Main Method.

```
      public static void Main(string[] args)
        {
            Console.WriteLine(CustomerGreeting().ToString());
        }
```

Here is an example of a main method that accepts an argument.
In this case we are passing a date. 
```
dotnet run 1/1/2017
```
This is how the passed in date is used by the application. 
```

```
 
###Program.cs
The Main method is usually found in a c# class called Program. It has an extension of .cs.  As you can see from the example below a CSharp class can contain methods. Notice that the class is using a Name Space. Namespaces serves two purposes:

1. Namespaces are heavily used in C# programming in two ways. First, the .NET Framework uses namespaces to organize its many classes.
2. Second, declaring your own namespaces can help you control the scope of class and method names in larger programming projects. Use the namespace keyword to declare a namespace. Notice the class is contained in a namespace called "ConsoleApplication". The name space can be changed to something more specific. Oftentimes an application will have several names spaces in it. Don't assume that name spaces is related to folder structure, often it is the case but they are not related. 
Your can find additional information regarding name spaces here: https://msdn.microsoft.com/en-us/library/0d941h9d.aspx
```
using System;

namespace ConsoleApplication
{
    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```
