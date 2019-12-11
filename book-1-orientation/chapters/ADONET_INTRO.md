# Using SQL in a .NET Application

This will be an interactive lesson. Your instructor will lead you through following the instructions.

## Instructions

1. Use the [departments and employees](./assets/departments-employees.sql) SQL script to create a `DepartmentsEmployees` database.
1. In Visual Studio, create a new console application called `DepartmentsEmployees`.
1. In your terminal, navigate to the directory where you created your project. The directory will have a `DepartmentsEmployees.sln` file in it.
1. `cd` into your project directory. When you list what's in the directory, you should see your `DepartmentsEmployees.csproj` and `Program.cs`.
1. Run the following commands. This imports the required package needed to have your C# code connect to a SQL Server database.
   ```sh
   dotnet add package Microsoft.Data.SqlClient
   dotnet restore
   ```
1. Make a folder in your project called `Models`. This folder will contain classes that represent tables in our database.
1. In the `Models` folder, create a `Department.cs` file and `Employee.cs` file. Copy in the following code

   ## C# files

   **Models/Department.cs**

   ```cs
   namespace DepartmentsEmployees.Models
   {
       // C# representation of the Department table
       public class Department
       {
           public int Id { get; set; }
           public string DeptName { get; set; }
       }
   }
   ```

   **Models/Employee.cs**

   ```cs
   namespace DepartmentsEmployees.Models
   {
       // C# representation of the Employee table
       public class Employee
       {
           public int Id { get; set; }
           public string FirstName { get; set; }
           public string LastName { get; set; }

           //T his is to hold the actual foreign key integer
           public int DepartmentId { get; set; }

           // This property is for storing the C# object representing the department
           public Department Department { get; set; }
       }
   }
   ```

1. Create a new folder called `Data`. This folder will contain classes that will be responsible for getting data out of our database and creating C# objects from that data. We typically call classes with this responsibility a Repository. Add two new files to it called `DepartmentRepository.cs` and `EmployeeRepository.cs`.
1. Copy the following starter code into `DepartmentRepository.cs`

   ```csharp
   using System.Collections.Generic;
   using System.Data.SqlClient;
   using DepartmentsEmployees.Models;

   namespace DepartmentsEmployees.Data
   {
       /// <summary>
       ///  An object to contain all database interactions.
       /// </summary>
       public class DepartmentRepository
       {
           /// <summary>
           ///  Represents a connection to the database.
           ///   This is a "tunnel" to connect the application to the database.
           ///   All communication between the application and database passes through this connection.
           /// </summary>
           public SqlConnection Connection
           {
               get
               {
                   // This is "address" of the database
                   string _connectionString = "Data Source=localhost\\SQLEXPRESS;Initial Catalog=DepartmentsEmployees;Integrated Security=True";
                   return new SqlConnection(_connectionString);
               }
           }

       }
   }

   ```

   The DepartmentRepository you just added contains a single, computed property called `Connection`. The type of this property is `SqlConnection`. It represents a connection from your C# application to your SQL Server database. Think of it like a two-way tunnel that all communication passes through. Since the property is computed, it means that any time the `Connection` property gets referenced in our code, it will create a new tunnel. Typically, this tunnel stays open only long enough to execute a single command (i.e. a `SELECT` or `INSERT` statement). Once the command is executed, we close the connection and effectively destroy that tunnel. Then when we want to execute another command, we do the same thing again and create a new tunnel.

