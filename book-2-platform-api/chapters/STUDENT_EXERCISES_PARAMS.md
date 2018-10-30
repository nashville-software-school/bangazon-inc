# Student Exercises - Using Query String Parameters

## Practice

1. Student JSON response should have all exercises that are assigned to them if the `include=exercise` query string parameter is there.
1. Exercise JSON response should all currently assigned students if the `include=students` query string parameter is there.
1. Provide support for each resource (Instructor, Student, Cohort, Exercise) and the `q` query string parameter. If it is provided, your SQL should search relevant property for a match, search all properties of the resource for a match.
    1. `FirstName`, `LastName`, and `SlackHandle` for instructors and students.
    1. `Name` and `Language` for exercises.
    1. `Name` for cohorts.


> **Hint:** Use [LIKE](https://www.techonthenet.com/sql_server/like.php) in the SQL query for pattern matching.
