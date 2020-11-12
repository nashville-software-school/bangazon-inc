# Enthusiastic Moose

## A C# Exercise

Create a realistic simulation of a inquisitive _(and enthusiastic)_ moose.

The program should be written in increments. Each phase will add a little more complexity.

As you go through the phases make sure you...

- Run the program after each change to confirm it works
- Commit your code after each phase

### Phase 1

1. From your workspace directory, use the `dotnet` command to create a new .NET console application, and then change to the project directory

   ```sh
   dotnet new console -o EnthusiasticMoose
   cd EnthusiasticMoose
   ```

1. Run the program to ensure everything is working

   ```sh
   dotnet run
   ```

1. Add a gitignore to the project

   ```sh
   dnignore
   ```

   > **NOTE:** Make sure you run this command from the `EnthusiasticMoose` directory.

1. initialize a git repository and commit

### Phase 2

Make some changes to the initial project's source code.

1. Open the project in Visual Studio Code.
1. Open the `Program.cs` File.

   > **NOTE:** A file with a `.cs` extension is a C# source code file.

1. Note the message that is displayed when the user runs the program. Change it to say:

   ```sh
   Welcome to the Enthusiastic Moose Simulator!
   --------------------------------------------

   ```

### Phase 3

Our user wants to see the moose they're interacting with and learn what it has to say. Let's make that happen.