1. Let's see how we can get data out of our Department table and convert it into a `List<Department>`. Add the following method to your `DepartmentRepository` class

   ```csharp
   /// <summary>
   ///  Returns a list of all departments in the database
   /// </summary>
   public List<Department> GetAllDepartments()
   {
       //  We must "use" the database connection.
       //  Because a database is a shared resource (other applications may be using it too) we must
       //  be careful about how we interact with it. Specifically, we Open() connections when we need to
       //  interact with the database and we Close() them when we're finished.
       //  In C#, a "using" block ensures we correctly disconnect from a resource even if there is an error.
       //  For database connections, this means the connection will be properly closed.
       using (SqlConnection conn = Connection)
       {
           // Note, we must Open() the connection, the "using" block   doesn't do that for us.
           conn.Open();

           // We must "use" commands too.
           using (SqlCommand cmd = conn.CreateCommand())
           {
               // Here we setup the command with the SQL we want to execute before we execute it.
               cmd.CommandText = "SELECT Id, DeptName FROM Department";

               // Execute the SQL in the database and get a "reader" that will give us access to the data.
               SqlDataReader reader = cmd.ExecuteReader();

               // A list to hold the departments we retrieve from the database.
               List<Department> departments = new List<Department>();

               // Read() will return true if there's more data to read
               while (reader.Read())
               {
                   // The "ordinal" is the numeric position of the column in the query results.
                   //  For our query, "Id" has an ordinal value of 0 and "DeptName" is 1.
                   int idColumnPosition = reader.GetOrdinal("Id");

                   // We user the reader's GetXXX methods to get the value for a particular ordinal.
                   int idValue = reader.GetInt32(idColumnPosition);

                   int deptNameColumnPosition = reader.GetOrdinal("DeptName");
                   string deptNameValue = reader.GetString (deptNameColumnPosition);

                   // Now let's create a new department object using the data from the database.
                   Department department = new Department
                   {
                       Id = idValue,
                       DeptName = deptNameValue
                   };

                   // ...and add that department object to our list.
                   departments.Add(department);
               }

               // We should Close() the reader. Unfortunately, a "using" block won't work here.
               reader.Close();

               // Return the list of departments who whomever called this method.
               return departments;
           }
       }
   }
   ```

   To test this, let's call this method from the `Program.Main` method. Create a new instance of a `DepartmentRepository` and call `GetAllDepartments`. Run the application.

   ```csharp
   static void Main(string[] args)
   {
       DepartmentRepository departmentRepo = new DepartmentRepository();

       Console.WriteLine("Getting All Departments:");
       Console.WriteLine();

       List<Department> allDepartments = departmentRepo.GetAllDepartments();

       foreach (Department dept in allDepartments)
       {
           Console.WriteLine($"{dept.Id} {dept.DeptName}");
       }
   }
   ```

1. Now create another method in `DepartmentRepository` that will get a single department by its Id. The method should accept an `int id` as a paramter and return a single `Department` object.

   ```csharp
   /// <summary>
   ///  Returns a single department with the given id.
   /// </summary>
   public Department GetDepartmentById(int id)
   {
       using (SqlConnection conn = Connection)
       {
           conn.Open();
           using (SqlCommand cmd = conn.CreateCommand())
           {
               cmd.CommandText = "SELECT DeptName FROM Department WHERE Id = @id";
               cmd.Parameters.Add(new SqlParameter("@id", id));
               SqlDataReader reader = cmd.ExecuteReader();

               Department department = null;

               // If we only expect a single row back from the database, we don't need a while loop.
               if (reader.Read())
               {
                   department = new Department
                   {
                       Id = id,
                       DeptName = reader.GetString(reader.GetOrdinal("DeptName"))
                   };
               }

               reader.Close();

               return department;
           }
       }
   }
   ```

1. Update `Program.Main` to also call this new method

   ```csharp
   Console.WriteLine("----------------------------");
   Console.WriteLine("Getting Department with Id 1");

   Department singleDepartment = departmentRepo.GetDepartmentById(1);

   Console.WriteLine($"{singleDepartment.Id} {singleDepartment.DeptName}");
   ```

1. Now that we've read data from our database, let's look at how we can add new records. Create a new method in the `DepartmentRepository` and name it `AddDepartment`. It should accept a single `Department dept` parameter and also return a Department object.

   ```csharp
    /// <summary>
    ///  Add a new department to the database
    ///   NOTE: This method sends data to the database,
    ///   it does not get anything from the database, so there is nothing to return.
    /// </summary>
    public void AddDepartment(Department department)
    {
        using (SqlConnection conn = Connection)
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                // These SQL parameters are annoying. Why can't we use string interpolation?
                // ... sql injection attacks!!!
                cmd.CommandText = "INSERT INTO Department (DeptName) OUTPUT INSERTED.Id Values (@deptName)";
                cmd.Parameters.Add(new SqlParameter("@deptName", department.DepartmentName));
                int id = (int)cmd.ExecuteScalar();

                department.Id = id;
            }
        }

        // when this method is finished we can look in the database and see the new department.
    }
   ```

   You may be wondering why we return the same object that gets passed in as a parameter. Remember that the database is where each department's Id gets created. The department parameter that gets passed into the method doesn't have an Id when the method begins, but once it gets returned the Id will be included. Notice this part of the SQL command: `OUTPUT INSERTED.Id`. Normally, when we issue an INSERT statement to our database, no records come back and nothing gets returned. The addition of this `OUTPUT` statement means that we'd also like to get back the ID of the department that we just inserted.

   The `cmd.ExecuteScalar` method does two things: First, it executes the SQL command against the database. Then it looks at the first thing that the database sends back (in our case this is just the ID it created for the department) and returns it.

