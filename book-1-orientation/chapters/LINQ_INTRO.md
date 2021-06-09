# Dealing with Data

As you know a major aspect of software development is the searching, filtering and transformation of data. We often use the umbrella term, _query_, to encompass this broad concept. In C# applications it's common to invoke SQL to query data directly in the database, but it's sometimes the case that our data isn't in a database. For example, we may retrieve data from a web API or from a text file. How do we handle these situations?

> **NOTE:** We haven't, yet, discussed mixing SQL into our C# applications. We'll do that soon, but for now just know that it's possible. This chapter will discuss tools for handling data when SQL is not an option.

## Collections of Objects

Before we can talk about querying data, we should first define what we mean by "data".

Put simply when we talk about data we are usually talking about collections of objects, where each object is a collection of properties that describe a particular entity. For example, if we were to build an application to help manage our creepy garden gnome collection, it might contain a list of garden gnome objects in which each object has an `id`, a `name`, a `description` and a `note about the blood sacrifices it requires in order to remain docile`.

In JavaScript we use arrays to contain data. In C# we usually use `List`s. JavaScript arrays provide a variety of methods to help us manipulate data. In C# we use _LINQ_.

## LINQ

LINQ _(Language-INtegrated Query)_ is a set of methods defined in the `System.Linq` namespace that provide a concise syntax for searching, filtering and transforming collections of objects.

### Example

Imagine we have the following `Person` class.

> Person.cs

```cs
public class Person
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public int Age { get; set; }
}
```

Elsewhere in our code we get a `List<Person>` and we'd like to query that list to get the full names of everyone in their 20s.

> SomeOtherCode.cs

```cs
// It doesn't matter where the people come from.
List<Person> people = dataGetter.GetSomePeople();

List<string> twentySomethings =
    people
        .Where(p => p.Age >= 20 && p.Age < 30)
        .Select(p => $"{p.FirstName} {p.LastName}")
        .ToList();
```

The above code is probably not _too_ cryptic, but it might help to see how we'd write equivalent code in JavaScript.

> SomeCode.js

```js
const people = getSomePeople();

const twentySomethings = 
    people
        .filter(p => p.age >= 20 && p.age < 30)
        .map(p => `${p.firstName} ${p.lastName}`);
```

As you can see there's a lot of similarities. We might say the _shape_ of the code is the same in both the C# and JavaScript versions. This is an important demonstration of the similarities between languages, but for now let's focus on the differences.

* Variables in C# require explicit types
* The C# code uses a method called `Where` instead of `filter`
* The C# code uses a method called `Select` instead of `map`
* The C# code calls a `ToList()` method, and there is no need for such a method in JavaScript

## LINQ Methods

There are a _lot_ of LINQ methods. Some are more commonly used that others, and some are pretty complex and hard to understand. We'll focus our attention on the more common and relatively simple methods.

> **NOTE:** The examples below will use the `people` list we defined above.  

> **NOTE:** Most of the methods listed below have several _overloads_ - meaning there are alternative versions of the method that are not described here.

### Finding and Filtering

#### FirstOrDefault()

This method returns the first instance of the object that matches a given condition.

If no object matches it returns the default value for the type. This is usually `null`, but would be `0` for numbers, `false` for booleans, etc...

##### Example

```cs
Person carol = people.FirstOrDefault(p => p.FirstName == 'Carol');
```

##### JavaScript Equivalent

Find()

---

#### Skip

This method skips a specified number of items in the collection and then returns the rest.

##### Example

```cs
List<Person> skipFirstFive = people.Skip(5).ToList();
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Take

This method returns the given number of objects from the collection starting at the beginning.

##### Example

```cs
List<Person> firstThree = people.Take(3).ToList();
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Where

This method returns all objects that match a given condition.

##### Example

```cs
List<Person> people.Where(p => p.Age > 18).ToList();
```

##### JavaScript Equivalent

filter()

---

### Transforming Data

#### Select

This method converts a collection of objects of one type into a collection of objects of another type.

##### Example

```cs
List<int> ages = people.Select(p => p.Age).ToList();
```

##### JavaScript Equivalent

map()

---

### Sorting and Reversing

#### OrderBy

This method returns a new collection of objects sorted by the given expression.

##### Example

```cs
List<People> sortedByLastName = people.OrderBy(p => p.LastName).ToList();
```

