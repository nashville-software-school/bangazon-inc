# Open - Closed Principle

## Brief Description

Given what you have worked on in this book, the Open/Closed Principle describes a class that is Open for extension, but closed for modification.

## Example

What does extension mean? To explore that, consider the following code. This is a scaled down version of the code that you used in the Trestlebridge Farms project. You should focus on the signature of the `AddResource()` method.

```cs
using System;
using System.Collections.Generic;
using Trestlebridge.Interfaces;


namespace Trestlebridge.Models.Facilities {

    public class PlowedField : IFacility<ISeedProducing> {

        private List<ISeedProducing> _plants = new List<ISeedProducing>();

        public List<ISeedProducing> Resources {
            get {
                return _plants;
            }
        }


        public void DiscardResource (int index) {
            _plants.RemoveAt(index);
        }

        public void AddResource (ISeedProducing plant) {
            _plants.Add(plant);
        }
    }
}
```

Since the `AddResource ()` method's argument is typed as an abstraction _(in this case, an interface)_ of `ISeedProducing`, then there is no tight coupling to a single lower-level class. Again, a tighly coupled method would look like this - where the argument is a specific type.

```cs
public void AddResource (Wildflower flower) {
    _plants.Add(flower);
}
```

Because this definition creates a tight coupling, if you wanted to another another kind of resource, then you would need to change the contents of this source code file to accomodate the changes.

```cs
public void AddWildflower (Wildflower flower) {
    _plants.Add(flower);
}

public void AddSunflower (Sunflower flower) {
    _plants.Add(flower);
}
```

This violates the Open/Closed principle because you've designed your class in such a way that any time a new type of plant is added to the system, you have to modify this source code. That's **_Bad_**.

The original version, however, does not create any tight couplings between this class and the individual flower classes. The **`PlowedField`** class and the individual seed producing classes (i.e. Sesame and Sunflower) are now _loosely coupled_.

```cs
public void AddResource (ISeedProducing plant) {
    if (_plants.Count < _capacity) {
        _plants.Add(plant);
    }
}
```

By making your method dependent upon an abstraction instead of a concrete type, you are now able to extend the possibilities of which types this method can work with. For example, I can now add a third seed producing class, and my **`PlowedField`** class does not need any modifications.

```cs
public class Soybean : ISeedProducing {
    private int _seedsProduced = 23;

    public string Type { get; } = "Soybean";

    public double Harvest () {
        return _seedsProduced;
    }
}
```

Since the **`Soybean`** type implements **`ISeedProducing`**, they can be planted in any **`PlowedField`** without any other changes made to the system!!

🤯 💥

Therefore, the **`PlowewdField`** class (a.k.a. module) is open for extension but closed for modification.