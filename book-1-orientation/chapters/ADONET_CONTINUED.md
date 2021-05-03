# Finishing CRUD Using ADO.NET

In this chapter we'll implement some functionality to our Roommates application to allow users to update and delete records in the database. 

## Updating a Room

Inside the `RoomRepository` add another method called `Update`. It should take a `Room` object as a parameter and will not return anything.

```csharp
/// <summary>
///  Updates the room
/// </summary>
public void Update(Room room)
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"UPDATE Room
                                    SET Name = @name,
                                        MaxOccupancy = @maxOccupancy
                                    WHERE Id = @id";
            cmd.Parameters.AddWithValue("@name", room.Name);
            cmd.Parameters.AddWithValue("@maxOccupancy", room.MaxOccupancy);
            cmd.Parameters.AddWithValue("@id", room.Id);

            cmd.ExecuteNonQuery();
        }
    }
}
```

Notice in this method that we use a new method called `ExecuteNonQuery` where in previous methods we used to call `ExecuteReader`. That's because when we were making `SELECT` statements in our SQL we were expecting the database to send data back and we had to read through it. Now that we're using a `UPDATE` statement in our SQL command, what we're really telling the database is simply that "We'd like you to execute this SQL code to update a row. We don't expect you to give us anything back, please and thank you".

Now update the menu in `Program.cs` to allow users to update a room of their choosing.

```csharp
case ("Update a room"):
    List<Room> roomOptions = roomRepo.GetAll();
    foreach (Room r in roomOptions)
    {
        Console.WriteLine($"{r.Id} - {r.Name} Max Occupancy({r.MaxOccupancy})");
    }

    Console.Write("Which room would you like to update? ");
    int selectedRoomId = int.Parse(Console.ReadLine());
    Room selectedRoom = roomOptions.FirstOrDefault(r => r.Id == selectedRoomId);

    Console.Write("New Name: ");
    selectedRoom.Name = Console.ReadLine();

    Console.Write("New Max Occupancy: ");
    selectedRoom.MaxOccupancy = int.Parse(Console.ReadLine());

    roomRepo.Update(selectedRoom);

    Console.WriteLine("Room has been successfully updated");
    Console.Write("Press any key to continue");
    Console.ReadKey();
    break;
```

The code above will run when a user selects the "Update a room" option from the menu. It will first show them the list of all rooms and ask them to select which one they'd like to update. It then collects what they'd like the updated Name and Max Occupancy to be, and finally saves those changes to the database.


## Deleting a Room

Create a `Delete` method in the `RoomRepository`. It should take an `int id` as a parameter and not return anything. Notice again that we are wanting to execute a DELETE statement on the database but we don't expect the database to return any data to us, so we use the `ExecuteNonQuery` method.

```csharp
/// <summary>
///  Delete the room with the given id
/// </summary>
public void Delete(int id)
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            // What do you think this code will do if there is a roommate in the room we're deleting???
            cmd.CommandText = "DELETE FROM Room WHERE Id = @id";
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
        }
    }
}
```


## Practice

1. Create a menu option for the user to delete a room. Make sure to list out the room options before prompting the user for a Room Id

1. Update the `ChoreRepository` to include an Update and Delete method and give the user menu options to be able to use this functionality. NOTE: What happens when a user tries to delete a Chore that's been assigned to someone? Why does this happen? What can/should be done about this?

**Advanced Challenge**

Give the user a menu option called "Reassign Chore". It should first list the chores that are already assigned to a roommate and prompt the user to select a Chore Id from the list. Upon selecting the chore, the user should get a message saying "This chore is currently assigned to {name}. Who would you like to assign it to?" followed by a list of all roommates. Finally the user should be prompted to enter the Id of one of the other roommates and the chore should be reassigned. NOTE: You'll likely need to create multiple methods to make this happen.
