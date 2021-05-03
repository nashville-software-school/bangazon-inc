# C# for the JavaScript Developer

Learning your first programming language is hard. It's hard because you're not only learning a language, but you're also learning _how to program_.

It is often said that learning a second programming language is easier because you now have the mental model of programming and how programming languages work. Now you can transfer the knowledge from the language you know to the language you're learning.

---

## Variables

#### JavaScript

```js
const theAnswer = 42;
const olympicScore = 9.1;
const isFunny = true;
const insult = "You are unpleasant";
const aDate = new Date(1989, 6, 2);
const activities = ["bowling", "jumping on the bed", "sword swallowing"];
```

#### C#

```cs
int theAnswer = 42;
double olympicScore = 9.1;
bool isFunny = true;
string insult = "You are unpleasant";
DateTime aDate = new DateTime(1989, 7, 2);
List<string> activities = new List<string>()
{
    "bowling", "jumping on the bed", "sword swallowing"
};
```

## `if` statement

#### JavaScript

```js
const numHats = 50;
if (numHats > 10) {
  console.log("Why do you have so many hats?");
} else if (numHats <= 10 && numHats >= 2) {
  console.log("You have a reasonable number of hats.");
} else {
  console.log("You need more hats!");
}
```

#### C#

```cs
int numHats = 50;
if (numHats > 10)
{
    Console.WriteLine("Why do you have so many hats?");
}
else if (numHats <= 10 && numHats >= 2)
{
    Console.WriteLine("You have a reasonable number of hats.");
}
else
{
    Console.WriteLine("You need more hats!");
}
```

## `for` loop

#### JavaScript

```js
for (let i = 0; i < 20; i++) {
  console.log(`The number is ${i}`);
}
```

#### C#

```cs
for (int i = 0; i < 20; i++)
{
    Console.WriteLine($"The number is {i}");
}
```

## `foreach` loop

#### JavaScript

```js
const foods = ["Brussels Sprout", "Toast", "Steak", "Tomato"];
for (let food of foods) {
  console.log(`You can eat ${food}.`);
}
```

#### C#

```cs
List<string> foods = new List<string>()
{
    "Brussels Sprout", "Toast", "Steak", "Tomato"
};
foreach (string food in foods)
{
    Console.WriteLine($"You can eat {food}.");
}
```

## `while` loop

#### JavaScript

```js
while (true) {
  console.log("Never stop looping");
}
```

#### C#

```cs
while (true)
{
    Console.WriteLine("Never stop looping");
}
```

## Classes and Objects

#### JavaScript

##### Declare a `createPerson` factory function

A _"factory function"_ is a function that creates a new object using the values passed into it as parameters.

```js
const createPerson = (name, birthday, hobbies) => {
  return {
    name: name,
    birthday: birthday,
    hobbies: hobbies,
    addHobby: (hobby) => {
      this.hobbies.push(hobby);
    },
  };
};
```

##### Create a `person` object

```cs
const lulu = createPerson(
    "Lulu",
    new Date(1934, 1, 14),
    ["Knitting", "Break dancing", "Lion taming"]
);

// Changing the name property
lulu.name = "Lulu Rodriguez";

// Calling the addHobby method
lulu.addHobby("World domination");
```

> **NOTE:** A factory function is just one way of defining an
> object in JavaScript. There are many other ways.

#### C#

##### Declare a `Person` class

```cs
public class Person
{
    public string Name { get; set; }
    public DateTime BirthDay { get; set; }
    public List<string> Hobbies { get; set; }

    public Person(string name, DateTime birthday, List<string> hobbies)
    {
        this.Name = name;
        this.Birthday = birthday;
        this.Hobbies = hobbies;
    }

    public void AddHobby(string hobby)
    {
        Hobbies.Add(hobby);
    }
}
```

##### Create a `Person` object

