# An Adventurer's Quest

## A C# Exercise

This exercise we will don the brightly colored robe and shiny hat of an adventurer and undergo a series of challenges to complete a quest.

### Phase 1

In this phase we'll get going with some starter code. We'll add to this initial code in future phases.

1. Create a new console application called _"Quest"_.
1. Initialize a git repo for the new app, add a `.gitignore` file and commit the code.
1. Create a new repo in GitHub and push your code to it.
1. Add two new C# source code files. _(Do not remove the `Program.cs` file)_
    * `Adventurer.cs`
    * `Challenge.cs`
1. Update the `*.cs` files to contain the code shown below.

    > `Program.cs`

    ```cs
    using System;
    using System.Collections.Generic;

    // Every class in the program is defined within the "Quest" namespace
    // Classes within the same namespace refer to one another without a "using" statement
    namespace Quest
    {
        class Program
        {
            static void Main(string[] args)
            {
                // Create a few challenges for our Adventurer's quest
                // The "Challenge" Constructor takes three arguments
                //   the text of the challenge
                //   a correct answer
                //   a number of awesome points to gain or lose depending on the success of the challenge
                Challenge twoPlusTwo = new Challenge("2 + 2?", 4, 10);
                Challenge theAnswer = new Challenge(
                    "What's the answer to life, the universe and everything?", 42, 25);
                Challenge whatSecond = new Challenge(
                    "What is the current second?", DateTime.Now.Second, 50);

                int randomNumber = new Random().Next() % 10;
                Challenge guessRandom = new Challenge("What number am I thinking of?", randomNumber, 25);

                Challenge favoriteBeatle = new Challenge(
                    @"Who's your favorite Beatle?
        1) John
        2) Paul
        3) George
        4) Ringo
    ",
                    4, 20
                );

                // "Awesomeness" is like our Adventurer's current "score"
                // A higher Awesomeness is better

                // Here we set some reasonable min and max values.
                //  If an Adventurer has an Awesomeness greater than the max, they are truly awesome
                //  If an Adventurer has an Awesomeness less than the min, they are terrible
                int minAwesomeness = 0;
                int maxAwesomeness = 100;

                // Make a new "Adventurer" object using the "Adventurer" class
                Adventurer theAdventurer = new Adventurer("Jack");

                // A list of challenges for the Adventurer to complete
                // Note we can use the List class here because have the line "using System.Collections.Generic;" at the top of the file.
                List<Challenge> challenges = new List<Challenge>()
                {
                    twoPlusTwo,
                    theAnswer,
                    whatSecond,
                    guessRandom,
                    favoriteBeatle
                };

                // Loop through all the challenges and subject the Adventurer to them
                foreach (Challenge challenge in challenges)
                {
                    challenge.RunChallenge(theAdventurer);
                }

                // This code examines how Awesome the Adventurer is after completing the challenges
                // And praises or humiliates them accordingly
                if (theAdventurer.Awesomeness >= maxAwesomeness)
                {
                    Console.WriteLine("YOU DID IT! You are truly awesome!");
                }
                else if (theAdventurer.Awesomeness <= minAwesomeness)
                {
                    Console.WriteLine("Get out of my sight. Your lack of awesomeness offends me!");
                }
                else
                {
                    Console.WriteLine("I guess you did...ok? ...sorta. Still, you should get out of my sight.");
                }
            }
        }
    }
    ```

    > `Challenge.cs`

    ```cs
    using System;

    namespace Quest
    {
        // An instance of the Challenge class is an occurrence of a single challenge
        public class Challenge
        {
            // These private fields hold the "state" of an individual challenge object.
            // The values stored in these fields are not accessible outside the class,
            //  but can be used by methods or properties within the class
            private string _text;
            private int _correctAnswer;
            private int _awesomenessChange;


            // A constructor for the Challenge
            // We can tell it's a constructor because it has the same name as the class 
            //   and it doesn't specify a return type
            // Note the constructor parameters and what is done with them
            public Challenge(string text, int correctAnswer, int awesomenessChange)
            {
                _text = text;
                _correctAnswer = correctAnswer;
                _awesomenessChange = awesomenessChange;
            }

            // This method will take an Adventurer object and make that Adventurer perform the challenge
            public void RunChallenge(Adventurer adventurer)
            {
                Console.Write($"{_text}: ");
                string answer = Console.ReadLine();

                int numAnswer;
                bool isNumber = int.TryParse(answer, out numAnswer);

                Console.WriteLine();
                if (isNumber && numAnswer == _correctAnswer)
                {
                    Console.WriteLine("Well Done!");

                    // Note how we access an Adventurer object's property
                    adventurer.Awesomeness += _awesomenessChange;
                }
                else
                {
                    Console.WriteLine("You have failed the challenge, there will be consequences.");
                    adventurer.Awesomeness -= _awesomenessChange;
                }

                // Note how we call an Adventurer object's method
                Console.WriteLine(adventurer.GetAdventurerStatus());
                Console.WriteLine();
            }
        }
    }
    ```

    > `Adventurer.cs`

    ```cs
    namespace Quest
    {
        // An instance of the Adventurer class is an object that will undergo some challenges
        public class Adventurer
        {
            // This is an "immutable" property. It only has a "get".
            // The only place the Name can be set is in the Adventurer constructor
            // Note: the constructor is defined below.
            public string Name { get; }

            // This is a mutable property it has a "get" and a "set"
            //  So it can be read and changed by any code in the application
            public int Awesomeness { get; set; }

            // A constructor to make a new Adventurer object with a given name
            public Adventurer(string name)
            {
                Name = name;
                Awesomeness = 50;
            }


            // This method returns a string that describes the Adventurer's status
            // Note one way to describe what this method does is:
            //   it transforms the Awesomeness integer into a status string
            public string GetAdventurerStatus()
            {
                string status = "okay";
                if (Awesomeness >= 75)
                {
                    status = "great";
                }
                else if (Awesomeness < 25 && Awesomeness >= 10)
                {
                    status = "not so good";
                }
                else if (Awesomeness < 10 && Awesomeness > 0)
                {
                    status = "barely hanging on";
                }
                else if (Awesomeness <= 0)
                {
                    status = "not gonna make it";
                }

                return $"Adventurer, {Name}, is {status}";
            }
        }
    }
    ```

