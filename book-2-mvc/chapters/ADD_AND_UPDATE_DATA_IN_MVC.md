# Adding and Updating Data with MVC

In this chapter you'll continue to implement CRUD for the DogGo application by adding Create, Edit, and Delete routes for our dog owners.

As part of the exercises in the previous chapter, you should have already created an OwnerRepository that has a method for getting all owners and getting a single owner by Id. We'll need additional CRUD functionality in the repository for this chapter, so update OwnerRepository to have the following code

```csharp
using DogGo.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace DogGo.Repositories
{
    public class OwnerRepository
    {
        private readonly IConfiguration _config;

        // The constructor accepts an IConfiguration object as a parameter. This class comes from the ASP.NET framework and is useful for retrieving things out of the appsettings.json file like connection strings.
        public OwnerRepository(IConfiguration config)
        {
            _config = config;
        }

        public SqlConnection Connection
        {
            get
            {
                return new SqlConnection(_config.GetConnectionString("DefaultConnection"));
            }
        }

        public Owner GetOwnerById(int id)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();

                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT Id, [Name], Email, Address, Phone, NeighborhoodId
                        FROM Owner
                        WHERE Id = @id";

                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Owner owner = new Owner()
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            Email = reader.GetString(reader.GetOrdinal("Email")),
                            Address = reader.GetString(reader.GetOrdinal("Address")),
                            PhoneNumber = reader.GetString(reader.GetOrdinal("Phone")),
                            NeighborhoodId = reader.GetInt32(reader.GetOrdinal("NeighborhoodId"))
                        };

                        reader.Close();
                        return owner;
                    }

                    reader.Close();
                    return null;
                }
            }
        }

        public Owner GetOwnerByEmail(string email)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();

                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT Id, [Name], Email, Address, Phone, NeighborhoodId
                        FROM Owner
                        WHERE Email = @email";

                    cmd.Parameters.AddWithValue("@email", email);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Owner owner = new Owner()
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                            Email = reader.GetString(reader.GetOrdinal("Email")),
                            Address = reader.GetString(reader.GetOrdinal("Address")),
                            PhoneNumber = reader.GetString(reader.GetOrdinal("Phone")),
                            NeighborhoodId = reader.GetInt32(reader.GetOrdinal("NeighborhoodId"))
                        };

                        reader.Close();
                        return owner;
                    }

                    reader.Close();
                    return null;
                }
            }
        }

        public void AddOwner(Owner owner)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                    INSERT INTO Owner ([Name], Email, Phone, Address, NeighborhoodId)
                    VALUES (@name, @email, @phoneNumber, @address, @neighborhoodId);
                ";

                    cmd.Parameters.AddWithValue("@name", owner.Name);
                    cmd.Parameters.AddWithValue("@email", owner.Email);
                    cmd.Parameters.AddWithValue("@phoneNumber", owner.PhoneNumber);
                    cmd.Parameters.AddWithValue("@address", owner.Address);
                    cmd.Parameters.AddWithValue("@neighborhoodId", owner.NeighborhoodId);

                    int id = (int)cmd.ExecuteScalar();

                    owner.Id = id;
                }
            }
        }

        public void UpdateOwner(Owner owner)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();

                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                            UPDATE Owner
                            SET 
                                [Name] = @name, 
                                Email = @email, 
                                Address = @address, 
                                Phone = @phone, 
                                NeighborhoodId = @neighborhoodId
                            WHERE Id = @id";

                    cmd.Parameters.AddWithValue("@name", owner.Name);
                    cmd.Parameters.AddWithValue("@email", owner.Email);
                    cmd.Parameters.AddWithValue("@address", owner.Address);
                    cmd.Parameters.AddWithValue("@phone", owner.PhoneNumber);
                    cmd.Parameters.AddWithValue("@neighborhoodId", owner.NeighborhoodId);
                    cmd.Parameters.AddWithValue("@id", owner.Id);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void DeleteOwner(int ownerId)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();

                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                            DELETE FROM Owner
                            WHERE Id = @id
                        ";

                    cmd.Parameters.AddWithValue("@id", ownerId);

                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
```

