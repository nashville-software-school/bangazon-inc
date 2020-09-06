# Student Exercises Controllers

Your task is to continue to build out the Student Exercises API.

1. Copy remaining models from your CLI application to `Models` directory of your API project.
1. Create Student controller. Student JSON representation should include cohort.
    ```json
    {
        "id": 1,
        "firstName": "Jane",
        "lastName": "Doe",
        "slackHandle": "@jane",
        "cohortId": 1,
        "cohort": {
            "id": 1,
            "name": "Cohort 28",
            "students": [],
            "instructors": []
        },
        "exercises": []
    }
    ```
1. Create Instructor controller. Instructor JSON representation should include cohort.
    ```json
    {
        "id": 1,
        "firstName": "Jisie",
        "lastName": "David",
        "slackHandle": "@jisie",
        "cohortId": 2,
        "cohort": {
            "id": 2,
            "name": "Cohort 29",
            "students": [],
            "instructors": []
        }
    },
    ```
1. Create Cohort controller. Cohort JSON representation should include an array of students, and an array of instructors.
    ```json
    {
        "name": "Cohort 29",
        "Students": [
            {
                "id": 4,
                "firstName": "Daniel",
                "lastName": "Brewer",
                "slackHandle": "@dan",
                "cohortId": 2,
                "cohort": null,
                "exercises": []
            },
            {
                "id": 5,
                "firstName": "JD",
                "lastName": "Wheeler",
                "slackHandle": "@jd",
                "cohortId": 2,
                "cohort": null,
                "exercises": []
            }
        ],
        "Instructor": [
            {
                "id": 1,
                "firstName": "Jisie",
                "lastName": "David",
                "slackHandle": "@jisie",
                "cohortId": 2,
                "cohort": null
            },
            {
                "id": 2,
                "firstName": "Andy",
                "lastName": "Collins",
                "slackHandle": "@andy",
                "cohortId": 2,
                "cohort": null
            }
        ]
    }
    ```


