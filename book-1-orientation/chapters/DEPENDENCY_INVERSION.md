# Dependency Inversion

In the last chapter, you built interfaces to allow your application to have much more flexibility in how your different types of objects can be grouped together and break out of the initial restriction that a `List<>` can only contain one type of thing. Now it's not a restriction because you can use interfaces to add multiple types to a specific object - not just the initial type defined by its class.

#### With No Interfaces

By just using the class types, there is no way to combine the `Oak` and `Birch` into a single list of deciduous trees, not combine the `Pine` and `Fir` into a coniferous tree list. You can see that some of these classes share properties.

```cs
public class Oak {
    public double LeafShape { get; set; }
    public double SeedType { get; set; }
}

public class Birch {
    public double LeafShape { get; set; }
    public double SeedType { get; set; }
}

public class Pine {
    public double ConeSize { get; set; }
    public double NeedleSize { get; set; }
}

public class Fir {
    public double ConeSize { get; set; }
    public double NeedleSize { get; set; }
}
```

Take those shared properties and make interfaces for them so that related classes can be grouped together.

#### With Interfaces

```cs
public interface IConiferous {
    double ConeSize;
    double NeedleSize;
}

public interface IDeciduous {
    double LeafShape;
    double SeedType;
}

public class Oak : IDeciduous { ... }
public class Pine : IConiferous { ... }
public class Birch : IDeciduous { ... }
public class Fir : IConiferous { ... }

Birch oldManTwig = new Birch();
Oak bentBoughs = new Oak();
Pine needleHead = new Pine();
Fir pricklyPete = new Fir();

List<IConiferous> = new List<IConiferous>() { needleHead, pricklyPete }
List<IDeciduous> = new List<IDeciduous>() { oldManTwig, bentBoughs }
```

## Performing Actions Based on Interfaces

In the last chapter, you applied interfaces to many disparate animals so that they could be grouped together. Now that you have a flexible system to define many different kinds of animals, your next task is to define an animal control person.

In this chapter, you are going to imagine that all of your animals have been donated to the local zoo. In that zoo, they have African Painted Dogs. The painted dogs keep finding a way to escape their enclosure, and they keep needing to hire an animal control specialist that specializes in capturing ground-based animals like dogs, cats, emus, etc.

We need to represent this in our software application so we can write logic to keep records of when the specialist captures the painted dogs. Here's an initial code.

```cs
public class GroundAnimalControlSpecialist
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public double HourlyRate { get; set; }

    public void CaptureDog (PaintedDog dog)
    {
        // Logic to contain, sedate, and return an animal
    }
}
```

This certainly solves the problem at hand so we can perform the behavior of capturing an escaped dog. However, as the zoo has more animals escaping, the specialist must capture those and you must write the logic in your application to record that process.

Time to write more methods to capture the Monkeys, Wolverines, Gazelles, and Camels that escape.

```cs
public class GroundAnimalControlSpecialist
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public double HourlyRate { get; set; }

    public void CaptureDog (PaintedDog dog) { }

    public void CaptureMonkey (Monkey monkey) { }

    public void CaptureCamel (Camel camel) { }

    public void CaptureGazelle (Gazelle gazelle) { }

    public void CaptureWolverine (Wolverine wolverine) { }
}
```

You might imagine how cumbersome this could become, both to the developer writing and maintaining this class, but also to other developers who need to use it. You could end up with dozens of individual methods, each for capturing a specific animal. In developer-speak, what this code has done is create tight couplings between the methods and the concrete types.

The **`GroundAnimalControlSpecialist`** class is tightly coupled to PaintedDog, Monkey, Camel, Gazelle and Wolverine. If one of those animal classes is removed from the system, it forces the development team to refactor the **`GroundAnimalControlSpecialist`** to remove the corresponding method. All of these classes should be able to evolve independently of each other.

> **Vocabulary:** In software engineering, coupling is the degree of interdependence between software modules, or the strength of the relationships between modules.
>
> Coupling is usually contrasted with cohesion. Low coupling often correlates with high cohesion, and vice versa. Low coupling is often a sign of a well-structured computer system and a good design, and when combined with high cohesion, supports the general goals of high readability and maintainability.