## Creating an Owner

Let's build out a form for us to be able to add a new Owner. Open the DogGo application you created in the previous chapter, go to the Owner controller, and find the `Create` action. You might notice...there are two Create methods! How can this be? Think about interactions we have in real life involving filling out forms. Doctors' visits comes to mind... When you go to the doctor, you're likely to have 2 interactions with a person behind the counter. The first interaction is when you go to the receptionist and ask for a blank form. The receptionist gives you the form so you can go back to your chair and fill it out. Once you're done, you can go back up to the counter and give that form back so they can process it. This is the same sort of interaction end users have with a server. Notice the comments above the two `Create` methods--one says GET and the other says POST. When a user navigates to the url `/walkers/create`, they are making a GET request to that url. This is the request that will give the user the html of the empty form. When the user clicks a "submit" button, that is going to make a POST request to the same url. 

Go to the `Create` action for the GET request. Currently all it does is return a View. Since the only thing the server needs to do is hand the user a blank html form, this is actually fine. The only thing we have to do is create that html form. Right click the "Create" method name and select "Add View". Name the view "Create", give it the template of "Create", and the model class Owner

### Building the form

Let's first look at a couple things about this form. 

##### asp-for

```html
<label asp-for="Owner.Email" class="control-label"></label>
<input asp-for="Owner.Email" class="form-control" />
```

The `asp-for` attribute is something we get from ASP.<span>NET</span> and razor. When the attribute is on a `<label>` element, the generated html will be whatever the property name is. In the example here, the label will literally have the word "Email" in it. The resulting html will look like this

```html
<label for="Email" class="control-label">Email</label>
```

When the `asp-for` attribute is on an `<input>` element, it will generate html attributes that will allow us to know later on that the value for this input field should be set as an owner's email address.


##### asp-action

```html
<form asp-action="Create">
```

All of our input elements should be inside a form. The `asp-for` attribute is added to the form element to specify which controller action should be called when the form gets submitted. The the contents of the form we're building here should be submitted to the `Create` method in our controller.

##### Update the form

The view that visual studio creates for us is a good start, but we have to modify it at least a little bit. For starters, it added an input field for the user to enter in an ID. Users don't chose their own Ids--the database does--so we can remove the form goup div that has the Id input in it. 

There is currently an input field for the user to enter a Neighborhood Id into. It's doubtful the user knows the actual Id of the neighborhood they are in--ideally this would be replaced by a dropdown of possible neighborhood options. We'll do that in a later chapter.

Run the application and go to `localhost:5001/walkers/create` to see the form. You can try to submit it, but it won't do anything yet...

### Submitting the form

When the user hits the "Create" button, the browser is going to make a POST request to the url `/walkers/create`. In the body of that request will be the contents of the form. Go into the Owners controller and find the `Create` method that handles the POST. The method is currently set up to accept a paramter of type `IFormCollection`, but we know that the thing we are actually sending to the server is an Owner object. Change the method signature to look like the following

```csharp
public ActionResult Create(Owner owner)
```

We're seeing here another piece of magic we get from the ASP<span>.NET<span> framework. The framework knows how to _bind_ values it gets from html forms fields to C# objects.

Update the `Create` method in the OwnersController so that it inserts the new owner.

```csharp
// POST: Owners/Create
[HttpPost]
[ValidateAntiForgeryToken]
public ActionResult Create(Owner owner)
{
    try
    {
        _ownerRepo.AddOwner(owner);

        return RedirectToAction("Owners");
    }
    catch(Exception ex)
    {
        return View(owner);
    }
}
```

A couple things to note here. First, if everthing goes as expected and the new user gets entered into the database, we redirect the user back to `/owners/index`. Second, if some exception gets thrown, we want to return the same view the user on so they can try again.