##### JavaScript Equivalent

sort()

---

#### OrderByDescending

This method is like `OrderBy`, but sorts in the opposite direction.

##### Example

```cs
List<People> sortedByAgeOldestFirst = people.OrderByDescending(p => p.Age).ToList();
```

##### JavaScript Equivalent

sort()

### Inspecting a Collection

#### All

This method returns true if every object meets a given condition.

##### Example

```cs
bool areAllAdults = people.All(p => p.Age >= 18);
```

##### JavaScript Equivalent

every()

---

#### Any

This method returns true if at least one of the objects meets a given condition.

##### Example

```cs
bool hasSmith = people.Any(p => p.LastName == "Smith");
```

##### JavaScript Equivalent

some()

---

#### Contains

This method returns true if the collection contains the given object.

##### Example

```cs
List<int> ages = people.Select(p => p.Age).ToList();
bool hasFortyTwo = ages.Contains(42);
```

##### JavaScript Equivalent

includes()

---

### Numbers and Math

#### Average

This method finds the average value of a given property in a collection.

##### Example

```cs
double avgAge = people.Average(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Max

This method finds the maximum value of the given property within the collection.

##### Example

```cs
int maxAge = people.Max(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Min

This method finds the minimum value of the given property within the collection.

##### Example

```cs
int maxAge = people.Min(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

#### Sum

This method sums the values of given property in each object.

##### Example

```cs
int totalAge = people.Sum(p => p.Age);
```

##### JavaScript Equivalent

_there is no JavaScript equivalent_

---

## IEnumerable

In the above examples you probably noticed calls to a `ToList()` method chained after the call to many of LINQ methods. It may not surprise you to learn that this method returns a `List`, but it might surprise you that we have to call it all over the place.

In JavaScript many of the array method - such as `map()` and `filter()` - return an array, so you might expect LINQ methods - such as `Select()` and `Where()` - to return a `List`. However, this is NOT the case.

The LINQ methods that return a collection of items always return an `IEnumerable` and do NOT return a `List`.

So what is this `IEnumerable` thing? As the first letter of the name implies `IEnumerable` is an interface. It is implemented by the collections provided by .NET, and so is used as a central place to place LINQ methods.

If the above paragraph seems vague and technical to you, that's because it's vague and technical. The good news is you don't really need to understand it in order to get the benefits of LINQ. **All you need to know is when you need a list call the `ToList()` method.**

## LINQ's Query Syntax

You may have noticed that the names of many of the LINQ methods match keywords in SQL. This is no accident. In 2007 when LINQ was added to .NET it was a very new and confusing concept for many developers. LINQ's creators thought it would be easier to grasp if developers could associate it with the SQL concepts they already understood. 

> **NOTE:** Whether this was a good idea is debatable.

It turns out they didn't stop at choosing SQL inspired names for LINQ methods. They also decided to make an alternative and _completely different_ syntax for LINQ to make it seem even more SQL-like. This syntax is usually called the _query syntax_.

Here's the example from the beginning of the chapter re-written using the query syntax.

```cs
List<Person> people = dataGetter.GetSomePeople();

List<string> twentySomethings = (
        from p in people
        where p.Age >= 20 && p.Age < 30
        select $"{p.FirstName} {p.LastName}"
    ).ToList();
```

As you can see the query syntax looks a bit like a jumbled version of SQL...sorta...

We will not be using the query syntax in this course, but you will likely encounter it online, and you may encounter it on the job.

> **NOTE:** The syntax we've used throughout the bulk of this chapter - and will use throughout the course - is called the _method syntax_.

---

## Practice: 90s TV

This repo contains LINQ practice exercises.

https://github.com/nashville-software-school/NinetiesTV

> **NOTE:** Make sure you create your own repo and change the remote origin before pushing your code to Github.

---

## Additional Resources

### Visualizing LINQ

Here's a visual representation of some LINQ methods. Some people find it useful even if the title is a bit insulting.

> **NOTE:** This image refers to more methods that we covered in ths chapter.

![LINQ Methods](./assets/linq.jpg)

### Intro to LINQ Videos on YouTube

https://www.youtube.com/watch?v=p5myHVOtmiU

### 101 LINQ Samples

https://docs.microsoft.com/en-us/samples/dotnet/try-samples/101-linq-samples/

