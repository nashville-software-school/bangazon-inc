# Bangazon Inc.

## The Personal E-Commerce Platform

Bangazon Inc. welcomes you to the team. You've been selected from a deep pool of candidates to help build the next, disruptive online platform. Our goal is to become the most personalized, and most powerful commericial platform for individuals all around the globe.

You are needed to make that happen.

In order to become a profitable, and sustainable organization, we need you to build all of the technology and tooling for the company.

## Orientation

Your first two weeks on the job will be you orientation to the technical languages that you'll be using, and to the processes and procedures that you will need to follow to ensure high communication and high productivity for your team.

1. Installation of required tools.
1. Introduction to the language.
1. Concepts of sustainable, scalable, object-oriented software development.
1. Test driven development
1. Overview of server-side development ecosystem
1. How the Internet works
1. Inheritance, composition, and aggregation
1. Entity relationships
1. Structured Query Language (SQL)
1. Querying databases with LINQ


At the end of your orientation, your management team will determine which Development Team you will be assigned to for the next three months.

## Platform Development

You will work on four different [Sprints](https://www.scruminc.com/sprint/) while you build the products that Bangazon Corporation needs in order to operate as a modern business. On each of these sprints, you will build features that your product owner has defined in the [Backlog](http://www.mountaingoatsoftware.com/agile/scrum/scrum-tools/product-backlog).

Your management team will ensure that you have the proper training in the skills, concepts, and tools needed to complete the projects, and then you will fulfill the requirements for the project until you are done, as defined in the [Bangazon Definition of Done](https://github.com/nashville-software-school/bangazon-inc/blob/master/EMPLOYEE_HANDBOOK.md#definition-of-done).

# Learning Objectives

While you are building out the Bangazon Platform, your leadership team will ensure that the following foundational skills are developed by each team, and by each individual on the team.

![Learning objectives](./learning-objectives.png)

# The Big 3 C# Differences from JavaScript

## The Compiler Must Know the Type of Everything

When your C# code is compiled into a executable program, the compiler must know the type of every variable before it will allow the code to be compiled. This is **very** different from JavaScript, in which a variable's type can change at any time.

```js
// Initial type of the variable `student` is string
let student = "Bob"

// In JavaScript, you're allowed to change the value to anything
student = ["Bob", "Parson"]
```

The C# compiler will not allow this. If you attempt to run the following code...

```cs
// The variable must be typed specifically to hold a string
string student = "Bob";

// I attempt to reassign student to a different kind of thing
student = new List<string>();
```

You get the following message back from the compiler.

```
Program.cs(12,19): error CS0029: Cannot implicitly convert type 'System.Collections.Generic.List<string>' to 'string' 

The build failed. Please fix the build errors and run again.
```

## Creating Custom Variable Types with Classes

In JavaScript, you used all of the built-in type supported by the interpreter.

* integer
* string
* null
* undefined
* boolean
* object

You could combine them in all kinds of interesting ways and form very complex objects, or collections of objects, but in the end, everything was one of those types.

In C# you can define your own custom variable types with a class. Here's a simple custom type that defines the properties and methods of a Tree object.

```cs
public class Tree
{
    public string Type { get; set; } = "";
    public int LeafCount { get; set; } = 0;
    public double Size { get; set; } = 0.0;

    public void Grow (double changeInHeight)
    {
        this.Size = this.Size + changeInHeight;
    }
}
```

Once this custom type has been defined, it can be used for a variable.

```cs
// Create object, then set each property
Tree birch = new Tree();
birch.Type = "Birch";
birch.LeafCount = 892,
birch.Size = 10.1

// Create object and set properties all at once
Tree oak = new Tree(){
    Type = "Oak",
    LeafCount = 307,
    Size = 5.2
};
```

## Everything Must be in a Class

In JavaScript, you could just create a file, write some simple code, and the include it in your HTML with a `<script>` tag. Well, not so fast, cowboy.

In C# all code must be contained in a class. Even the simplest console application requires a default class in order to run.

```cs
using System;

public class Program
{
    public static void Main() {
        Console.WriteLine("Hello, world");
    }
}
```
