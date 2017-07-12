# Testing the Animals

> **Note:** This code exercise will be part of a live coding session with the instructor. Feel free to try it on your own beforehand and come to class with questions, or just wait until live coding starts.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/animals/Animals && cd $_
dotnet new console
dotnet restore
mkdir ../Animals.Tests && cd $_
dotnet new xunit
dotnet add reference ../Animals/Animals.csproj 
dotnet restore
cd .. && code .
```

## Overview

As a team, we'll be building unit test coverage for all the functionality of the code in the `Animal` program. We'll discuss how writing tests often affect the implementation code, and how to think bout covering edge cases in your test suit.

## Instructions

Write test cases to verify the I/O of the following methods of `Animal` and `Dog`.

1. In the test class' constructor method, create an instance of `Animal` and `Dog`.
1. Animal object has the correct `Name` property.
1. Set a species and verify that the object property of `Species` has the correct value.
1. Invoking the `Walk()` method set the correct speed on the both objects.
1. The animal object is an instance of `Animal`.
1. The dog object is an instance of `Dog`.
