# Unit Testing

The end of this sentence contains the most important thing you need to know about unit testing - you won't understand it until you do it. We can't teach it to you.

Luckily, we can teach you the mechanics of it, so here we go.

## Setup

You need to create two projects. One to contain the business logic for your application, and a sibling project to contain the code that tests your business logic and makes sure no one else checks in code that breaks things.

Follow these steps.

```
mkdir -p ~/workspace/csharp/exercises/tree-farm/TreeFarm && cd $_
dotnet new console
dotnet restore
mkdir ../TreeFarm.Tests && cd $_
dotnet new xunit
dotnet add reference ../TreeFarm/TreeFarm.csproj 
dotnet restore
cd .. && code .
```

## References

* Video: [Unit testing: How to get your team started](https://www.youtube.com/watch?v=TWBDa5dqrl8)
* Article: [Unit testing in .NET Core using dotnet test and xUnit](https://docs.microsoft.com/en-us/dotnet/core/testing/unit-testing-with-dotnet-test)
* Article: [Getting started with xUnit.net](https://xunit.github.io/docs/getting-started-dotnet-core.html)

## Quick Overview

Software that is not tested is broken by default. Unit testing is one type of testing that software developers use to test the output of functions based on one, or more, input values. It ensures the quality of the code increases, modularity is always enforced, and that no, one, developer can inadvertantly make a disastrous error while changing existing code and have it pushed to production.

## Defining a New Program

We've been contracted to build a simple command line application for a tree farm. Here's what they told us they would like the software to do.

1. As a groundskeeper, in order to keep the best trees available to customers, I need to be able to move the tree closer to the parking lot.
1. As a groundskeeper, in order to manage the movement of the correct trees, I need to be able to see the history of all tree movements and who moved it.
1. As the business owner, in order to always know what I have in stock, I need to be able to add new trees to the system, and remove them when they are sold.
1. As the contract arborist, in order track the growth and health of the trees, I need to specify how much a tree has grown every three months, and see the growth history of each tree.

## The Basic Methods

So what are the behaviors of the system?

1. Adding a tree to the farm.
1. Removing a tree from the farm.
1. Moving a tree in the farm.
1. Specifying the growth of a tree in the farm.
1. Able to choose an individual tree.
1. Able to list all trees.
1. Showing all options to the user.

Let's build some basic code for these features. We will start with behaviors and properties of a Tree.

```cs
namespace TreeFarm
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
    public class Tree
    {
        public double Height { get; set; } = 0;
        public string Location { get; set; } = "";
        public string Type { get; set; } = "";

        public string Move (string newLocation)
        {
            if (newLocation != this.Location)
            {
                this.Location = newLocation;
            }

            return this.Location;
        }

        public double Grow (double growth)
        {
            if (growth > 0.0)
            {
                this.Height += growth;
            }

            return this.Height;
        }
    }
}
```

Both of the methods on a Tree instance take an input value, and return a value. These are mechanisms that we can verify with unit tests.

In our test project, rename the `UnitTest1.cs` as `TreeFarm_TreeShould.cs`. Place the following code in it.

```cs
using System;
using Xunit;

namespace TreeFarm.Tests
{
    public class TreeShould
    {
        private Tree _tree;

        public TreeShould()
        {
            _tree = new Tree() { Height = 4.2, Location = "A3", Type = "Oak" };
        }

        [Fact]
        public void ChangeLocation()
        {
            // Given this input to the method
            string newLocation = _tree.Move("B3");

            // We are asserting that the output should be this
            Assert.Equal(newLocation, "B3");
        }

        [Fact]
        public void Grow()
        {
            // Given this input to the method
            double newOakHeight = _tree.Grow(0.3);

            // We are asserting that the output should be this
            Assert.Equal(newOakHeight, 4.5);

            // Given this input to the method
            newOakHeight = _tree.Grow(0.2);

            // We are asserting that the output should be this
            Assert.Equal(newOakHeight, 4.7);
        }
    }
}
```

With the assertions that we've made, someone could actually really screw up the code and our test would never catch it. They could modify the `Move()` method to `return "B3";`. That would make the original unit test pass, and it would get released to production.

To avoid that, you can specify that the same test be run with different inputs. Modify the `ChangeLocation` test with the following code.

```cs
[Theory]
[InlineData("D4")]
[InlineData("F1")]
[InlineData("E2")]
[InlineData("E5")]
public void ChangeLocation(string value)
{
    // Given this input to the method
    string newLocation = _tree.Move(value);

    // We are asserting that the output should be this
    Assert.Equal(newLocation, value);
}
```

Instead of a `[Fact]`, it's now a `[Theory]` which will run this method 4 times, with each of the `InlineData` values pass in as the `value` parameter. This will prevent a developer from returning a single value that gets a simple unit test from passing.


> **Note:** From this point, your instructor will have a  live-coding session where the team will walk you through the process of writing some morecode for the application, and then authoring tests to verify I/O.

