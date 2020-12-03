# Writing SQL in a .NET Application with ADO.NET

Sometimes money is tight. Sometimes when money is tight, it becomes an unavoidable truth that we must live with other people. We call these people _Roommates_.

Your task is to build a command line application to manage a house full of roommates. You should persist data in a SQL Server database.

> **NOTE:** This will begin as an interactive lesson. Your instructor will lead you through following the instructions.

## Data Persistence

Our .NET application will need to communicate with a SQL Server database. To be able to do this, we'll be installing a library called ADO.NET. With ADO.NET installed, we'll have access to a few C# classes that are helpful for communicating with databases. The ADO.NET classes we'll be using heavily are:

- **SqlConnection** - This class represents the connection between our console application and our SQL Server database
- **SqlCommand** - This class will help us write sql queries in our C# code and execute them against the database
- **SqlDataReader** - This class will help us parse out the data that comes back from our database so that we can convert it to C# objects

## Vocabulary

Before you get started, let's introduce some terms that will be used during this project.

- **Models** - Models are C# classes that represent our database tables. For example, we have a `Chore` table in our database with a `Id` and `Name` column. To model this, we'd make a C# class named `Chore` with an `Id` and `Name` property.
- **Repository** - Repositories are classes that we create whose purpose is data access. We'll define lots of our CRUD functionality there. They often have methods like `Get`, `GetById`, `Add`, `Delete`, etc
- **Connection String** - A connection string is an address of a database--similar to a URL. It specifies the source of the data as well as the means of connecting to it. For example, you're about to create a database inside of SQL Server called `Roommates`; the connection string for the `Roommates` database will be `server=localhost\SQLExpress;database=Roommates;integrated security=true`
- **ADO.NET** - ADO.NET is an umbrella term for all of the C# classes we'll be using (listed above) for accessing our SQL database from our C# console app. 


## Instructions

1. Use the [Roommates](./assets/roommates.sql) SQL script to create a `Roommates` database.
1. Take a look at the ERD to familiarize yourself with the database.
![Roommates ERD](./assets/Roommates.png)
1. In Visual Studio, create a new project. Make it a console application (.NET Core) and call it `Roommates`. The following screen will ask you where you want to put this project. Select your `workspace` directory.
1. In your terminal, navigate to the directory where you created your project. The directory will have a `Roommates.sln` file in it.
1. `cd` into your project directory. When you list what's in the directory, you should see your `Roommates.csproj` and `Program.cs`.
1. Run the following commands. This imports the required package needed for using the ADO.NET classes.

   ```sh
   dotnet add package Microsoft.Data.SqlClient
   dotnet restore
   ```

    > NOTE: The following steps will have you creating folders inside Visual Studio. If you've never done this before, the way to add folders is to right click the directory level in Solution Explorer where you want to add the folder, and select `Add > New Folder`. If your menu says "Add Solution Folder", you've clicked the wrong spot.

1. Make a folder in your project called `Models`. This folder will contain classes that represent tables in our database.
1. In the `Models` folder, create `Room.cs`, `Roommate.cs` and `Chore.cs` file. Copy in the following code

   ## C# files

   **Models/Room.cs**

    ```cs
    namespace Roommates.Models
    {
        // C# representation of the Room table
        public class Room
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public int MaxOccupancy { get; set; }
        }
    }
    ```


   **Models/Roommate.cs**

    ```cs
    using System;

    namespace Roommates.Models
    {
        // C# representation of the Roommate table
        public class Roommate
        {
            public int Id { get; set; }
            public string Firstname { get; set; }
            public string Lastname { get; set; }
            public int RentPortion { get; set; }
            public DateTime MovedInDate { get; set; }
            public Room Room { get; set; }
        }
    }
    ```

   **Models/Chore.cs**

    ```cs
    namespace Roommates.Models
    {
        // C# representation of the Chore table
        public class Chore
        {
            public int Id { get; set; }
            public string Name { get; set; }
        }
    }
    ```

    Before we get into access data from our database, let's stub out a quick menu for our user that has options for seeing all rooms, seeing a single room, or adding a new room. Update your `Main` method in `Program.cs` to the following

    **Program.cs**

    ```csharp
    class Program
    {
        //  This is the address of the database.
        //  We define it here as a constant since it will never change.
        private const string CONNECTION_STRING = @"server=localhost\SQLExpress;database=Roommates;integrated security=true";

        static void Main(string[] args)
        {
            bool runProgram = true;
            while (runProgram)
            {
                string selection = GetMenuSelection();

                switch (selection)
                {
                    case ("Show all rooms"):
                        // Do stuff
                        break;
                    case ("Search for room"):
                        // Do stuff
                        break;
                    case ("Add a room"):
                        // Do stuff
                        break;
                    case ("Exit"):
                        runProgram = false;
                        break;
                }
            }

        }

        static string GetMenuSelection()
        {
            Console.Clear();

            List<string> options = new List<string>()
            {
                "Show all rooms",
                "Search for room",
                "Add a room",
                "Exit"
            };

            for (int i = 0; i < options.Count; i++)
            {
                Console.WriteLine($"{i + 1}. {options[i]}");
            }

            while (true)
            {
                try
                {
                    Console.WriteLine();
                    Console.Write("Select an option > ");

                    string input = Console.ReadLine();
                    int index = int.Parse(input) - 1;
                    return options[index];
                }
                catch (Exception)
                {

                    continue;
                }
            }

        }
    }
    ```

    You can run this if you like, but it doesn't do much yet. Let's start creating some Repository classes next so we can actually access data from our database.

