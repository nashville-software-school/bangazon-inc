# Kill Nickelback

In this exercise, you're going to use a sets, tuples, and lists.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/nickelback && cd $_
dotnet new console
dotnet restore
```

## Instructions

1. Define a set that contains tuples. Each tuple should contain two strings:
    1. The name of an artist
    1. A song by that artist

    Make sure that some of the songs are from the band Nickelback. You can see a [list of their greatest hits](https://www.amazon.com/Best-Nickelback-1/dp/B00FFERTUK/) on Amazon.
    ```
    # Example set
    songs = {
        ('Nickelback', 'How You Remind Me'), 
        ('Will.i.am', 'That Power'),
        ('Miles Davis', 'Stella by Starlight'),
        ('Nickelback', 'Animals')
    }
    ```
2. Using a set comprehension, create a new set that contains all songs that were not performed by Nickelback.