Run the application and submit the form. The new owner should be added to the database.


## Deleting an owner

In your owner controller, find the delete methods. Again, you'll notice that there are two methods--one for GET and another for POST. The GET method assumes you'd like to create a view that asks the user to confirm the deletion. Notice that the GET method for `Delete` accepts an `int id` parameter. ASP.<span>NET<span> will get this value from the route. i.e. `owners/delete/5` suggests that the user is attempting to delete the owner with Id of 5. Let's assume that owner with the Id of 5 is Mo Silvera. We want the view to have some text on it that says "Are you sure you want to delete the owner Mo Silvera?". To be able to generate this text, we'll have to get Mo's name from the database.

Update your `Delete` method in the OwnerController to the following:

> OwnersController.cs
```csharp
// GET: Owners/Delete/5
public ActionResult Delete(int id)
{
    Owner owner = _ownerRepo.GetOwnerById(id);

    return View(owner);
}
```

Now create the view by right clicking the method name and selecting Add View. Keep the name of the template "Delete", choose "Delete" from the template dropdown, and set the model to Owner.

Instead of having the text say "Are you sure you want to delete this?", change it to include the name of the owner.

```html+razor
<h3>Are you sure you want to delete @Model.Name?</h3>
```

Run the application and go to `owners/delete/3` to view the delete confirmation page. 

If the user clicks the delete button, a POST request will be made to `/owners/delete/3`.

Update the POST `Delete` method in the controller to the following

> OwnerController.cs
```csharp
// POST: Owners/Delete/5
[HttpPost]
[ValidateAntiForgeryToken]
public ActionResult Delete(int id, Owner owner)
{
    try
    {
        _ownerRepo.DeleteOwner(id);

        return RedirectToAction("Index");
    }
    catch(Exception ex)
    {
        return View(owner);
    }
}
```


## Editing an owner

Editing an owner is similar to creating an owner except when the user gets the form, it should be pre-popolated with the current data. Once again, the controller will get an owner id from the url route (i.e `/owner/edit/2`). We can use that Id to get the current data from the database and use it to fill out the initial state of the form. Find the GET method for `Edit` and update it with the following

```csharp
// GET: Owners/Edit/5
public ActionResult Edit(int id)
{
    Owner owner = _ownerRepo.GetOwnerById(id);

    if (owner == null)
    {
        return NotFound();
    }

    return View(owner);
}
```

Now update the POST method for `Edit`. This is similar to `Create` except we are updating the database instead of inserting into.

```csharp
// POST: Owners/Edit/5
[HttpPost]
[ValidateAntiForgeryToken]
public ActionResult Edit(int id, Owner owner)
{
    try
    {
        _ownerRepo.UpdateOwner(owner);

        return RedirectToAction("Index");
    }
    catch(Exception ex)
    {
        return View(owner);
    }
}
```

Now create the view for Edit by right clicking the method name and going through the same steps. 

Same as before, we don't want to give the user a form field for the Id--users should be able to update their Ids. You can try removing the input like we did before with the `Create` view, but that won't work this time. Give it a try anyway...

Put a breakpoint in your controller code so you can inspect the owner object that gets passed as a parameter. Notice that the Id of the owner is now zero. The reason for this is that we took the Id field out of the form, so when it got posted back up to the server, it didn't have an Id value so C# defaults that value to zero. 

The trick is to _hide_ the input field in the view, but keep it in the form. Put the Id input field back in the form and give it a `type=hidden` attribute, and delete the `<label>` and `<span>` tags.

```html
<div class="form-group">
    <input asp-for="Id" type="hidden" class="form-control" />
</div>
```

## Exercise

Create a model for `Dog` and implement a `DogRepository` and `DogController` that gives users the following functionality:

- View a list of all Dogs
- Create a new Dog (for now, capture the OwnerId as simple input field)
- Edit a Dog
- Delete a Dog
