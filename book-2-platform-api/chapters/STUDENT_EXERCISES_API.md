# Student Exercises Controllers

Your task is to continue to build out the Student Exercises API.

1. Copy remaining models from your CLI application to `Models` directory of your API project.
1. Create Student controller. Student JSON representation should include cohort name.
    ```json
    {
        "FirstName": "Callan",
        "LastName": "Morrison",
        "SlackHandle": "@morecallan",
        "Cohort": "Evening Cohort 3"
    }
    ```
1. Create Instructor controller. Instructor JSON representation should include cohort name.
    ```json
    {
        "FirstName": "Zoe",
        "LastName": "Ames",
        "SlackHandle": "@zoeames",
        "Cohort": "Evening Cohort 8"
    }
    ```
1. Create Cohort controller. Cohort JSON representation should include array of students, and the instructor.
    ```json
    {
        "CohortName": "Day Cohort 12",
        "Students": [
            "Dylan Thomas",
            "Thomas Buida",
            "David Shuman",
            "Michael Bennett",
            "Kaylee Cummings",
            "Jeremy Swain",
            "Jeremy Landi"
        ],
        "Instructor": "Joe Shepherd"
    }
    ```


