# Bangazon Orientation

## Defining Your Departments

---

## Setup

```sh
mkdir -p workspace/csharp/orientation/bangazon && cd $_
```

## Instructions

1. Create a new console application.
1. In `Department.cs`, create a *Department* class.
1. Create some simple properties and methods on Department. You are going to create some derived classes that inherit from Department, so make sure that the properties/methods you add are general to **all** Departments (e.g. name, supervisor, employee_count, etc).

##### Example property/method definition

```cs
// Parent class for all departments
public class Department
{
    private string _name;
    private string _supervisor;
    private int _employee_count;

    // You can create properties, if needed

    // Constructor method
    public Department(string name, string supervisor, int employees)
    {
        _name = name;
        _supervisor = supervisor;
        _employee_count = employees;
    }
}

```

1. After you are happy with your Department class, create a derived class that defines a particular Department. Create some properties that apply **only** to that department.

The classes should, at the very least, set the initial value for the properties that you defined in the base class inside the constructor.

Examples, include HR, IT, Marketing, Sales, etc.

```cs
/*
    Class for representing Human Resources department.

    It is very important to note here that since HumanResources
    inherits from the Department type, any object instance
    is both of type HumanResources AND Department.

    Remember, inheritance denotes an is-a relationship.
*/
public class HumanResources: Department
{
    /*
        Now this syntax looks very strange! What's going on here?
        To relate back to your JavaScript knowledge, this code
        is creating an array that holds objects.

        The keywords are telling the compiler that each item in
        the List will have a key of type string, and a value of
        type string.

        For example, it would look like this in JavaScript.
        [{'vacation':'Unlimited vacation for everyone!!'}]
    */
    private Dictionary<string, string> _policies = new Dictionary<string, string>();

    /*
        Since the parent class defined a constructor with three
        arguments, the derived class must also define a constructor
        with the same signature, or arity, as the parent.

        Then, we can just pass those argument value directly to the
        parent class with the `base` keyword.
    */
    public HumanResources(string dept_name, string supervisor, int employees): base(dept_name, supervisor, employees)
    {
    }

    // Publicly accessible method to add an HR policy
    public void AddPolicy(string title, string text)
    {
        /*
            Talk about verbose! Every time you want to create, or
            reference a KeyValuePair, you have to use the angle
            brackets, and type keywords.
        */
        _policies.Add(title, text);

        foreach(KeyValuePair<string, string> policy in _policies)
        {
            Console.WriteLine($"{policy.Value}");
        }
    }

    // Overriding the default toString() method for each object instance
    public string toString()
    {
        return $"{_name} {_supervisor} {_employee_count}";
    }
}
```

1. Create 2 more classes for departments of your choosing.
1. Create some instances of each department in the `Main` method.
1. Assign values to the properties of each instance.
1. Call some of the methods on the instances to verify their operation.
1. Add all derived departments to a List of type Department.

```cs
public class Program
{

    public static void Main() {
        List<Department> departments = new List<Department>();

        // Create some instances
        HumanResources hr = new HumanResources("HR", "Amy Schumer", 2);

        // Add derived departments to the list
        departments.Add(hr);

        // Iterate over all items in the list and output a string
        // representation of the class
        foreach(Department d in departments)
        {
            Console.WriteLine($"{d.toString()}");
        }
    }
}
```
