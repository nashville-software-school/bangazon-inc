# Bangazon Orientation

## Aggregation

---

## Instructions

For this exercise, you need to modify the Department class so that Employees can be aggregated into them. In your Department class, create a field `_employees` and a property, `Employees`, that defines only a `get`, and returns a list of employees currently assigned to the department.

Create two new methods.

1. `AddEmployee(Employee employee)` - Add an employee to the set. The `employee` parameter accepts an existing instance of an employee.
1. `RemoveEmployee(Employee employee)` - Removes an employee from the set. The `employee` parameter accepts an existing instance of an employee.

In your `Main` method, create an instance of each of your Departments that you have defined. Then create two or three Employee instances for each Department, and add them to the appropriate Department instance.

Once you have defined all of your Employees and Departments, write logic to output the name of each Department, and the first/last name of each employee it contains to the command line.

##### Example CLI Output

```bash
Department: Sales
   Andri Alexandrou
   Wayne Hutchinson
   Sephora Rodriguez
   Matt Qualls
   Jen Solima

Department: Technology
   Caitlin Stein
   Ryan Tanay
   Jessawynn Parker
   Damon Romano
```

Once you've completed this basic output, modify it to display any other properties that might be applied to either the Department or Employee that you added from the previous exercises (e.g. handicap, employment status, etc.)