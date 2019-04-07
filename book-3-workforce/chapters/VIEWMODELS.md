# View Models

The first line in any Razor template that uses data from your database is a reference to the type of data that the view will render. In the code below, `@model StudentExercisesAPI.Data.Student` is the view model. This allows ASP.NET to use that class to display data in the correct format, and validate user input (_if needed_).

```cs
@model StudentExercisesAPI.Data.Student

@{
    ViewData["Title"] = "Student Details";
}

<h2>@ViewData["Title"]</h2>

<div>
    <hr />
    <dl class="dl-horizontal">
        <dt>
            @Html.DisplayNameFor(model => model.FirstName)
        </dt>
        <dd>
            @Html.DisplayFor(model => model.FirstName)
        </dd>
        <dt>
            @Html.DisplayNameFor(model => model.LastName)
        </dt>
        <dd>
            @Html.DisplayFor(model => model.LastName)
        </dd>
        <dt>
            @Html.DisplayNameFor(model => model.SlackHandle)
        </dt>
        <dd>
            @Html.DisplayFor(model => model.SlackHandle)
        </dd>
    </dl>
</div>
<div>
    @Html.ActionLink("Edit", "Edit", new { id = Model.Id }) |
    <a asp-action="Index">Back to List</a>
</div>
```

Since Razor views are strongly typed by the view model, imagine that your product owner wants a view in the application that lists all students, and all instructors. Which type do you already have in your system that holds an `IEnumerable<Student>` and `IEnumerable<Instructor>`?

You don't. Therefore, you need to create a new, custom view model for that particular Razor template.

Create a new directory inside your `Models` directory named `ViewModels`. Then create a new class inside that directory named `StudentInstructorViewModel.cs`. Then place the following code inside of it. Then use the light bulb assistant to resolve all of your red squiggles.

```cs
namespace StudentExercises.Models.ViewModels
{
    public class StudentInstructorViewModel
    {

        public IEnumerable<Student> Students { get; set; }
        public IEnumerable<Instructor> Instructors { get; set; }

        private string _connectionString;

        private SqlConnection Connection
        {
            get
            {
                return new SqlConnection(_connectionString);
            }
        }

        public StudentInstructorViewModel(string connectionString)
        {
            _connectionString = connectionString;
            GetAllStudents();
            GetAllInstructors();
        }

        private void GetAllStudents ()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                        SELECT
                            Id,
                            FirstName,
                            LastName,
                            SlackHandle
                        FROM Student";
                    SqlDataReader reader = cmd.ExecuteReader();

                    Students = new List<Student>();
                    if (reader.Read())
                    {
                        Students.Add(new Student {
                            Id = reader.GetString(reader.GetOrdinal("Id")),
                            FirstName = reader.GetString(reader.GetOrdinal("FirstName")),
                            LastName = reader.GetString(reader.GetOrdinal("LastName")),
                            SlackHandle = reader.GetString(reader.GetOrdinal("SlackHandle")),
                        });
                    }

                    reader.Close();
                }
            }
        }

        private void GetAllInstructors ()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"
                            SELECT
                            Id,
                            FirstName,
                            LastName,
                            SlackHandle,
                            Specialty
                        FROM Instructor";
                    SqlDataReader reader = cmd.ExecuteReader();

                    Instructors = new List<Instructor>();
                    if (reader.Read())
                    {
                        Instructors.Add(new Instructor {
                            Id = reader.GetString(reader.GetOrdinal("Id")),
                            FirstName = reader.GetString(reader.GetOrdinal("FirstName")),
                            LastName = reader.GetString(reader.GetOrdinal("LastName")),
                            SlackHandle = reader.GetString(reader.GetOrdinal("SlackHandle")),
                            Specialty = reader.GetString(reader.GetOrdinal("Specialty")),
                        });
                    }

                    reader.Close();
                }
            }
        }
    }
}
```

You now have a new view model whose specific purpose is to hold data for a Razor template that will list all students and all instructors. Open your _Views > Home > Index.cshtml_ file and place the following code into it.

```cs
@model StudentExercises.Models.ViewModels.StudentInstructorViewModel

@{
    ViewData["Title"] = "Students &amp; Instructors";
}

<h2>@ViewData["Title"]</h2>

<h4>Students</h4>

<table class="table">
    <thead>
        <tr>
            <th> Student Name </th>
        </tr>
    </thead>
    <tbody>
        @foreach (var student in Model.Students) {
        <tr>
            <td>
                @Html.DisplayFor(modelItem => student.FirstName)
                @Html.DisplayFor(modelItem => student.LastName)
            </td>
        </tr>
        }
    </tbody>
</table>

<h4>Instructors</h4>

<table class="table">
    <thead>
        <tr>
            <th> Instructor Name </th>
        </tr>
    </thead>
    <tbody>
        @foreach (var instructor in Model.Instructors) {
        <tr>
            <td>
                @Html.DisplayFor(modelItem => instructor.FirstName)
                @Html.DisplayFor(modelItem => instructor.LastName)
            </td>
        </tr>
        }
    </tbody>
</table>
```

