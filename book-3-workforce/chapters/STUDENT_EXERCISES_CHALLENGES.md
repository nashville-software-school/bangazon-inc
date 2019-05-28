# Additional Challenges for Student Exericses

* Add a `boolean` column to the `StudentExercise` join table called "IsCompleted"
    > Hint: this will need to be added to your Model in C# and to the Azure Data Studio table
* Run some `UPDATE` SQL statements to mark some of the exercises as complete.
* Report for each exercise, how many students have completed it?
* For each exercise that has been assigned to any student(s), produce a report that how many student completed it.
* For each exercise that has been assigned to any student(s), produce a report that shows which percentage of students have completed it.
* Produce a report that list students that have completed 0 exercises.
* Produce a report page that lists all cohorts, and for each one, which students and instructors are assigned to it.

## Advanced Challenge: Completed Exercises

You will need update your `site.js` file to include custom JavaScript event handlers on checkboxes here.

* Update the Student detail view to list all currently assigned exercises that are incomplete
* Make sure each exercise has a checkbox next to it
* When user clicks one of the checkboxes, that specific exercise must immediately be marked as complete
