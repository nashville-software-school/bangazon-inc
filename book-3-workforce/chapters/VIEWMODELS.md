# View Models

So far we've created views that really only need to use one type. For example: 
1. The `Index` view for students gets a list of type `Student`
1. The `Details` view for students gets a single instance of a `Student`
1. The `Edit` and `Delete` views for student are also concerned with a single instance of a student

This is great, becasue our views are _strictly typed_. Remember that line at the top of our Razor remplate?

```html+razor
@model StudentExercises.Models.Student
```

That tells us what type the view will render. 

Now let's imagine some other scenarios:
1. We might want a directory page where we list _all_ of the students and _all_ of the instructors
1. When we assign exercises to students, we might want to see a single student's information and _all_ of the exercises that we could assign to them
1. When we create or edit a student, we'll want to see that student's info _and_ a list of all the cohorts so we can assign them to a cohort

In these scenarios, we run into a problem: our views are strictly typed, but we need to show the user multiple types at once. Oh no! Fear not. In these scenarios, we just need to make a view model. 

### View Models to the Rescue

#### When do we need a view model?
We use view models when we need to display something to the user that isn't represented in our normal models, or doesn't reflect a relationship in our database. Take the following examples: 

> Scenario A: We need to view a list of all the instructors and all of the students in a given cohort

> Scenario B: We need to view a list of all the instructors and all of the students at the _entire school_

In scenario A, we can just use our normal `Cohort` type to represent this data. Because both students and instructors have a `CohortId` property, we can add a list of type `Student` and a second list of type `Instructor` on our `Cohort` model.

But what about scenario B? Do we have a model that can hold a list of _all_ the instructors, regardless of their cohort and _all_ of the students, also regardless of their cohort? We do not! There's no relataionship in our database between _all_ of the instructors and _all_ of the students-- just the ones who share a cohort. In this case, we need to build a view model. 

#### What belongson a view model?
Whatever the user needs to see! In scenario B from above, the user needs to see a list of all the instructors and all the students. Our view model might look something like this: 

```c#
public class StudentInstructorViewModel {
  public List<Instructor> AllTheInstructors {get; set;} = new List<Instructor>();
  
  public List<Student> AllTheStudents {get; set;} = new List<Student>();
}
```

#### How do we use them?
Here's an incomplete example to give you a sense:
>`StudentsController.cs`
```c#
// This method will run when the user goes to `students/directory`
public ActionResult Directory(){
  StudentInstructorViewModel viewModel = new StudentInstructorViewModel();
  
  // Insert SQL query here to SELECT all of the students from the DB and store them in the viewModel.AllTheStudents list
  // Insert SQL query here to SELECT all the instructors from the DB and store them in the viewModel.AllTheInstructors list
  
  // Pass the view model into the view
  return View(viewModel)
}
```

### Creating a Student

When we create a student, we need to see a list of _all_ the cohorts in the database so that we can assign our new student to whichever cohort we want. Before we start writing code, let's ask ourselves some questioins:

**1. Do we need a view model for this?**
Yes! We need to show the user form fields for a student and a dropdown of cohorts. We don't currently have a model with a student's info and a list of all the cohorts.

**2. What should be on the view model?**
Well, in this case the user needs to see form fields for a student (which means we need a property of type `Student`) and a dropdown of cohorts. To build the dropdown, we'll build a list of `SelectListItem`s. You can read more about the `SelectListItem` class [here](https://docs.microsoft.com/en-us/dotnet/api/system.web.mvc.selectlistitem?view=aspnet-mvc-5.2).

#### Building our view model
```c#
namespace StudentExercisesMVC.Models.ViewModels
{
    public class StudentViewModel
    {
        public Student student { get; set; }
        
        // This will be our dropdown
        public List<SelectListItem> cohorts { get; set; } = new List<SelectListItem>();
    }
}

```

#### Building our GET controller method for loading the create form
```c#
   // GET: Students/Create
 public ActionResult Create()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    Since we're creating a student, we don't need to pre-fill the property of type Student on our view model-- that will be filled in by whatever the user enters into the form fields! All we have to do is build our dropdown of cohorts. 
                    
                    // Select all the cohorts
                    cmd.CommandText = @"SELECT Cohort.Id, Cohort.Name FROM Cohort";

                    SqlDataReader reader = cmd.ExecuteReader();

                    // Create a new instance of our view model
                    StudentViewModel viewModel = new StudentViewModel();
                    while (reader.Read())
                    {
                      // Map the raw data to our cohort model
                        Cohort cohort = new Cohort
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name"))
                        };
                        
                        // Use the info to build our SelectListItem
                        SelectListItem cohortOptionTag = new SelectListItem()
                        {
                            Text = cohort.Name,
                            Value = cohort.Id.ToString()
                        };
                      
                        // Add the select list item to our list of dropdown options
                        viewModel.cohorts.Add(cohortOptionTag);

                    }

                    reader.Close();
                    
                    
                    // send it all to the view
                    return View(viewModel);
                }
            }
        }
```

#### Building our view
```cshtml
@model StudentExercisesMVC.Models.ViewModels.StudentViewModel
 @*-------------------check out that type!----------------------*@

@{
    ViewData["Title"] = "Create";
}

<h1>Create</h1>

<h4>Student</h4>
<hr />
<div class="row">
    <div class="col-md-4">
        <form asp-action="Create">
            <div asp-validation-summary="ModelOnly" class="text-danger"></div>
            
            <div class="form-group">
                <label asp-for="student.FirstName" class="control-label"></label>
                <input asp-for="student.FirstName" class="form-control" />
                <span asp-validation-for="student.FirstName" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="student.LastName" class="control-label"></label>
                <input asp-for="student.LastName" class="form-control" />
                <span asp-validation-for="student.LastName" class="text-danger"></span>
            </div>
            <div class="form-group">
                <label asp-for="student.SlackHandle" class="control-label"></label>
                <input asp-for="student.SlackHandle" class="form-control" />
                <span asp-validation-for="student.SlackHandle" class="text-danger"></span>
            </div>
            @*-------------------THIS IS OUR DROPDOWN!----------------------*@
            <div class="form-group">
                <label asp-for="student.CohortId" class="control-label"></label>
                <select asp-for="student.CohortId" asp-items="@Model.cohorts"></select>
                <span asp-validation-for="student.CohortId" class="text-danger"></span>
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
#### Capturing user input when the user clicks submit
When the user clicks submit, it will send a `POST` request to the `students/create` route, which means this method will run: 
```c#
  [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(StudentViewModel viewModel)
        {
            try
            {
                using (SqlConnection conn = Connection)
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandText = @"INSERT INTO Student
                ( FirstName, LastName, SlackHandle, CohortId )
                VALUES
                ( @firstName, @lastName, @slackHandle, @cohortId )";
                        cmd.Parameters.Add(new SqlParameter("@firstName", viewModel.student.FirstName));
                        cmd.Parameters.Add(new SqlParameter("@lastName", viewModel.student.LastName));
                        cmd.Parameters.Add(new SqlParameter("@slackHandle", viewModel.student.SlackHandle));
                        cmd.Parameters.Add(new SqlParameter("@cohortId", viewModel.student.CohortId));
                        cmd.ExecuteNonQuery();

                        return RedirectToAction(nameof(Index));
                    }
                }
            }
            catch
            {
                return View();
            }
        }
  ```




