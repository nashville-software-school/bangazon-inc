# Assigning Cohorts in the Edit View


## Editing an Instructor


Modify your Instructor edit form to display all cohorts in a select element. The user should be able to select one of the cohorts in the dropdown. When the user submits the form, then the corresponding row in the `Instructor` table in your database should have its `CohortId` column value updated.

## Starter Code

> Note: we can use the same view model for editing an instructor as we did for creating an instructor. The info that we need is the same-- all of the cohorts, and info about a single instructor. 

### Controller Starter Code

```cs
// GET: Instructors/Edit/5
// This method loads the edit form
[HttpGet]
public async Task<ActionResult> Edit(int id)
{
   
    /*
        STEP ONE
        A user needs to see form fields pre-populated with the info from the instructor they wanted to edit
        That means we need to run a SQL query to SELECT an instructor by its id
        (The id comes from the route! For example, if the route is Students/Edit/5 we'll use the id of 5 to go get the correct student from the database
     */
     
     /*
       STEP TWO
        Once we have our instructor from the database, we need to map it to our Instructor model
        Then we need to assign our new instance of an instructor (which we got from our db) to the Instructor property on our view model
     */
     
     /*
      STEP THREE
        A user also needs to see a dropdown of all the cohorts
        That means we need to run a SECOND SQL query to get all the cohorts from the database
     */
     
      /*
      STEP FOUR
        Map the cohorts from the database into a list of SelectListItems and attach them to your view model (we did the same thing in our Create method)
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

## Editing a student
1. Now add the same functionality for students.
1. You will need to create a `StudentEditViewModel`.
1. When you edit a student, you should see a dropdown of all cohorts. The student's current cohort should be auto-selected.
1. You should be able to select any cohort from the dropdown to reassign a student to a different cohort.


## Challenge
1. Modify the Details view for instructors and cohorts so that it shows the name of the cohort they're assigned to instead of the id.
