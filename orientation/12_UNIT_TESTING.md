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

## Writing Tests for a New Program
