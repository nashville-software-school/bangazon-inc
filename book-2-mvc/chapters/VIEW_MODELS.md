# View Models

We've seen how controllers are able to pass objects into our views, and how views expect a certain type of object. For example:

> DogsController.cs

```csharp
public ActionResult Index()
{
    ...

    return View(dogs);
}
```

> Dogs/Index.cshtml

```razor
@model IEnumerable<DogWalker.Models.Dog>

...

@foreach (var item in Model) {
    <tr>
        <td>
            @Html.DisplayFor(modelItem => item.Name)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Breed)
        </td>
    </tr>
}
```

In this example we can see that the `Index` method of the Dog Controller is passing a list of dogs to the View. The view will then loop over each of the dogs in the list to dynamically create rows in a table.

This works out fine if the page you're creating only requires dog information on it. Let's consider a more realistic scenario though. Say your designer asks that the Dog page of your application is a bit more complex. Here is the mockup you're given

![](./images/DogWalkerMockup.png)

This View now seems to require more data than just a list of dogs. There's now information on the Owner and Walkers as well.

The view, however, can only accept **one** type of thing, so how do we pass it multiple things?

The answer is to wrap all the things up in a single class called a View Model. The difference between regular models and view models is that regular models are meant to mimic the shape of our database tables. View models are meant to mimic the shape of our html pages. It may be helpful to think of view models as similar to react state. Looking at the mockup again, what are the things on the page that would belong in state?

![](./images/DogWalkerMockupAnnotated.png)

- An Owner object
- A list of Dogs
- A list of Walkers

Let's create a View Model that contains all of these things. Create a directory inside of your `Models` folder and name it `ViewModels`. Within that folder, create a file called `ProfileViewModel.cs` and add the following code

```csharp
using System;
using System.Collections.Generic;

namespace DogWalker.Models.ViewModels
{
    public class ProfileViewModel
    {
        public Owner Owner { get; set; }
        public List<Walker> Walkers { get; set; }
        public List<Dog> Dogs { get; set; }
    }
}
```

Now go to the `DogController` and add the following helper methods.

> Get an owner by Id

```csharp
private Owner GetOwnerDetails(int id)
{
    using(SqlConnection conn = Connection)
    {
        conn.Open();

        using(SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"
                SELECT Id, Email, Name, Address, NeighborhoodId, Phone
                FROM Owner
                WHERE Id = @id
            ";

            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader reader = cmd.ExecuteReader();

            Owner owner = null;

            if (reader.Read())
            {
                owner = new Owner()
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        Name = reader.GetString(reader.GetOrdinal("Name")),
                        Email = reader.GetString(reader.GetOrdinal("Email")),
                        Address = reader.GetString(reader.GetOrdinal("Address")),
                        PhoneNumber = reader.GetString(reader.GetOrdinal("Phone")),
                        NeighborhoodId = reader.GetInt32(reader.GetOrdinal("NeighborhoodId"))
                };
            }

            reader.Close();

            return owner;
        }
    }
}
```

> Get a list of owner's dogs

```csharp
private List<Dog> GetDogsByOwner(int ownerId)
{
    using(SqlConnection conn = Connection)
    {
        conn.Open();

        using(SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"
                SELECT Id, Name, Breed, Notes, ImageUrl
                FROM Dog
                WHERE OwnerId = @ownerId
            ";

            cmd.Parameters.AddWithValue("@ownerId", ownerId);

            SqlDataReader reader = cmd.ExecuteReader();

            List<Dog> dogs = new List<Dog>();

            while (reader.Read())
            {
                Dog dog = new Dog()
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        Name = reader.GetString(reader.GetOrdinal("Name")),
                        Breed = reader.GetString(reader.GetOrdinal("Breed")),
                        Notes = reader.GetString(reader.GetOrdinal("Notes")),
                        ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                };

                dogs.Add(dog);
            }

            reader.Close();

            return dogs;
        }
    }
}
```

> Get a list of walkers in a neighborhood

