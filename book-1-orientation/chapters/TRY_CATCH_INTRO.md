# Exceptions and Try/Catch

## Exceptions

In software sometimes things don't go as planned. Maybe the database you want to read from isn't available. Maybe that list you want to add something to wasn't instantiated.

Here's simple Calculator class...

```csharp
public class Calculator
{
    public int Divide(int a, int b)
    {
        return a / b;
    }
    // ...other methods (e.g. Add(), Subtract(), Multiply())...
}
```

...let's suppose another programmer tries doing something mischievous with it, such as...

```csharp
Calculator calculator = new Calculator();
int answer = calculator.Divide(42, 0);
Console.WriteLine($"The answer is {answer}");
```

When the code is run, we'll see something like this:

```
Unhandled Exception: System.DivideByZeroException: Attempted to divide by zero.
   at Example.Calculator.Divide(Int32 a, Int32 b) in /home/tgwtg/programming/nss/Example/Program.cs:line 11
   at Example.Program.Main(String[] args) in /home/tgwtg/programming/nss/Example/Program.cs:line 20
```

Since dividing by zero is a no-no, our code has _thrown an **exception**_.

An exception is thrown when something abnormal happens in a program. You might say it happens in "exceptional circumstances".


## Try/Catch

Fortunately, C# gives us a tool for handling exceptions. We can `try` code that might throw an exception and `catch` an exception that is thrown.

We could rewrite the code above to `try` calling `Divide()` and `catch` the exception.

```csharp
try
{
    Calculator calculator = new Calculator();
    int answer = calculator.Divide(42, 0);
    Console.WriteLine($"The answer is {answer}");
}
catch (DivideByZeroException ex)
{
    Console.WriteLine("Something went wrong!");
}
```

When we run this code we see this message in the Console
```
Something went wrong!
```


## Exceptions Stop Normal Program Execution

Take another look at the example above. notice the line after the call to `Divide()`

```csharp
Console.WriteLine($"The answer is {answer}");
```

This line is never executed.

Why? Because the line above it resulted in an exception. When an exception occurs, the program has moved into an "exceptional state". C# knows something has gone wrong, but it doesn't know what to do about it. It won't just keep going as if nothing bad happened because that might lead to even worse things.

So what does C# do? It stops running the code at the place where the exception occurred and starts looking for a `try/catch` block to handle the exception. If it finds a `try/catch` block, it will run the code in the `catch` block. If it doesn't, it will end the program and display an error message that describes the exception.

## Error Messages and Stacktraces

Now let's take another look at the error message we saw earlier.

```
Unhandled Exception: System.DivideByZeroException: Attempted to divide by zero.
   at Example.Calculator.Divide(Int32 a, Int32 b) in /home/tgwtg/programming/nss/Example/Program.cs:line 11
   at Example.Program.Main(String[] args) in /home/tgwtg/programming/nss/Example/Program.cs:line 20
```

You'll notice that this error gives you quite a lot of information.

The first line tells you the name of the exception, `System.DivideByZeroException`, and also gives you a brief description of the error, `Attempted to divide by zero.`

The next few lines help you find where the error occurred in your code. This is known as a _stacktrace_. The topmost line tells you the method, file and line number where the exception was thrown. In our case, it tells us the exception was thrown in the `Example.Calculator.Divide` method. The next line tells you where in your code the `Divide` method was called.

## Handle _Expected Exceptions_

An _expected exception_ is one that you can anticipate happening - it's something that you know _might_ happen.

For example the following code makes no sense.

```csharp
try
{
    List<int> intList = new List<int>();
    intList.Add(42);
}
catch (DivideByZeroException ex)
{
    Console.WriteLine("Adding to a list will never divide by zero");
}
```

The important thing to remember is that `try/catch` blocks are not band-aids to wrap around code that isn't behaving. You should only handle Exceptions that you know may happen AND that you know how to handle.

## A Larger Example

Consider the following program.

```csharp
using System;
using System.Collections.Generic;

namespace TryCatch
{
    class Program
    {
        static void Main(string[] args)
        {
            Company chickenShack = new Company() { Name = "Greasy Pete's Chicken Shack" };
            chickenShack.AddEmployee(new Employee() { FirstName = "Pete",  LastName = "Shackleton" });
            chickenShack.AddEmployee(new Employee() { FirstName = "Molly", LastName = "Frycook" });
            chickenShack.AddEmployee(new Employee() { FirstName = "Pat",   LastName = "Buttersmith" });

            List<int> employeeIds = new List<int>() { 0, 11, 2 };
            foreach(int id in employeeIds)
            {
                Employee employee = chickenShack.GetEmployeeById(id);
                Console.WriteLine($"Employee #{id} is {employee.FirstName} {employee.LastName}.");
            }
        }
    }

    public class Company
    {
        private List<Employee> _employees = new List<Employee>();
        public string Name { get; set; }

        public void AddEmployee(Employee employee)
        {
            _employees.Add(employee);
        }

        public Employee GetEmployeeById(int id)
        {
            return _employees[id];
        }
    }

    public class Employee
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
```

