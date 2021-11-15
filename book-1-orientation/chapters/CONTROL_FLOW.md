# Control Flow

---

## Objectives

After completing this lesson you should be able to:

1. Informally define "control flow"
1. List three types of loops in C#
1. Recognize an `if` statement
1. Recognize a `while` loop
1. Recognize a `for` loop
1. Recognize a `foreach` loop

---

Control flow _(also known as "signal flow")_ refers to the order in which statements and expressions execute in our code. It's basically the order of "stuff that happens" in our program.

## Top-Down

In most situations our code executes from top to bottom _(top-down)_.

In this example we create the `a` variable, assign it a value and then use it to create the `b` variable.

```cs
int a;
a = 2;
int b = a + 40;
```

## Right-Left

On a single line of code, it is often useful to think of code executing from right to left.

In the code below, the `data.GetUserById()` method runs first to get a user with `id` of 100, then that user is passed to the `messageGenerator.GetMessageForUser()` method get a message, finally, the `message` variable is created and assigned the value of the message;

```cs
string message = messageGenerator.GetMessageForUser(data.GetUserById(100));
```

> **NOTE:** This is a _rule of thumb_ and not always the case.

## Conditionals

Sometimes we need to ask questions within our code and do different things depending on the answer. In C# we use an `if` statement for this purpose.

```cs
int age = 12;
if (age >= 18)
{
    Console.WriteLine("Can (and should) vote");
}
else
{
    Console.WriteLine("Cannot vote, sorry");
}
```

Conditional statements create "branches" in our control flow. Sometimes the code takes the `true` branch and other times it takes the `false` branch.

> **NOTE:** Unlike JavaScript, in C# the `if` condition must evaluate to a boolean value.

## Looping and Iteration

When we want to do the same thing over and over again, we need a loop.

There are three types of loops in C#.

### For Loop

Use a `for` loop to iterate some number of times.

```cs
for (int i = 0; i < 10; i++)
{
    Console.WriteLine($"i is {i}");
}
```

### Foreach Loop

Use a `foreach` loop to iterate over a collection, such as a list.

```cs
List<Person> people = data.GetAllPeople();
foreach (Person p in people)
{
    Console.WriteLine($"Hi, {p.FirstName} {p.LastName}!");
}
```

### While Loop

A `while` loop will continue until it's condition is `false`.

```cs
Console.Write("Should we continue? (y/n) ");
string input = Console.ReadLine();

while (input == "y")
{
    Console.WriteLine("We're continuing!");
    Console.Write("Should we continue? (y/n) ");
    input = Console.ReadLine();
}
```
