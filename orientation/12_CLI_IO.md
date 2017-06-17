# Accepting User Input

C# provides three basic methods to read user input on the command line.

## Console.Read()

The [Console.Read Method ()](https://msdn.microsoft.com/en-us/library/system.console.read.aspx) will detect one single character at a time and return the numeric [ASCII value](http://ascii-table.com/ascii.php) of the character. You can use the `Convert.ToChar()` method to convert the integer value into its `string` representation (e.g. converts 107 to a lowercase *k*).

## Console.ReadKey()

The [Console.ReadKey()](https://msdn.microsoft.com/en-us/library/471w8d85.aspx) method, like the `Read()` method, reads one character at a time. Instead of return the ASCII integer value, it returns a `ConsoleKeyInfo` object. To get the actual character, you can use the `Key` property, and convert it into a string.

```cs
ConsoleKeyInfo enteredKey;

do
{
    enteredKey = Console.ReadKey();
    Console.WriteLine("You pressed the {0} key", enteredKey.Key.toString());
    
} while (enteredKey.Key != ConsoleKeyInfo.Escape);
```

## Console.ReadLine()

The [Console.ReadLine()](https://msdn.microsoft.com/en-us/library/system.console.readline.aspx) method, unlike the other two methods, will read in an entire line of characters. In a CLI application, what defines a *line* is the CRLF character. If you're typing in the CLI, and press *Enter*, that's considered a *line*.

```cs
string sentence;

do
{
    Console.WriteLine("Type in a sentence. Press enter when done.");
    sentence = Console.ReadLine();
    Console.WriteLine("You entered the sentence `{0}`", sentence);
    
} while (sentence != "quit");
```
