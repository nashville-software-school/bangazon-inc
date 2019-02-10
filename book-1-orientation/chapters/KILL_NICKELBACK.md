# Kill Nickelback

In this exercise, you're going to use HashSets and Lists.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/nickelback && cd $_
dotnet new console
dotnet restore
```

## Instructions

1. Define a list of dictionaries.
1. Each dictionary will have a key of type `string`, and a value of type `string`.
1. Assign the list to a `goodSongs` variable.
1. Define a HashSet, named `allSongs`, that contains 7 dictionaries.
1. Each dictionary in the set will have a key of type `string`, and a value of type `string`.
1. The key will be the name of an artist.
1. The value will be the name of a song by that artist. Make sure that some of the songs are from the band Nickelback. You can see a [list of their greatest hits](https://www.amazon.com/Best-Nickelback-1/dp/B00FFERTUK/) on Amazon.
    ```cs
    // Example
    HashSet<Dictionary<string, string>> allSongs = new HashSet<Dictionary<string, string>>();
    ```
1. Once the set is populated with 7 dictionaries, iterate over the set of songs, and check if the band name is "Nickelback".
1. If the band is **not** Nickelback, then add it to the `goodSongs` list.
1. Uee another `foreach` loop to print out all the good songs.