When we run this program, we see the following in the Console.

```
Employee #0 is Pete Shackleton.

Unhandled Exception: System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.Collections.Generic.List`1.get_Item(Int32 index)
   at TryCatch.Company.GetEmployeeById(Int32 id) in /home/tgwtg/programming/nss/trycatch/Program.cs:line 89
   at TryCatch.Program.Main(String[] args) in /home/tgwtg/programming/nss/trycatch/Program.cs:line 40
```

We see the output for Employee #0, but then the program ends due to an exception.

What caused the exception? Look closely at this line:

```csharp
List<int> employeeIds = new List<int>() { 0, 11, 2 };
```

The `employeeIds` is a list of employee IDs. The ID of an employee is the _index_ of that employee in the company's `_employees` list. However, notice the second element in `employeeIds` is `11`, but the only valid indexes in the company's `_employees` list are `0, 1, and 2`. This means when we look for an employee with ID `11`, we are looking for an employee that doesn't exist...therefor, we get an exception.

<br>

Let's change the code to handle the exception.

```csharp
try
{
    List<int> employeeIds = new List<int>() { 0, 11, 2 };
    foreach(int id in employeeIds)
    {
        Employee employee = chickenShack.GetEmployeeById(id);
        Console.WriteLine($"Employee #{id} is {employee.FirstName} {employee.LastName}.");
    }
}
catch (ArgumentOutOfRangeException ex)
{
    Console.WriteLine("Something went wrong while finding employees");
}
```

Now we see

```
Employee #0 is Pete Shackleton.
Something went wrong while finding employees
```

We wrapped our code in a `try/catch` block and now our program has been improved. Our users will no longer see a scary error message.

But we can do better.

```csharp
List<int> employeeIds = new List<int>() { 0, 11, 2 };
foreach(int id in employeeIds)
{
    try
    {
        Employee employee = chickenShack.GetEmployeeById(id);
        Console.WriteLine($"Employee #{id} is {employee.FirstName} {employee.LastName}.");
    }
    catch (ArgumentOutOfRangeException ex)
    {
        Console.WriteLine($"Employee #{id} was not found in the company.");
    }
}
```

Now when we run the program we see

```
Employee #0 is Pete Shackleton.
Employee #11 was not found in the company.
Employee #2 is Pat Buttersmith.
```

By placing our `try/catch` block inside the loop, we are able to continue looping even after one of our employee lookups fails. Plus, we're able to print a better error message because we now have the ID that caused the exception.

## Resources
* [Handling and throwing exceptions in .NET](https://docs.microsoft.com/en-us/dotnet/standard/exceptions/index)
* [How to use the try/catch block to catch exceptions](https://docs.microsoft.com/en-us/dotnet/standard/exceptions/how-to-use-the-try-catch-block-to-catch-exceptions)
* [How to use specific exceptions in a catch block](https://docs.microsoft.com/en-us/dotnet/standard/exceptions/how-to-use-specific-exceptions-in-a-catch-block)

## Practice: Address Book

### Instructions
1. Create a new console application.
2. Replace the default Program class with the code below.
3. Follow the instructions in the comments.

```csharp
class Program
{
    /*
        1. Add the required classes to make the following code compile.
        HINT: Use a Dictionary in the AddressBook class to store Contacts. The key should be the contact's email address.

        2. Run the program and observe the exception.

        3. Add try/catch blocks in the appropriate locations to prevent the program from crashing
            Print meaningful error messages in the catch blocks.
    */

    static void Main(string[] args)
    {
        // Create a few contacts
        Contact bob = new Contact() {
            FirstName = "Bob", LastName = "Smith",
            Email = "bob.smith@email.com",
            Address = "100 Some Ln, Testville, TN 11111"
        };
        Contact sue = new Contact() {
            FirstName = "Sue", LastName = "Jones",
            Email = "sue.jones@email.com",
            Address = "322 Hard Way, Testville, TN 11111"
        };
        Contact juan = new Contact() {
            FirstName = "Juan", LastName = "Lopez",
            Email = "juan.lopez@email.com",
            Address = "888 Easy St, Testville, TN 11111"
        };


        // Create an AddressBook and add some contacts to it
        AddressBook addressBook = new AddressBook();
        addressBook.AddContact(bob);
        addressBook.AddContact(sue);
        addressBook.AddContact(juan);

        // Try to addd a contact a second time
        addressBook.AddContact(sue);


        // Create a list of emails that match our Contacts
        List<string> emails = new List<string>() {
            "sue.jones@email.com",
            "juan.lopez@email.com",
            "bob.smith@email.com",
        };

        // Insert an email that does NOT match a Contact
        emails.Insert(1, "not.in.addressbook@email.com");


        //  Search the AddressBook by email and print the information about each Contact
        foreach (string email in emails)
        {
            Contact contact = addressBook.GetByEmail(email);
            Console.WriteLine("----------------------------");
            Console.WriteLine($"Name: {contact.FullName}");
            Console.WriteLine($"Email: {contact.Email}");
            Console.WriteLine($"Address: {contact.Address}");
        }
    }
}
```