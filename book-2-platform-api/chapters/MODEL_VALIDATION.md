# Using Annotations and ModelState

## Required Properties

1. Add `[Required]` to first name, last name, and slack handle for students and instructor.
1. Add `[Required]` to exercise name and language.
1. Show students how the request is rejected if they POST to one of the controller with a required property missing.

## String Length Annotation

1. Apply `[StringLength(25)]` to the exercise name property. Try to create an exercise with a name longer than 25 characters.
