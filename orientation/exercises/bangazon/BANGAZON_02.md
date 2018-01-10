# Bangazon Orientation

## Specializing Derived Classes with Overriding

---

## Instructions

### Override

1. Choose one of the general methods that you created in the `Department` class for overriding. For example, let's assume you created a `meet()` method which handles the logic of how teammates in that department gather for a meeting.
1. Override that method in all of your derived classes, giving each a more specialized implementation. For example, you could output a different meeting place for each department.

### Override, If Needed

1. Now make a virtual method on `Department` named `SetBudget(double budget)`. It will set, and return, the base budget that each department gets each year.
1. Override that method in any derived classes that require an adjustment to that base budget. Add, or subtract, from that base budget inside the derived class' override method to adjust that specific department's budget.
    ```cs
    public class Sales: Department
    {
        public override void SetBudget(double budget)
        {
            // The sales department needs more money than most others
            this.Budget += budget + 100000.00;
        }
    }
    ```
1. In the `Main` method, while you're looping over all departments, invoke the `SetBudget` method of each one.
    ```cs
    double baseBudget = 75000.00;

    // Some departments get the base $75,000.00 budget, but others
    // will be adjusted up or down depending on the logic you wrote
    // in each class.
    foreach(Department d in departments)
    {
        d.SetBudget(baseBudget);
        Console.WriteLine($"{d.toString()}");
    }
    ```
