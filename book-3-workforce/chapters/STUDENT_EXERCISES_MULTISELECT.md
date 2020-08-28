# Student Exercises MVC Enhancements

Once you have finished CRUD for at least two of your resources, you have two options:

1) Continue to practice CRUD for all resources
2) Work on some of these enhancements. These are ordered from least to most challenging. You can start at the beginning and work through, or skip around.

## Show students and their cohort
When a user sees the list of students, they should see the student's cohort name instead of cohort Id.

## Show exercises a student is working on
When a user clicks on a student to see their details, they should see a list of all the exercises that student is currently working on.

## Show number of students and instructors in a cohort
When a user views a list of cohorts, the user should see the cohort name, the number of instructors in that cohort, and the number of students in that cohort.

## Search for students
When a user views a list of students, they should see a search bar at the top of the page. When they enter a student's first name or last name in the search bar, only students who match that criteria should appear in the list.

## Multi-select for Many-to-Many

Modify your student edit form to display all exercises in a multi-select element. The user should be able to select one, or more exercises, in that element. When the user submits the form, then the `StudentExercises` table in your database should have a new entry added for each of the exercises that were selected in the form.

