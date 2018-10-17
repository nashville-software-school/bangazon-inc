# Hashset in C#

A hashset is a collection of unique items. You use a HashSet when you want to store an unordered collection of items. One common usage of sets is when developers want to reduce a large dataset and extract only unique objects.

Consider you work for a large car dealership. Your business has a large inventory of cars, many of the same model. For example, your lot has 30 Ford F-150s on it at any time.

The manager of the dealership wants you to produce a report that shows her how many different vehicle models currently in inventory.

```cs
List<string> Inventory = new List<string> ()
{
    "Camry", "F-150", "MDX", "Camry", "Camry",
    "Taurus", "F-150", "MDX", "Camry", "Xterra",
    "Mustang", "Suburban", "Santa Fe", "F-150", "Camry",
    "F-150", "F-150", "Mustang", "Camry", "Camry",
    "Camry", "Escalade", "Q30", "Camry", "MDX",
};

HashSet<string> allModels = new HashSet<string>();

foreach (string model in Inventory)
{
    allModels.Add(model);
}

// Display all unique model names
foreach (string vehicle in allModels)
{
    Console.WriteLine($"{vehicle}");
}

/*
    Output

    Camry
    F-150
    MDX
    Taurus
    Xterra
    Mustang
    Suburban
    Santa Fe
    Escalade
    Q30
*/
```

After that code runs, there would only be one string of `"F-150"` in that set, even though the original list of vehicles had multiple entries of `"F-150"` in it. There were also many Camrys in the original inventory, but the final set only has one.


## Practice: Car Sets

## Setup

```sh
mkdir -p ~/workspace/csharp/exercises/sets && cd $_
dotnet new console
```

## References

* [C# HashSet](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1?redirectedfrom=MSDN&view=netcore-2.1)


## Instructions

1. Create an empty HashSet named `Showroom` that will contain strings.
1. Add four of your favorite car model names to the set.
1. Print to the console how many cars are in your show room.
1. Pick one of the items in your show room and add it to the set again.
1. Print your showroom again, and notice how there's still only one representation of that model in there.
1. Create another set named `UsedLot` and add two more car model strings to it.
1. Use the `UnionWith()` method on `Showroom` to add in the two models you added to `UsedLot`.
1. You've sold one of your cars. Remove it from the set with the `Remove()` method.

### Acquiring more cars

1. Now create another HashSet of cars in a variable `Junkyard`. Someone who owns a junkyard full of old cars has approached you about buying the entire inventory. In the new set, add some different cars, but also add a few that are the same as in the `Showroom` set.
1. Create a new HashSet of your show room  with `HashSet<string> clone = new HashSet<string>(Showroom);`
1. Use the `IntersectWith()` method on the clone to see which cars exist in both the show room and the junkyard.
1. Now you're ready to buy the cars in the junkyard. Use the `UnionWith()` method to combine the junkyard into your showroom.
1. Use the `Remove()` method to remove any cars that you acquired from the junkyard that you don't want in your showroom.
