# Squared Randoms

## Setup

```
mkdir -p ~/workspace/csharp/exercises/random && cd $_
dotnet new console
dotnet restore
```

## References

* [Random class](https://msdn.microsoft.com/en-us/library/system.random(v=vs.110).aspx)
* [Python Lists](https://docs.python.org/3.6/tutorial/datastructures.html)

## Instructions

1. Using the `Random` class, generate a list of 20 random numbers that are in the range of 1-50.

    ```cs
    Random random = new Random();
    // Create a list
    // Populate the list
    ```

1. With the resulting List, populate a new List that contains each number squared. For example, if the original list is `2, 5, 3, 15`, the final list will be `4, 25, 9, 225`.
1. Then remove any number that is odd from the list of squared numbers.