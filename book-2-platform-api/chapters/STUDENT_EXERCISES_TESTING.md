# Testing Student Exercise API

## Practice

You need to create integration tests for the following features of your Student Exercises API.

1. Basic CRUD for Students
1. Basic CRUD for Cohorts
1. Basic CRUD for Instructors
1. Basic CRUD for Exercises

## Challenge: Managing Assignments

The relationship between students and exercises is a many-to-many type, which requires an intesection table to store those relationships. Usually, but not always, those relationships aren't exposed by your application for reading or manipulation by a client. This means that there is no **Controller** for intersection tables. The items in intersection tables are managed by other controllers.

In this API, however, you need a way to assign an exercise to a student - which is done by an instructor. Therefore, you need to provide an endpoint that a client can use to make the assignment. You can make an **`AssignmentController`** that provides support for the following actions.

1. **Assign exercise:** Support POST operation that will create a new entry in `StudentExercise` table.
1. **Unassign exercise:** Support DELETE operation that will remove a relationship by its `Id`.

Once that controller is created, add a new test file to your testing project named `TestAssginments.cs`. Then build a **`TestAssignments`** class that verifies that the operations are working by making the following assertions pass.

```cs
public class TestAssignments
{
    [Fact]
    public async Task Test_Assign_Exercise_To_Student()
    {

        using (var client = new APIClientProvider().Client)
        {


            Assert.Equal(HttpStatusCode.Created, response.StatusCode);
            Assert.Equal(1, newAssignment.StudentId);
            Assert.Equal(3, newAssignment.ExerciseId);
            Assert.Equal(2, newAssignment.InstructorId);
        }
    }

    [Fact]
    public async Task Test_Unassign_Exercise()
    {

        using (var client = new APIClientProvider().Client)
        {

            Assert.Equal(HttpStatusCode.NoContent, deleteResponse.StatusCode);
        }
    }
}
```