1. Create a new folder called `Repositories`. This folder will contain classes that will be responsible for getting data out of our database and creating C# objects from that data. We typically call classes with this responsibility a Repository. Add two new files to it called `BaseRepository.cs` and `RoomRepository.cs`.
1. Copy the following code into `BaseRepository.cs`

   ```csharp
    using Microsoft.Data.SqlClient;

    namespace Roommates.Repositories
    {
        /// <summary>
        ///  A base class for every other Repository class to inherit from.
        ///  This class is responsible for providing a database connection to each of the repository subclasses
        /// </summary>
        public class BaseRepository
        {
            /// <summary>
            ///  A "connection string" is the address of the database.
            /// </summary>
            private string _connectionString;


            /// <summary>
            ///  This constructor will be invoked by subclasses.
            ///  It will save the connection string for later use.
            /// </summary>
            public BaseRepository(string connectionString)
            {
                _connectionString = connectionString;
            }


            /// <summary>
            ///  Represents a connection to the database.
            ///   This is a "tunnel" to connect the application to the database.
            ///   All communication between the application and database passes through this connection.
            /// </summary>
            protected SqlConnection Connection => new SqlConnection(_connectionString);
        }
    }

   ```

   The BaseRepository you just added contains a single, computed property called `Connection`. The type of this property is `SqlConnection`. It represents a connection from your C# application to your SQL Server database. Think of it like a two-way tunnel that all communication passes through. Since the property is computed, it means that any time the `Connection` property gets referenced in our code, it will create a new tunnel. Typically, this tunnel stays open only long enough to execute a single command (i.e. a `SELECT` or `INSERT` statement). Once the command is executed, we close the connection and effectively destroy that tunnel. Then when we want to execute another command, we do the same thing again and create a new tunnel.

1. Copy the following code into `RoomRepository.cs`

    ```cs
    using Microsoft.Data.SqlClient;
    using Roommates.Models;
    using System.Collections.Generic;

    namespace Roommates.Repositories
    {
        /// <summary>
        ///  This class is responsible for interacting with Room data.
        ///  It inherits from the BaseRepository class so that it can use the BaseRepository's Connection property
        /// </summary>
        public class RoomRepository : BaseRepository
        {
            /// <summary>
            ///  When new RoomRespository is instantiated, pass the connection string along to the BaseRepository
            /// </summary>
            public RoomRepository(string connectionString) : base(connectionString) { }

            // ...We'll add some methods shortly...
        }
    }
    ```


