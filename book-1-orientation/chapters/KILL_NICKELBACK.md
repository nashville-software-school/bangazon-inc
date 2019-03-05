# Kill Nickelback

In this exercise, you're going to use Dictionaries, LINQ, and Lists.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/nickelback && cd $_
dotnet new console
dotnet restore
```

## Instructions

1. Define a List of Dictionaries, named `allSongs`, that contains 7 dictionaries.
1. Each dictionary in the list will have a key of type `string`, and a value of type `string`.
1. The key will be the name of an artist.
1. The value will be the song title by that artist. Make sure that some of the songs are from the band Nickelback. You can see a [list of their greatest hits](https://www.amazon.com/Best-Nickelback-1/dp/B00FFERTUK/) on Amazon.
   ```cs
   // Example
   List<Dictionary<string, string>> allSongs = new List<Dictionary<string, string>>();
   ```
1. Once the List is populated with 7 dictionaries, use LINQ methods, .Where() and .Select(), to check if the band name is "Nickelback".
1. If the band is **not** Nickelback, then add it to a list of dictionaries with the variable name `goodSongs`.
1. Make sure these artists in the `goodSongs` List are ordered alphabetically, in descending order (Z to A)
1. Use a `foreach` loop to print out only the good songs.