```cs
Person lulu = new Person (
    "Lulu",
    new DateTime(1934, 2, 14),
    new List<string>() { "Knitting", "Break dancing", "Lion taming" }
);

// Changing the Name property
lulu.Name = "Lulu Rodriguez";

// Calling the AddHobby method
lulu.AddHobby("World domination");
```

## Lists and Arrays

#### JavaScript

```js
const ronny = createPerson("Ronny", new Date(2000, 3, 1), ["wrastlin'"]);
const june = createPerson("June", new Date(1988, 9, 31), [
  "carpentry",
  "animal husbandry",
]);
const selam = createPerson("Selam", new Date(1994, 4, 22), [
  "opera",
  "juggling",
  "skeet shooting",
]);

const people = [ronny, selam];
people.push(june);

const firstPerson = people[0];
```

#### C#

```cs
Person ronny = new Person("Ronny", new DateTime(2000, 4, 1), new List<string> { "wrastlin'"} );
Person june = new Person("June", new DateTime(1988, 10, 31), new List<string> { "carpentry", "animal husbandry"} );
Person selam = new Person("Selam", new DateTime(1994, 5, 22), new List<string> { "opera", "juggling", "skeet shooting"} );

List<Person> people = new List<Person>() { ronny, selam };
people.Add(june);

Person firstPerson = people[0];
```

## Dictionaries

#### JavaScript

```js
const bowlingScores = {
  Bubba: 40,
  Louis: 120,
  "Mary Jane": 200,
};

console.log(bowlingScores["Bubba"]);
```

#### C#

```cs
Dictionary<string, int> bowlingScores = new Dictionary<string, int>()
{
    { "Bubba", 40 },
    { "Louis", 120 },
    { "Mary Jane", 200 }
};

Console.WriteLine(bowlingScores["Bubba"]);
```

## `using` libraries

#### JavaScript

```js
import React, { useState } from "react";
import { Route } from "react-router-dom";
```

#### C#

```cs
using System;
using System.Collections.Generic;
using System.Linq;
```

## List and Array Methods

#### JavaScript

```js
const numbers = [100, 32, 98, 4, 1, 22, 73, 8];
const small = numbers.filter((n) => n < 10);
const even = numbers.filter((n) => n % 2 === 0);

const words = [ "do", "you", "understand", "the", "words", "coming", "out", "of", "my", "mouth?", ];
const yelling = words.map((w) => w.ToUpperCase());
const sentence = yelling.join(" ");

const people = getPeopleFromSomeplace();
const names = people.map((p) => p.name);
const person = people.find((p) => p.Name === "Selam");
const isAnyoneNamedPhil = people.some((p) => p.Name === "Phil");
const doesEveryoneHaveAHobby = people.every((p) => p.Hobbies.length > 0);
```

#### C#

```cs
using System.Linq;

// ...

List<int> numbers = new List<int>() { 100, 32, 98, 4, 1, 22, 73, 8 };
List<int> small = numbers.Where(n => n < 10).ToList();
List<int> even = numbers.Where(n => n % 2 == 0).ToList();

List<string> words = new List<string>() { "do", "you", "understand", "the", "words", "coming", "out", "of", "my", "mouth?" };
List<string> yelling = words.Select(w => w.ToUpper());
string sentence = string.Join(" ", yelling);

List<Person> people = GetPeopleFromSomeplace();
List<string> names = people.Select(p => p.Name).ToList();
Person person = people.First(p => p.Name == "Selam");
bool isAnyoneNamedPhil = people.Any(p => p.Name == "Phil");
bool doesEveryoneHaveAHobby = people.All(p => p.Hobbies.Count > 0);
```

## `try` / `catch`

#### JavaScript

```js
try {
  const age = getAgeFromSomeplace();
  if (age < 0) {
    throw new Error("You can't be younger than zero, no matter how hard you try.");
  }
} catch (err) {
  console.log(err.message);
}
```

#### C#

```cs
try
{
    int age = GetAgeFromSomeplace();
    if (age < 0)
    {
        throw new Exception("You can't be younger than zero, no matter how hard you try.");
    }
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
```