1. Let's see how we can get data out of our Room table and convert it into a `List<Room>`. Add the following method to your `RoomRepository` class

   ```csharp
    /// <summary>
    ///  Get a list of all Rooms in the database
    /// </summary>
    public List<Room> GetAll()
    {
        //  We must "use" the database connection.
        //  Because a database is a shared resource (other applications may be using it too) we must
        //  be careful about how we interact with it. Specifically, we Open() connections when we need to
        //  interact with the database and we Close() them when we're finished.
        //  In C#, a "using" block ensures we correctly disconnect from a resource even if there is an error.
        //  For database connections, this means the connection will be properly closed.
        using (SqlConnection conn = Connection)
        {
            // Note, we must Open() the connection, the "using" block doesn't do that for us.
            conn.Open();

            // We must "use" commands too.
            using (SqlCommand cmd = conn.CreateCommand())
            {
                // Here we setup the command with the SQL we want to execute before we execute it.
                cmd.CommandText = "SELECT Id, Name, MaxOccupancy FROM Room";

                // Execute the SQL in the database and get a "reader" that will give us access to the data.
                SqlDataReader reader = cmd.ExecuteReader();

                // A list to hold the rooms we retrieve from the database.
                List<Room> rooms = new List<Room>();

                // Read() will return true if there's more data to read
                while (reader.Read())
                {
                    // The "ordinal" is the numeric position of the column in the query results.
                    //  For our query, "Id" has an ordinal value of 0 and "Name" is 1.
                    int idColumnPosition = reader.GetOrdinal("Id");

                    // We user the reader's GetXXX methods to get the value for a particular ordinal.
                    int idValue = reader.GetInt32(idColumnPosition);

                    int nameColumnPosition = reader.GetOrdinal("Name");
                    string nameValue = reader.GetString(nameColumnPosition);

                    int maxOccupancyColunPosition = reader.GetOrdinal("MaxOccupancy");
                    int maxOccupancy = reader.GetInt32(maxOccupancyColunPosition);

                    // Now let's create a new room object using the data from the database.
                    Room room = new Room
                    {
                        Id = idValue,
                        Name = nameValue,
                        MaxOccupancy = maxOccupancy,
                    };

                    // ...and add that room object to our list.
                    rooms.Add(room);
                }

                // We should Close() the reader. Unfortunately, a "using" block won't work here.
                reader.Close();

                // Return the list of rooms who whomever called this method.
                return rooms;
            }
        }
    }
   ```

   To test this, let's get this method hooked up to the menu. First, we'll need to create a new instace of a `RoomRepository` in our `Main` method back in the `Program.cs` file. Add this variable declaration as the first line in `Main`

   ```csharp
   RoomRepository roomRepo = new RoomRepository(CONNECTION_STRING);
   ```

   Now update the code inside the `while` loop so it'll call our new `GetAll` method if the user asks to see all rooms.

   ```csharp
    while (runProgram)
    {
        string selection = GetMenuSelection();

        switch (selection)
        {
            case ("Show all rooms"):
                List<Room> rooms = roomRepo.GetAll();
                foreach (Room r in rooms)
                {
                    Console.WriteLine($"{r.Id} - {r.Name} Max Occupancy({r.MaxOccupancy})");
                }
                Console.Write("Press any key to continue");
                Console.ReadKey();
                break;
            case ("Search for room"):
                // Do stuff
                break;
            case ("Add a room"):
                // Do stuff
                break;
            case ("Exit"):
                runProgram = false;
                break;
        }
    }
   ```

   Running the program and selecting "Show all rooms" should now print all the rooms from the database out to the console. Try playing with some of the data in the database and see the changes in the program


1. Now create another method in `RoomRepository` that will get a single room by its Id. The method should accept an `int id` as a parameter and return a single `Room` object. Notice in the code below that the SQL statement now uses a parameter. We can tell we're using params in our SQL queries when we see the `@` symbol. Whatever integer value gets passed into the `GetById` method will get inserted into the SQL query.

   ```csharp
    /// <summary>
    ///  Returns a single room with the given id.
    /// </summary>
    public Room GetById(int id)
    {
        using (SqlConnection conn = Connection)
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = "SELECT Name, MaxOccupancy FROM Room WHERE Id = @id";
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataReader reader = cmd.ExecuteReader();

                Room room = null;

                // If we only expect a single row back from the database, we don't need a while loop.
                if (reader.Read())
                {
                    room = new Room
                    {
                        Id = id,
                        Name = reader.GetString(reader.GetOrdinal("Name")),
                        MaxOccupancy = reader.GetInt32(reader.GetOrdinal("MaxOccupancy")),
                    };
                }

                reader.Close();

                return room;
            }
        }
    }
   ```

1. Update the `switch` statement back in `Program.Main` so it calls the new `GetById` method. 
    > NOTE: this implementation doesn't have any error handling. If you're feeling ambitious, you can add code to this to account for the possibility of the user entering a non-numeric value, or entering an Id that doesn't exist in the database.

   ```csharp
    case ("Search for room"):
        Console.Write("Room Id: ");
        int id = int.Parse(Console.ReadLine());

        Room room = roomRepo.GetById(id);

        Console.WriteLine($"{room.Id} - {room.Name} Max Occupancy({room.MaxOccupancy})");
        Console.Write("Press any key to continue");
        Console.ReadKey();
        break;
   ```