## Creating a Student

To create a new student, you need data from two tables

* Student - Display the form fields to accept user input for all of the student properties.
* Cohort - A `<select>` element to list all cohorts so that the student can be assigned to one.

Here's how you would implement a view model to store that information for the Razor template to use.

```cs
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Configuration;
using StudentExercisesAPI.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;


namespace StudentExercises.Models.ViewModels
{
    public class StudentCreateViewModel
    {
        public List<SelectListItem> Cohorts { get; set; }
        public Student student { get; set; }

        private string _connectionString;

        private SqlConnection Connection
        {
            get
            {
                return new SqlConnection(_connectionString);
            }
        }

        public StudentCreateViewModel() { }

        public StudentCreateViewModel(string connectionString)
        {
            _connectionString = connectionString;

            Cohorts = GetAllCohorts()
                .Select(li => new SelectListItem
                {
                    Text = li.Name,
                    Value = li.Id.ToString()
                })
                .ToList()
                .Insert(0, new SelectListItem
                {
                    Text = "Choose cohort...",
                    Value = "0"
                });
        }

        private List<Cohort> GetAllCohorts ()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT Id, Name FROM Cohort";
                    SqlDataReader reader = cmd.ExecuteReader();

                    List<Cohort> cohorts = new List<Cohort>();
                    if (reader.Read())
                    {
                        cohorts.Add(new Cohort {
                            Id = reader.GetString(reader.GetOrdinal("Id")),
                            Name = reader.GetString(reader.GetOrdinal("Name")),
                        });
                    }

                    reader.Close();

                    return cohorts;
                }
            }
        }
    }
}
```

This view model will automatically store a list of all cohorts when it's constructed by the controller. They are in a list of `SelectListItem`, which the ASP.NET representation of an `<option>` element that is a child of a `<select>`. Now you can use this view model in the student creation Razor template at _`Views > Students > Create.cshtml`_.

```cs
@model StudentExercises.Models.ViewModels.StudentCreateViewModel

@{
    ViewData["Title"] = "Create Student";
}

<h2>@ViewData["Title"]</h2>

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
            <div class="form-group">
                <label asp-for="Cohorts" class="control-label"></label>
                <select asp-for="student.CohortId" asp-items="@Model.Cohorts"></select>
            </div>
            <div class="form-group">
                <input type="submit" value="Create" class="btn btn-default" />
            </div>
        </form>
    </div>
</div>

<div>
    <a asp-action="Index">Back to List</a>
</div>

@section Scripts {
    @{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
}
```

One special thing you should note in this template is the tag helper for `<select>`.

```html
<select asp-for="student.CohortId" asp-items="@Model.Cohorts"></select>
```

This helper builds an `<option>` for each item in the `StudentCreateViewModel.Cohorts` list.

```html
<select name="student_Cohort">
    <option value="1">Day cohort 10</option>
    <option value="2">Day cohort 11</option>
    <option value="3">Day cohort 12</option>
    <option value="4">Day cohort 13</option>
    <option value="5">Day cohort 14</option>
</select>
```

## Capturing the Form Fields

Once the user fills out all of the form fields, and submits the form, your controller must capture those form fields and create a new instance in memory to hold all of them, so that you can insert the values into your database. In the code below, notice that the argument is not `Student student` as you might assume, it's the view model `StudentCreateViewModel model`.

Since the view model was used to provide data for the form to use, you must capture for form data back into a new instance of that view model.

```cs
// POST: Students/Create
[HttpPost]
[ValidateAntiForgeryToken]
public async Task<ActionResult> Create(StudentCreateViewModel model)
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
            cmd.Parameters.Add(new SqlParameter("@firstName", model.student.FirstName));
            cmd.Parameters.Add(new SqlParameter("@lastName", model.student.LastName));
            cmd.Parameters.Add(new SqlParameter("@slackHandle", model.student.SlackHandle));
            cmd.Parameters.Add(new SqlParameter("@cohortId", model.student.CohortId));
            cmd.ExecuteNonQuery();

            return RedirectToAction(nameof(Index));
        }
    }
}
```