1. Create a `MooseSays()` function that displays the enthusiastic moose and let's it speak. Copy the code for this function from the code below and paste it below the closing curly brace of the `Main()` function.

   > Program.cs

   ```cs
   using System;

   namespace EnthusiasticMoose
   {
       class Program
       {
           static void Main(string[] args)
           {
               Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
               Console.WriteLine("--------------------------------------------");
               Console.WriteLine();
           }

           static void MooseSays()
           {
               Console.WriteLine(@"
                                          _.--^^^--,
                                       .'          `\
     .-^^^^^^-.                      .'              |
    /          '.                   /            .-._/
   |             `.                |             |
    \              \          .-._ |          _   \
     `^^'-.         \_.-.     \   `          ( \__/
           |             )     '=.       .,   \
          /             (         \     /  \  /
        /`               `\        |   /    `'
        '..-`\        _.-. `\ _.__/   .=.
             |  _    / \  '.-`    `-.'  /
             \_/ |  |   './ _     _  \.'
                  '-'    | /       \ |
                         |  .-. .-.  |
                         \ / o| |o \ /
                          |   / \   |    H I, I'M  E N T H U S I A S T I C !
                         / `^`   `^` \
                        /             \
                       | '._.'         \
                       |  /             |
                        \ |             |
                         ||    _    _   /
                         /|\  (_\  /_) /
                         \ \'._  ` '_.'
                          `^^` `^^^`
               ");
           }
       }
   }
   ```

   > **NOTE:** We add an `@` in front of the string to allow for a _multi-line string_.

   > **NOTE:** In C# we use the word _"method"_ when referring to a _function_. We'll use the term _method_ throughout the remainder of the exercise.

1. Just creating the `MooseSays()` method is not enough to see what it does. We must call it. Update the `Main()` method to call `MooseSays()`.

   ```cs
   static void Main(string[] args)
   {
       Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
       Console.WriteLine("--------------------------------------------");
       Console.WriteLine();

       // Let the moose speak!
       MooseSays();
   }
   ```

### Phase 4

A moose that only says one thing isn't all that interesting. Let's give it the power to say anything we want by adding a parameter to the `MooseSays()` method.

1. Update the `MooseSays()` method to accept a `message` parameter and use _string interpolation_ to display the message next to the moose.

   ```cs
   static void MooseSays(string message)
   {
       Console.WriteLine($@"
                                         _.--^^^--,
                                       .'          `\
     .-^^^^^^-.                      .'              |
    /          '.                   /            .-._/
   |             `.                |             |
    \              \          .-._ |          _   \
     `^^'-.         \_.-.     \   `          ( \__/
           |             )     '=.       .,   \
          /             (         \     /  \  /
        /`               `\        |   /    `'
        '..-`\        _.-. `\ _.__/   .=.
             |  _    / \  '.-`    `-.'  /
             \_/ |  |   './ _     _  \.'
                  '-'    | /       \ |
                         |  .-. .-.  |
                         \ / o| |o \ /
                          |   / \   |    {message}
                         / `^`   `^` \
                        /             \
                       | '._.'         \
                       |  /             |
                        \ |             |
                         ||    _    _   /
                         /|\  (_\  /_) /
                         \ \'._  ` '_.'
                          `^^` `^^^`
       ");
   }
   ```

   > **NOTE:** We added the `$` character to the front of the string to enable string interpolation.

1. Update the `Main()` method to pass a message to `MooseSays()`.

   ```cs
   static void Main(string[] args)
   {
       Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
       Console.WriteLine("--------------------------------------------");
       Console.WriteLine();

       // Let the moose speak!
       MooseSays("H I, I'M  E N T H U S I A S T I C !");
       MooseSays("I really am enthusiastic");
   }
   ```

## Phase 5

Our moose is an inquisitive moose, but doesn't have time (or the attention span) for long-winded answers. Only `yes/no` questions will do.

1. Add a method called `MooseAsks()` that will give the moose the power to ask a `yes/no` question.

   ```cs
   static bool MooseAsks(string question)
   {
       Console.Write($"{question} (Y/N): ");
       string answer = Console.ReadLine().ToLower();

       while (answer != "y" && answer != "n")
       {
           Console.Write($"{question} (Y/N): ");
           answer = Console.ReadLine().ToLower();
       }

       if (answer == "y")
       {
           return true;
       }
       else
       {
           return false;
       }
   }
   ```

1. Call the `MooseAsks()` method from `Main()` and print out the response to verify everything works.

   ```cs
   static void Main(string[] args)
   {
       Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
       Console.WriteLine("--------------------------------------------");
       Console.WriteLine();

       // Let the moose speak!
       MooseSays("H I, I'M  E N T H U S I A S T I C !");
       MooseSays("I really am enthusiastic");

       // As a question
       bool isTrue = MooseAsks("Is Canada real?");
       Console.WriteLine(isTrue);
   }
   ```

## Phase 6

Our moose can ask a question now, but it doesn't respond. Let's change that.

1. Now that know our `MooseAsks()` method works, we don't need to print the response. Remove the `Console.WriteLine(response);` line

1. Add code to allow the moose to say something based on the user's response to the question.

   ```cs
   static void Main(string[] args)
   {
       Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
       Console.WriteLine("--------------------------------------------");
       Console.WriteLine();

       // Let the moose speak!
       MooseSays("H I, I'M  E N T H U S I A S T I C !");
       MooseSays("I really am enthusiastic");

       // As a question
       bool isTrue = MooseAsks("Is Canada real?");
       if (isTrue)
       {
           MooseSays("Really? It seems very unlikely.");
       }
       else
       {
           MooseSays("I  K N E W  I T !!!");
       }
   }
   ```

## Phase 7

Let's add multiple questions. We could do that in the `Main()` method, but `Main()` would quickly become very long. Instead, we should keep our methods small and gain the benefit of modularity by adding new methods for our questions.

1. Refactor the program to move the question into it's own method and call the new method from `Main()`

   ```cs
   static void Main(string[] args)
   {
       Console.WriteLine("Welcome to the Enthusiastic Moose Simulator!");
       Console.WriteLine("--------------------------------------------");
       Console.WriteLine();

       // Let the moose speak!
       MooseSays("H I, I'M  E N T H U S I A S T I C !");
       MooseSays("I really am enthusiastic");

       // As a question
       CanadaQuestion();
   }

   static void CanadaQuestion()
   {
       bool isTrue = MooseAsks("Is Canada real?");
       if (isTrue)
       {
           MooseSays("Really? It seems very unlikely.");
       }
       else
       {
           MooseSays("I  K N E W  I T !!!");
       }
   }
   ```

1. Add a few more questions. Feel free to copy and paste the code below and/or make up your own questions.

   ```cs
   static void EnthusiasticQuestion()
   {
       bool isEnthusiastic = MooseAsks("Are you enthusiastic?");
       if (isEnthusiastic)
       {
           MooseSays("Yay!");
       }
       else
       {
           MooseSays("You should try it!");
       }
   }

   static void LoveCSharpQuestion()
   {
       bool doesLoveCSharp = MooseAsks("Do you love C# yet?");
       if (doesLoveCSharp)
       {
           MooseSays("Good job sucking up to your instructor!");
       }
       else
       {
           MooseSays("You will...oh, yes, you will...");
       }
   }

   static void SecretQuestion()
   {
       bool isEverythingFine = MooseAsks("Do you want to know a secret?");
       if (isEverythingFine)
       {
           MooseSays("ME TOO!!!! I love secrets...tell me one!");
       }
       else
       {
           MooseSays("Oh, no...secrets are the best, I love to share them!");
       }
   }
   ```

1. Call your new methods from the `Main()` method

   ```cs
   // Ask some questions
   CanadaQuestion();
   EnthusiasticQuestion();
   LoveCSharpQuestion();
   SecretQuestion();
   ```

## Phase 8 - A Challenge

Our moose is finally both enthusiastic and inquisitive, but the code for asking each question is a little redundant.

1. Refactor the app to reduce the redundancy in the code.

## Advanced Challenge

[Magic Moose](./MAGIC_MOOSE.md)

## Advanced Challenge 2

[Rock Paper Scissors](./ROCK_PAPER_SCISSORS.md)