1. Update `Program.Main` to create a new instance of Department and pass it into the `AddDepartment` method.

   ```csharp
   Department legalDept = new Department
   {
       DeptName = "Legal"
   };

   departmentRepo.AddDepartment(legalDept);

   Console.WriteLine("-------------------------------");
   Console.WriteLine("Added the new Legal Department!");
   ```

1. Now add the following method to the repository that allows us to update a department in the database. This method should be called `UpdateDepartment`. It should take two parameters--an `int id` and a `Department updatedDepartment`, and should not return anything

   ```csharp
    /// <summary>
    ///  Updates the department with the given id
    /// </summary>
    public void UpdateDepartment(int id, Department department)
    {
        using (SqlConnection conn = Connection)
        {
            conn.Open();
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = @"UPDATE Department
                                        SET DeptName = @deptName
                                        WHERE Id = @id";
                cmd.Parameters.Add(new SqlParameter("@deptName", department.DeptName));
                cmd.Parameters.Add(new SqlParameter("@id", id));

                cmd.ExecuteNonQuery();
            }
        }
    }
   ```

   The only difference here is we're calling a method called `cmd.ExecuteNonQuery`. We use this method when we want to execute a SQL command, but we don't expect anything back from the database.

1. Lastly let's create a method that allows us to delete a department. Update `DepartmentRepository` to include a method called `DeleteDepartment`. It should take in an `int id` as a parameter and not return anything.

   ```csharp
   /// <summary>
   ///  Delete the department with the given id
   /// </summary>
   public void DeleteDepartment(int id)
   {
       using (SqlConnection conn = Connection)
       {
           conn.Open();
           using (SqlCommand cmd = conn.CreateCommand())
           {
               cmd.CommandText = "DELETE FROM Department WHERE Id = @id";
               cmd.Parameters.Add(new SqlParameter("@id", id));
               cmd.ExecuteNonQuery();
           }
       }
   }
   ```

## Exercise

1. Implement the `EmployeeRepository` class to include the following methods
   - `public List<Employee> GetAllEmployees()` <---- Employee objects should have a null value for their Department property
   - `public Employee GetEmployeeById(int id)`
   - `public List<Employee> GetAllEmployeesWithDepartment()` <--- Employee objects _should_ have a Department property
   - `public void AddEmployee(Employee employee)`
   - `public void UpdateEmployee(int id, Employee employee)` <--- Use the SQL UPDATE statement
   - `public void DeleteEmployee(int id)`
1. Update the `Program.Main` method to print a report of all employees and their departments

## Challenge

1. Refactor the `Program.Main` method to accept user input before doing any operation

## Supplemental: Comparison of data access tools

| \_                          | <span>ADO.NET</span>           | Micro-ORM (Dapper)                           | Full ORM (Entity Framework)            |
| --------------------------- | ------------------------------ | -------------------------------------------- | -------------------------------------- |
| **Dev Writes SQL**          | yes                            | yes                                          | no                                     |
| **Boilerplate Code**        | yes                            | minimal                                      | no                                     |
| **Automatic Model Binding** | no                             | yes                                          | yes                                    |
| **Degree of "Magic"**       | none                           | a little                                     | a lot                                  |
| **Pros**                    | Full control, best performance | Balance between control and ease of use      | Ease of use, Rapid development         |
| **Cons**                    | Lots of code to write          | Can lead to writing more code than is needed | Too much magic, Performance can suffer |
