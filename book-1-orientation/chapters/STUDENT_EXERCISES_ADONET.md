# Exploring Student Exercises in the database using <span>ADO</span>.NET

## Instructions

1. Create a new "**Console App (.NET Core)**" project.
1. Add the `System.Data.SqlClient` nuget package to your project.
1. Create a `Repository` class to interact with the `DogWalker` database you created in Student Exercises Part 4.
1. Write the necessary C# code in `Repository.cs` and `Program.cs` to perform the following actions. Make sure to print results of each action to the console.
    1. Query the database for all the Walkers.
    1. Find all the dog walkers in the database who work in the Inglewood neighborhood.
    1. Insert a new dog walker into the database.
    1. Find all owners in the database. Include each owner's neighborhood.
    1. Insert a new owner into the database. Assign the instructor to an existing neighborhood.
    1. Assign an existing walker to an existing neighborhood

## Challenges

1. Add the following to your program:
    1. Find all the dog owners in the database. Include each owner's neighborhood AND each owner's list of dogs.
    1. Write a method in the `Repository` class that accepts four arguments:  a `Walker`, an `Owner`, a `Date` and a `Duration`. The walker will walk each dog belonging to the owner ONLY if the dog has not been walked that day.

## Advanced Challenge

>**NOTE**: _Only work on this challenge if you've completed ALL the other exercises assigned during Orientation._

1. Modify your program to present the user with a menu and accept input from the user using the [Console.ReadLine()](https://docs.microsoft.com/en-us/dotnet/api/system.console.readline?redirectedfrom=MSDN&view=netframework-4.7.2#System_Console_ReadLine) method.
    Use the following program as an example for creating a menu.
    ```cs
    using System;
    using System.Linq;
    namespace UserInputExample
    {
        class Program
        {
            static void Main(string[] args)
            {
                while (true)
                {
                    Console.WriteLine();
                    Console.WriteLine("------------------------");
                    Console.WriteLine("Choose a menu option:");
                    Console.WriteLine("1. Shout it out.");
                    Console.WriteLine("2. Reverse it.");
                    Console.WriteLine("3. Exit.");

                    string option = Console.ReadLine();
                    if (option == "1")
                    {
                        Console.Write("What should I shout? ");
                        string input = Console.ReadLine();
                        Console.WriteLine(input.ToUpper() + "!!!");
                    }
                    else if (option == "2")
                    {
                        Console.Write("What should I reverse? ");
                        string input = Console.ReadLine();
                        Console.WriteLine(new string(input.Reverse().ToArray()));
                    }
                    else if (option == "3")
                    {
                        Console.WriteLine("Goodbye");
                        break; // break out of the while loop
                    } 
                    else
                    {
                        Console.WriteLine($"Invalid option: {option}");
                    }
                }
            }
        }
    }
    ```
     Create menu options to allow the user to perform the following tasks:
    1. Display all dogs.
    1. Display all walkers.
    1. Display all neighborhoods.
    1. Display all walks.
    1. Display all owners.
    1. Search for walkers who live in a neighborhood.
    1. Create a new owner.
    1. Create a new dog and assign them to an existing owner.
    1. Create a new walk and assign them to an existing dog.
    1. Display all dogs in a given walk.
    1. Move an existing dog to another existing owner.
    1. List the walks for a given dog.
 

>**NOTE**: C#'s [switch statement](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/switch) may simplify your menu code.