```csharp
private List<Walker> GetWalkersByNeighborhood(int neighborhoodId)
{
    using(SqlConnection conn = Connection)
    {
        conn.Open();

        using(SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"
                SELECT Id, Name, ImageUrl
                FROM Walker
                WHERE NeighborhoodId = @neighborhoodId
            ";

            cmd.Parameters.AddWithValue("@neighborhoodId", neighborhoodId);

            SqlDataReader reader = cmd.ExecuteReader();

            List<Walker> walkers = new List<Walker>();

            while (reader.Read())
            {
                Walker walker = new Walker()
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        Name = reader.GetString(reader.GetOrdinal("Name")),
                        ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                };

                walkers.Add(walker);
            }

            reader.Close();

            return walkers;
        }
    }
}
```

Now let's use these helper methods in the `Index` action to fill out our ProfileViewModel

```csharp
// GET: Dogs
public ActionResult Index()
{
    int ownerId = GetCurrentUserId();

    Owner owner = GetOwnerDetails(ownerId);
    List<Dog> dogs = GetDogsByOwner(ownerId);
    List<Walker> walkers = GetWalkersByNeighborhood(owner.NeighborhoodId);

    ProfileViewModel vm = new ProfileViewModel()
    {
        Owner = owner,
        Dogs = dogs,
        Walkers = walkers
    };

    return View(vm);
}
```

Try running the application now and going to `/dogs` while logged in. You should see this error message

```
InvalidOperationException: The model item passed into the ViewDataDictionary is of type 'DogWalker.Models.ViewModels.ProfileViewModel', but this ViewDataDictionary instance requires a model item of type 'System.Collections.Generic.IEnumerable`1[DogWalker.Models.Dog]'
```

This is because the controller is now passing the view an instance of `ProfileViewModel` but the view is still expecting an `IEnumerable<Dog>`. Fix this by changing the first line of `Index.cshtml` to this

```html+razor
@model DogWalker.Models.ViewModels.ProfileViewModel
```

Now replace the rest of the view with the following code

```html+razor
@model DogWalker.Models.ViewModels.ProfileViewModel @{ ViewData["Title"] =
"Profile"; }
<div>
  <h1 class="mb-4">@Model.Owner.Name</h1>

  <section class="container">
    <img
      style="width:100px;float:left;margin-right:20px"
      src="https://upload.wikimedia.org/wikipedia/commons/a/a0/Font_Awesome_5_regular_user-circle.svg"
    />
    <div>
      <label class="font-weight-bold">Address:</label>
      <span>@Model.Owner.Address</span>
    </div>
    <div>
      <label class="font-weight-bold">Phone:</label>
      <span>@Model.Owner.PhoneNumber</span>
    </div>
    <div>
      <label class="font-weight-bold">Email:</label>
      <span>@Model.Owner.Email</span>
    </div>
  </section>

  <hr class="mt-5" />
  <div class="clearfix"></div>

  <div class="row">
    <section class="col-8 container mt-5">
      <h1 class="text-left">Dogs</h1>

      <div class="row">
        @foreach (Dog dog in Model.Dogs) {
        <div class="card m-4" style="width: 18rem;">
          @if (dog.ImageUrl == null) {
          <img
            src="https://cdn.pixabay.com/photo/2018/08/15/13/12/dog-3608037_960_720.jpg"
            class="card-img-top"
            alt="Doggo"
          />
          } else {
          <img src="@dog.ImageUrl" class="card-img-top" alt="Doggo" />
          }
          <div class="card-body">
            <div>
              <label class="font-weight-bold">Name:</label>
              <span>@dog.Name</span>
            </div>
            <div>
              <label class="font-weight-bold">Breed:</label>
              <span>@dog.Breed</span>
            </div>
            <div>
              <label class="font-weight-bold">Notes:</label>
              <p>@dog.Notes</p>
            </div>
          </div>
        </div>
        }
      </div>
    </section>

    <section class="col-lg-4 col-md-8 container mt-5">
      <h1>Walkers Near Me</h1>

      <ul class="list-group mt-4">
        @foreach (Walker walker in Model.Walkers) {
        <li class="list-group-item disabled" aria-disabled="true">
          <img src="@walker.ImageUrl" style="width:50px" />
          <span class="font-weight-bold ml-4">@walker.Name</span>
        </li>
        }
      </ul>
    </section>
  </div>