Could you instead write a single method and pass **_any_** ground based animal in as a parameter? Why, yes... yes you can. You do it by specifying the interface as the type for the argument.

```cs
public class GroundAnimalControlSpecialist
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public double HourlyRate { get; set; }

    public void Capture (IWalking walkingAnimal)
    {
        /*
            Since all of the animals that this person
            specializes in capturing all implement the
            IWalking interface, any one of them can now
            be passed as arguments to this method.
        */
    }
}
```


```cs
public static void Main () {
    GroundAnimalControlSpecialist kirren = new GroundAnimalControlSpecialist();

    PaintedDog muffles = new PaintedDog();
    Kangaroo mike = new Kangaroo();

    muffles.EscapeEnclosure()
    mike.EscapeEnclosure()

    /*
        Muffles and Mike are different base types,
        but they share an interface (IWalking) and
        can be passed to Capture().
    */
    kirren.Capture(muffles);
    kirren.Capture(mike);
}
```

## Resources

* [The Dependency Inversion Principle](https://code.tutsplus.com/tutorials/solid-part-4-the-dependency-inversion-principle--net-36872)

## Practice: Von Rimmersmark - The Monster Killer

Erich Von Rimmersmark is a world-reknowned hunter of things that go bump in the night. You job is to complete the code below by adding interfaces and thinking about dependency inversion to allow Erich to kill monsters that have common weaknesses.

```cs
public class Hunter
{
    public string FirstName { get; set; }
    public string LastName { get; set; }

    public List<string> Weapons { get; } = new List<string>() {
        "Silver", "Fire", "Holy Water"
    };

    public Hunter (string first, string last) {
        FirstName = first;
        LastName = last;
    }

    public void SplashWater (Wight wight) {
        wight.Douse();  // Kills with holy water
    }

    public void Ignite (Mummy mummy) {
        mummy.Burn("Fire");  // Kills with fire
    }

    public void WieldSilver (Vampire vamp) {
        vamp.Stab();   // Stabs with silver knife
    }

    public override string ToString () {
        return $"{FirstName} {LastName} kills monsters with the following weapons: {String.Join(", ", Weapons)}";
    }
}
```

Here's a list of monsters and what Erich can use to kill them.

| Vampire | Mummy | Ghoul | Ghast | Wight | Demon | Zombie |
|---|---|---|---|---|---|---|
| Silver | Fire | Holy water | Fire | Silver | Holy water | Fire |
| Fire | | Silver | Holy water | | Silver | |
| | | | | | Fire | |

Here's some code to get you started.

#### Interface

> Interfaces/ICombustable.cs

```cs
public interface ICombustable
{
    void Burn (string attack);
}
```

#### Implementing Class

> Models/Mummy.cs

```cs
public class Mummy : ICombustable
{
    public void Burn (string attack)
    {
        if (attack === "Fire") {
            Console.WriteLine("You just killed the Mummy");
        }
    }
}
```

#### Main Logic

> Program.cs

```cs
public static void Main()
{
    Hunter VonRimmersmark = new Hunter("Erich", "Von Rimmersmark");

    Mummy tuts = new Mummy();

    VonRimmersmark.Burn(tuts);
}
```

## Puzzle Challenge: The One Weapon To Kill Them All

Erich has travelled the Earth many times in his quest to rid the world of evil. He has gathered wisdom from hunters far and wide, and studied the lore of ancient civilizations that wrote of such creatures. During his studies he came across a cryptic passage.

_"Ye that desires to banish the evilkind of this worldly realm need only to brandish a poultice of non-sensical liquid that defies the Unalterable Law of Sir Isaac."_

For hundreds of years, Erich scoured literature and sought the wisest of philosophers and clergy hoping for a clue as to what this substance might be. At last, after fighting off a den of vampire near Midland, Michigan, Erich stumbled upon the answer as he drove out of town. At once, he drove to the nearest store and bought as much as he could.

Over the next few months, he tried it on every monster he fought, and to his delight discovered that no monster could withstand the onslought of this new, mighty weapon.

Once you are able to decipher the puzzle, then you can refactor your application and use the Power of Inheritance to allow Erich to kill **any** monster with this substance.
