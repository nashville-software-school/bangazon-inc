# Using Annotations to Validate Request Data

ASP.NET provides a wonderful abstraction for adding validations on request data in your API. They are called

## Required Properties

You can specify in your data model that certain properties are required in order to create or modify a resource. These annotated properties are going to match columns in your database that you marked as NOT NULL.

To see how it works, you are first going to try to create a new student. Use Postman to POST the following student to your API.

* Make sure you set the `Content-Type` header to `application/json`.
* Make sure you change the HTTP verb to POST from the dropdown.
* Make sure your URL is `http://localhost:5000/api/student`.

```json
{
    "FirstName": "Dylan",
    "LastName": "Thomas",
    "SlackHandle": "@kdylanthomas",
    "CohortId": 1
}
```

You should get a response back from the API with a status code of `201 Created` and the body of the response should have the newly created resource.

```json
{
    "id": 9,
    "firstName": "Dylan",
    "lastName": "Thomas",
    "slackHandle": "@kdylanthomas",
    "cohortId": 4,
    "cohort": null,
    "assignedExercises": []
}
```

## Invalid Data

Now try to create a student with no last name, and no Slack handle.

```json
{
    "FirstName": "Alexander",
    "CohortId": 3
}
```

Your response code will still be `201 Created` but the resource is incomplete.

```json
{
    "id": 10,
    "firstName": "Alexander",
    "lastName": null,
    "slackHandle": null,
    "cohortId": 3,
    "cohort": null,
    "assignedExercises": []
}
```

You want the last name and Slack handle to always be provided in the POST body because they are required information.

## Required Annotation

1. Add `[Required]` to first name, last name, and slack handle for students.

```cs
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace StudentExercises.Models
{
    public class Student
    {
        public int Id { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        public string SlackHandle { get; set; }

        [Required]
        public int CohortId { get; set; }

        public Cohort Cohort { get; set; }

        public List<Exercise> AssignedExercises { get; set; } = new List<Exercise>();
    }
}
```

Restart your project, and try to submit the incomplete student object via Postman again. You will get a response with a status code of `400 Bad Request` and the body will tell you what was wrong with your request.

```json
{
    "LastName": [
        "The LastName field is required."
    ],
    "SlackHandle": [
        "The SlackHandle field is required."
    ]
}
```

It did not add the incomplete student to the database because the data validation annotations of `[Required]` prevented the operation.

## String Length Annotation

Apply `[StringLength(25)]` to the student `LastName` property.

```cs
[Required]
[StringLength(25)]
public string LastName { get; set; }
```

Try to create an student with a super long last name.

```json
{
    "FirstName": "Alexander",
    "LastName": "The Ultimate Conqueror of the Known World",
    "CohortId": 3
}
```

Now the validation of the last name being required will pass, but the new validation will fail and you'll be shown why in the response.

```json
{
    "LastName": [
        "The field LastName must be a string with a maximum length of 25."
    ],
    "SlackHandle": [
        "The SlackHandle field is required."
    ]
}
```

What if you also want a minimum length rule on the property?

```cs
[Required]
[StringLength(25, MinimumLength=2)]
public string LastName { get; set; }
```

If you POST a last name of only 1 character, you get the following response.

```json
{
    "LastName": [
        "The field LastName must be a string with a minimum length of 2 and a maximum length of 25."
    ]
}
```
