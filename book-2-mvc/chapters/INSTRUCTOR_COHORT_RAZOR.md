# Assigning Cohort to Instructor

## Editing an Instructor

> **Note:** You will need a custom view model for this task _(e.g. `InstructorEditViewModel`)_

Modify your Instructor edit form to display all cohorts in a select element. The user should be able to select one of the cohorts in the dropdown. When the user submits the form, then the corresponding row in the `Instructor` table in your database should have its `CohortId` column value updated.

## Details

When you view the details of an instructor, it should display the name of the cohort she is currently teaching.

## Starter Code

### ViewModel Starter Code

```cs
namespace StudentExerciseMVC.Models.ViewModels
{
    public class InstructorEditViewModel
    {
        private readonly IConfiguration _config;

        public List<SelectListItem> Cohorts { get; set; }
        public Instructor Instructor { get; set; }

        public InstructorEditViewModel() { }

        public InstructorEditViewModel(IConfiguration config)
        {

            /*
                Query the database to get all cohorts
            */


            /*
                Use the LINQ .Select() method to convert
                the list of Cohort into a list of SelectListItem
                objects
            */
        }
    }
}
```

### Controller Starter Code

```cs
// GET: Instructors/Edit/5
[HttpGet]
public async Task<ActionResult> Edit(int id)
{
    string sql = $@"
    SELECT
        i.Id,
        i.FirstName,
        i.LastName,
        i.SlackHandle,
        i.CohortId
    FROM Instructor i
    WHERE i.Id = {id}
    ";

    /*
        Run the query above and create an instance of Instructor
        populated with the data it returns
     */

     /*
        Create an instance of your InstructorEditViewModel
      */

    /*
        Assign the instructor you created to the .Instructor
        property of your view model
     */

    return View(viewModel);
}
```

### Razor Template Starter Code

Use the follow tag helper in your Razor template for instructor edit.

```html
<div class="form-group">
    <label asp-for="Cohorts" class="control-label"></label>
    <select asp-for="Instructor.CohortId" asp-items="@Model.Cohorts"></select>
</div>
```