</div>
```

## Using View Models with Forms

Currently the Create and Edit forms for Owners have a text input field to collect an owner's neighborhood Id. It was mentioned ealier that we'd ideally like to have that be a dropdown list instead. We can make this happen with view models. Once again, lets think about what we'd need to have in _state_ if this were a React application. 

- properties for all the Owner form fields
- a list of available options for the dropdown

Create a new class inside the ViewModels folder and name it `OwnerFormViewModel`. Add the following code

```csharp
using System.Collections.Generic;

namespace DogWalker.Models.ViewModels
{
    public class OwnerFormViewModel
    {
        public Owner Owner { get; set; }
        public List<Neighborhood> Neighborhoods { get; set; }
    }
}
```

Now inside `OwnersController` add the following helper method that will get us a list of all the neighborhoods in the database.

```csharp
private List<Neighborhood> GetNeighborhoods()
{
    using (SqlConnection conn = Connection)
    {
        conn.Open();
        using (SqlCommand cmd = conn.CreateCommand())
        {
            cmd.CommandText = @"SELECT Id, Name FROM Neighborhood";

            SqlDataReader reader = cmd.ExecuteReader();

            List<Neighborhood> neighborhoods = new List<Neighborhood>();

            while (reader.Read())
            {
                Neighborhood neighborhood = new Neighborhood()
                {
                    Id = reader.GetInt32(reader.GetOrdinal("Id")),
                    Name = reader.GetString(reader.GetOrdinal("Name"))
                };
                neighborhoods.Add(neighborhood);
            }

            reader.Close();

            return neighborhoods;
        }

    }
}
```

Update the GET `Create` method to now create a view model and pass it to the view

```csharp
// GET: Owners/Create
public ActionResult Create()
{
    OwnerFormViewModel vm = new OwnerFormViewModel();

    vm.Neighborhoods = GetNeighborhoods();
    vm.Owner = new Owner();

    return View(vm);
}
```

Now update the view to accept an instance of an `OwnerFormViewModel` and change the NeighborhoodId field from an `<input>` to a `<select>` 

```csharp
@model DogWalker.Models.ViewModels.OwnerFormViewModel

@{
    ViewData["Title"] = "Create";
}

<h1>Create</h1>

<h4>Owner</h4>
<hr />
<div class="row">
    <div class="col-md-4">
        <form asp-action="Create">
            <div asp-validation-summary="ModelOnly" class="text-danger"></div>
            <div class="form-group">
                <label asp-for="Owner.Email" class="control-label"></label>
                <input asp-for="Owner.Email" class="form-control" />
                <span asp-validation-for="Owner.Email" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="Owner.Name" class="control-label"></label>
                <input asp-for="Owner.Name" class="form-control" />
                <span asp-validation-for="Owner.Name" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="Owner.PhoneNumber" class="control-label"></label>
                <input asp-for="Owner.PhoneNumber" class="form-control" />
                <span asp-validation-for="Owner.PhoneNumber" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="Owner.Address" class="control-label"></label>
                <input asp-for="Owner.Address" class="form-control" />
                <span asp-validation-for="Owner.Address" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="Owner.NeighborhoodId" class="control-label"></label>
                <select asp-for="Owner.NeighborhoodId" class="form-control">
                    <option value="">Select Neighborhood</option>
                    @foreach (Neighborhood neighborhood in Model.Neighborhoods)
                    {
                        <option value="@neighborhood.Id">@neighborhood.Name</option>
                    }
                </select>
                <span asp-validation-for="Owner.NeighborhoodId" class="text-danger"></span>
            </div>
            <div class="form-group">
                <input type="submit" value="Create" class="btn btn-primary" />
            </div>
        </form>
    </div>
</div>

<div>
    <a asp-action="Index">Back to List</a>
</div>
```

## Exercise

1. Update the `/owner/edit/{id}` route to use the `OwnerFormViewModel` so that the Neighborhood Id uses a dropdown instead of an input. field. 

1. Try to implement the following design for the walker details page at `/walkers/details/{id}`. Hint: Use the `DateTime` class to help format the date strings.

![](./images/DW_Walker_Snapshot.png)
