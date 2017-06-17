# Interfaces

An interface in C# is a construct that you define for classes to implement. Think of it as a contract for a class. If it implements an interface, then it must define a method, property, or event for each one defined in the interface. Let's look at an example for our Zoo.

```cs
interface IAmbulatory
{
	void run();
	void walk();
}

interface IFlying
{
	void fly();
	void land();
}
```

Here you've defined two interfaces. One for land animals and one for flying animals. Let's implement them.

```cs
class PaintedDog : IAmbulatory
{
	public void run()
	{
		Console.WriteLine("Animal is now running");
	}

	public void walk()
	{
		Console.WriteLine("Animal is now walking");
	}
}
```

The `PaintedDog` class has now implemented the two methods required by the inteface that was designated. If you had not written the `walk()` function, the code would not compile and you would get a message like this.

```
'PaintedDog' does not implement interface member 'IAmbulatory.walk()'
```
## Multiple Interfaces

A class can implement more than one interface. Let's use a flying squirrel as an example. They don't truly fly (they glide) but it's close enough for an example.

```cs
class FlyingSquirrel : IAmbulatory, IFlying
{
	public void run()
	{
		Console.WriteLine("Animal is now running");
	}

	public void walk()
	{
		Console.WriteLine("Animal is now walking");
	}

	public void fly()
	{
		Console.WriteLine("Animal is now flying");
	}

	public void land()
	{
		Console.WriteLine("Animal is now on the ground");
	}		
}
```

## Definition, but no implementation

The compiler will also yell at you if you try to write any implementation code in the inteface definition. The interface says **what** to implement, but never **how** to implement it.