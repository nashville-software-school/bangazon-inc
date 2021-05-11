# Validating Student Exercise Data

## Practice

1. `Name` and `Language` properties on an exercises should be required.
1. Instructor `FirstName`, `LastName`, and `SlackHandle` should be required.
1. Cohort `Name` should be required.
1. Cohort `Name` should be a minimum of of 5 characters and and no more than 11.
1. Student, and Instructor `SlackHandle` value should be a minimum of 3 characters and no more than 12.

## Challenge: Regular Expressions

Regular expressions are a useful machanism in all software languages that allow you to do advanced pattern matching. Visit [https://regexr.com/](https://regexr.com/) and [https://www.regular-expressions.info/](https://www.regular-expressions.info/) and find a way to write a regular expression validation rule for the following requirement.

1. Cohort `Name` property must be two words. The first word should be `Day` or `Evening`. The second word must be a 1 or 2 digit number. The `d` and `e` at the beginning of the first word can be lowercase or uppercase.
1. If the validation fails, the client should get the error message _"Cohort name should be in the format of [Day|Evening] [number]"_
