# Student Exercises - Using Query String Parameters

## Practice

1. Student JSON response should have all exercises assigned to them if the `_include=exercise` query string parameter is there.
1. Exercise JSON response should all currently assigned students if the `_include=students` query string parameter is there.
1. If the `q` query string parameter exists, search all properties of the resource for a match
    1. Hint: Using `LIKE` in the SQL