1. Now that we've read data from our database, let's look at how we can add new records. Create a new method in the `RoomRepository` and name it `Insert`. It should accept a single `Room` object as a parameter. Notice once again we are using parameters in our SQL statement.

   ```csharp
    /// <summary>
    ///  Add a new room to the database
    ///   NOTE: This method sends data to the database,
    ///   it does not get anything from the database, so there is nothing to return.
    /// </summary>
    public void Insert(Room room)
    {
        using (SqlConnection conn = Connection)
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = @"INSERT INTO Room (Name, MaxOccupancy) 
                                            OUTPUT INSERTED.Id 
                                            VALUES (@name, @maxOccupancy)";
                cmd.Parameters.AddWithValue("@name", room.Name);
                cmd.Parameters.AddWithValue("@maxOccupancy", room.MaxOccupancy);
                int id = (int)cmd.ExecuteScalar();

                room.Id = id;
            }
        }

        // when this method is finished we can look in the database and see the new room.
    }
    ```

   You may be wondering why we set the `room.Id` property after the records is inserting into the database. Remember that the database is where each room's Id gets created. The room parameter that gets passed into the method doesn't have an Id when the method begins, but once it gets returned the Id will be included. Notice this part of the SQL command: `OUTPUT INSERTED.Id`. Normally, when we issue an INSERT statement to our database, no records come back and nothing gets returned. The addition of this `OUTPUT` statement means that we'd also like to get back the ID of the room that we just inserted.

   The `cmd.ExecuteScalar` method does two things: First, it executes the SQL command against the database. Then it looks at the first thing that the database sends back (in our case this is just the `Id` it created for the room) and returns it.

1. Update the switch statement in `Program.Main` to use our `Insert` method.

    ```csharp
    case ("Add a room"):
        Console.Write("Room name: ");
        string name = Console.ReadLine();

        Console.Write("Max occupancy: ");
        int max = int.Parse(Console.ReadLine());

        Room roomToAdd = new Room()
        {
            Name = name,
            MaxOccupancy = max
        };

        roomRepo.Insert(roomToAdd);

        Console.WriteLine($"{roomToAdd.Name} has been added and assigned an Id of {roomToAdd.Id}");
        Console.Write("Press any key to continue");
        Console.ReadKey();
        break;
    ```

# Practice

**IMPORTANT NOTE BEFORE YOU START!!!** 
    
The process of using ADO.NET is lengthy and verbose. You will undoubtedly be tempted to copy and paste code from one repository to another. We _highly_ _HIGHLY_ **HIGHLY** suggest that you do not do this. Doing this will not only lead to bugs in your code, it will hinder you from building muscle memory and impact your understanding of the code we're writing. Instead, reference code from other repositories, but type out your code by hand and leave comments if it helps you. It will pay off.

## Create a Chore Repository

1. Create a new file in the Repositories folder called `ChoreRepository` and implement the same methods as we did with the `RoomRepository`. After implementing each method, update the `Main` method to add an option in the menu.

1. Create a `RoommateRepository` and implement only the `GetById` method. It should take in a `int id` as a parameter and return a `Roommate` object. The trick: When you add a menu option for searching for a roommate by their Id, the output to the screen should output their first name, their rent portion, and _the name of the room they occupy_. Hint: You'll want to use a JOIN statement in your SQL query

1. Add a method to `ChoreRepository` called `GetUnassignedChores`. It should not accept any parameters and should return a list of chores that don't have any roommates already assigned to them. After implementing this method, add an option to the menu so the user can see the list of unassigned chores.

1. Add a `RoommateRepository` and define a `GetAll` method on it, but don't add a menu option to view all roommates yet. Next create a method in the `ChoreRepository` named `AssignChore`. It should accept 2 parameters--a roommateId and a choreId. Finally, add an option to the menu for "Assign chore to roommate". When the user selects that option, the program should first show a list of all chores and prompt the user to select the Id of the chore they want. Next the program should show a list of all roommates and prompt the user to select the Id of the roommate they want assigned to that chore. After the roommate has been assigned to the chore the program should print a message to the user to let them know the operation was successful.

### Advanced Challenge

Before you begin, add a few more records to the Chore and RoomateChore tables.

Inside the `ChoreRepository` create a method called `GetChoreCounts`. It's purpose will be to eventually help print out a report to the user that shows how many chores have been assigned to each roommate. i.e.

```
Wilma: 3
Juan: 4
Karen: 1
```

Helpful tips: 
- It may be tempting to make a SQL query to fetch all the chores and programatically count them in your C# code; but that would be inefficient, and if you've made it this far you're better than that! The better way to do this is using a GROUP BY clause in your SQL query
- The shape of the data that will be returned by your GROUP BY won't match the shape of any of your model classes. You'll need to make another class whose properties better represent this data.