1. Read over the code. Imagine what the code will do when it runs. Write some notes about what you think will happen.
1. Run the program. Does it do what you expected?

> **NOTE:** At the end of each phase you should Add, Commit and Push to GitHub.

### Phase 2

Our adventurer is currently named "Jack". Studies show that "Jack" is probably not the application user's name. Update the code to prompt the user for their name and pass that name to the `Adventurer` constructor when creating the new `Adventurer` object.

### Phase 3

This quest is so much fun that everyone is sure to want to do it more than once. Update the code to ask the user if they'd like to repeat the quest after the it has been completed. If the user says "yes", start the quest over. Otherwise, end the program.

### Phase 4

I don't know if you noticed, but our adventurer is naked. What happened to all that talk about a brightly colored robe and shiny hat?

In this phase we'll add the robe.

1. Create new file called `Robe.cs`.
1. Inside the file define a `Robe` class.
1. The class should have the following mutable properties.
    * Colors - a list of strings to hold the colors of the robe
    * Length - an integer describing the length of the robe in inches
1. The class should not contain any methods or constructors.
1. Add a new immutable property to the `Adventurer` class called `ColorfulRobe`. The type of this property should be `Robe`.
1. Add a new constructor parameter to the `Adventurer` class to accept a `Robe` and to set the `ColorfulRobe` property.
1. Add a new method to the `Adventurer` class called `GetDescription`. This method should return a string that contains the adventurer's name and a description of their robe.
1. In `Program.cs` create a new instance of the `Robe` class and set its properties.
1. Pass the new `Robe` into the constructor of the `Adventurer`.
1. Before the adventurer starts their challenge, call the `GetDescription` method and print the results to the console.

### Phase 5

Let's cover that hatless head.

1. Create a new class called `Hat` in its own file.
1. Add a mutable integer property called `ShininessLevel` to indicate how shiny the hat is.
1. Add a computed string property called `ShininessDescription` to return a text description of the hat's shininess according to the following rules.
    * A `ShininessLevel` less than `2` should be "dull"
    * A `ShininessLevel` between `2` and `5` should be "noticeable"
    * A `ShininessLevel` between `6` and `9` should be "bright"
    * A `ShininessLevel` greater than `9` should be "blinding"
1. Add a `Hat` property and constructor parameter to the `Adventurer` class.
1. Update the `Adventurer`'s `GetDescription` method to include the description of the hat.
1. Update the `Program.cs` file to create a `Hat` and pass it to the `Adventurer`'s constructor.

### Phase 6

When you think about it, this isn't much of a quest, is it? A quest is supposed to be **for** something, right?

Let's create a prize to give our adventurer at the end of the quest. Of course the value of the prize should reflect the awesomeness of the adventurer.

1. Create a new class called `Prize`.
1. Create a private field in the class called `_text` to contain a textual description of the prize.
1. Create a constructor in the class that takes a `text` parameter and uses it to set the `_text` field.
1. Create a method in the class called `ShowPrize`.
    * The method should accept an `Adventurer` as a parameter.
    * If the adventurer's `Awesomeness` is greater than zero, write the `_text` field to the console the same number of times as the value of the `Awesomeness` property.
    * If the adventurer's `Awesomeness` is zero or less than zero, write a message of pity to the console.
1. In `Program.cs` create an instance of the `Prize`.
1. At the end of the quest (before you ask if the user wants to repeat the quest) call the `ShowPrize` method.

### Phase 7

Let's make the challenges a little more interesting. Add 2 to 5 more challenges to the program and then add code to randomly select 5 challenges for our adventurer to face. If the user chooses to repeat the quest another random selection of challenges should happen.

### Phase 8

Add code to record the number of successful challenges the adventurer completes during a quest. If the user chooses to repeat the quest, multiply this number by 10 and add it do the initial `Awesomeness` of the adventurer on their next quest.
