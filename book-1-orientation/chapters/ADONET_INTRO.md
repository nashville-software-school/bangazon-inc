# Using SQL in a .NET Application

This will be an interactive lesson. Your instructor will lead you through following the instructions.

## Instructions

1. Open the [departments and employees](./assets/departments-employees.sql) SQL script and copy it into Azure Data Studio. Select the entire contents of the file and run it. This will create the database, and the tables, and insert some data.
1. In Visual Studio, create a new console application called `DepartmentsEmployees`.
1. In your terminal, navigate to the directory where you created your project. The directory will have a `DepartmentsEmployees.sln` file in it.
1. `cd` into your project directory. When you list what's in the directory, you should see your `Program.cs`.
1. Run the following commands. This imports the required package needed to have your C# code connect to a SQL Server database.
    ```sh
    dotnet add package System.Data.SqlClient
    dotnet restore
    ```
1. Create or update the `*.cs` files with the code found below.
1. Run the application, fix any compiler errors (if any).
1. In `Program.cs`, complete the `PrintDepartmentReport(string title, List<Department> departments)`.
1. Run the application, note the printed reports.
1. In `Program.cs`, complete the `PrintEmployeeReport(string title, List<Employee> employees)`.
1. Run the application, note the printed reports.
1. Review the methods in `Repository.cs`.
1. Complete the unfinished methods in `Repository.cs`. _Remember to test your work along the way!_

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

**Data/Repository.cs**
```cs
using System.Collections.Generic;
using System.Data.SqlClient;
using DepartmentsEmployees.Models;

namespace DepartmentsEmployees.Data
{
    /// <summary>
    ///  An object to contain all database interactions.
    /// </summary>
    public class Repository
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


        /************************************************************************************
         * Departments
         ************************************************************************************/

        /// <summary>
        ///  Returns a list of all departments in the database
        /// </summary>
        public List<Department> GetAllDepartments()
        {
            // We must "use" the database connection.
            //  Because a database is a shared resource (other applications may be using it too) we must
            //  be careful about how we interact with it. Specifically, we Open() connections when we need to
            //  interact with the database and we Close() them when we're finished.
            //  In C#, a "using" block ensures we correctly disconnect from a resource even if there is an error.
            //  For database connections, this means the connection will be properly closed.
            using (SqlConnection conn = Connection)
            {
                // Note, we must Open() the connection, the "using" block doesn't do that for us.
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
                        string deptNameValue = reader.GetString(deptNameColumnPosition);

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
                    // String interpolation lets us inject the id passed into this method.
                    cmd.CommandText = $"SELECT DeptName FROM Department WHERE Id = {id}";
                    SqlDataReader reader = cmd.ExecuteReader();

                    Department department = null;
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
                    // More string interpolation
                    cmd.CommandText = $"INSERT INTO Department (DeptName) Values ('{department.DeptName}')";
                    cmd.ExecuteNonQuery();
                }
            }

            // when this method is finished we can look in the database and see the new department.
        }

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
                    // Here we do something a little different...
                    //  We're using a "parameterized" query to avoid SQL injection attacks.
                    //  First, we add variable names with @ signs in our SQL.
                    //  Then, we add SqlParamters for each of those variables.
                    cmd.CommandText = @"UPDATE Department
                                           SET DeptName = @deptName
                                         WHERE Id = @id";
                    cmd.Parameters.Add(new SqlParameter("@deptName", department.DeptName));
                    cmd.Parameters.Add(new SqlParameter("@id", id));

                    // Maybe we should refactor our other SQL to use parameters

                    cmd.ExecuteNonQuery();
                }
            }
        }


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


        /************************************************************************************
         * Employees
         ************************************************************************************/

        public List<Employee> GetAllEmployees()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT Id, FirstName, LastName, DepartmentId FROM Employee";
                    SqlDataReader reader = cmd.ExecuteReader();

                    List<Employee> employees = new List<Employee>();
                    while (reader.Read())
                    {
                        Employee employee = new Employee
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            FirstName = reader.GetString(reader.GetOrdinal("FirstName")),
                            LastName = reader.GetString(reader.GetOrdinal("LastName")),
                            DepartmentId = reader.GetInt32(reader.GetOrdinal("DepartmentId"))
                        };

                        employees.Add(employee);
                    }

                    reader.Close();

                    return employees;
                }
            }
        }

        /// <summary>
        ///  Get an individual employee by id
        /// </summary>
        /// <param name="id">The employee's id</param>
        /// <returns>The employee that with the given id</returns>
        public Employee GetEmployeeById(int id)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {

                    /*
                     * TODO: Complete this method
                     */

                    return null;
                }
            }
        }


        /// <summary>
        ///  Get all employees along with their departments
        /// </summary>
        /// <returns>A list of employees in which each employee object contains their department object.</returns>
        public List<Employee> GetAllEmployeesWithDepartment()
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {

                    /*
                     * TODO: Complete this method
                     *  Look at GetAllEmployeesWithDepartmentByDepartmentId(int departmentId) for inspiration.
                     */

                    return null;
                }
            }
        }


        /// <summary>
        ///  Get employees who are in the given department. Include the employee's department object.
        /// </summary>
        /// <param name="departmentId">Only include employees in this department</param>
        /// <returns>A list of employees in which each employee object contains their department object.</returns>
        public List<Employee> GetAllEmployeesWithDepartmentByDepartmentId(int departmentId)
        {
            using (SqlConnection conn = Connection)
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $@"SELECT e.Id, e.FirstName, e.LastName, e.DepartmentId,
                                                d.DeptName
                                           FROM Employee e INNER JOIN Department d ON e.DepartmentID = d.id
                                          WHERE d.id = @departmentId";
                    cmd.Parameters.Add(new SqlParameter("@departmentId", departmentId));
                    SqlDataReader reader = cmd.ExecuteReader();

                    List<Employee> employees = new List<Employee>();
                    while (reader.Read())
                    {
                        Employee employee = new Employee
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            FirstName = reader.GetString(reader.GetOrdinal("FirstName")),
                            LastName = reader.GetString(reader.GetOrdinal("LastName")),
                            DepartmentId = reader.GetInt32(reader.GetOrdinal("DepartmentId")),
                            Department = new Department
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("DepartmentId")),
                                DeptName = reader.GetString(reader.GetOrdinal("DeptName"))
                            }
                        };

                        employees.Add(employee);
                    }

                    reader.Close();

                    return employees;
                }
            }
        }


        /// <summary>
        ///  Add a new employee to the database
        ///   NOTE: This method sends data to the database,
        ///   it does not get anything from the database, so there is nothing to return.
        /// </summary>
        public void AddEmployee(Employee employee)
        {
            /*
             * TODO: Complete this method by using an INSERT statement with SQL
             *  Remember to use SqlParameters!
             */

        }

        /// <summary>
        ///  Updates the employee with the given id
        /// </summary>
        public void UpdateEmployee(int id, Employee employee)
        {
            /*
             * TODO: Complete this method using an UPDATE statement with SQL
             *  Remember to use SqlParameters!
             */
        }


        /// <summary>
        ///  Delete the employee with the given id
        /// </summary>
        public void DeleteEmployee(int id)
        {
            /*
             * TODO: Complete this method using a DELETE statement with SQL
             *  Remember to use SqlParameters!
             */
        }
     }
}
```

**Program.cs**
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using DepartmentsEmployees.Data;
using DepartmentsEmployees.Models;

namespace DepartmentsEmployees
{
    class Program
    {
        /// <summary>
        ///  The Main method is the starting point for a .net application.
        /// </summary>
        static void Main(string[] args)
        {
            // We must create an instance of the Repository class in order to use it's methods to
            //  interact with the database.
            Repository repository = new Repository();

            List<Department> departments = repository.GetAllDepartments();

            // PrintDepartmentReport should print a department report to the console, but does it?
            //  Take a look at how it's defined below...
            PrintDepartmentReport("All Departments", departments);

            // What is this? Scroll to the bottom of the file and find out for yourself.
            Pause();


            // Create an new instance of a Department, so we can save our new department to the database.
            Department accounting = new Department { DeptName = "Accounting" };
            // Pass the accounting object as an argument to the repository's AddDepartment() method.
            repository.AddDepartment(accounting);

            departments = repository.GetAllDepartments();
            PrintDepartmentReport("All Departments after adding Accounting department", departments);

            Pause();


            // Pull the object that represents the Accounting department from the list of departments that
            //  we got from the database.
            // First() is a handy LINQ method that gives us the first element in a list that matches the condition.
            Department accountingDepartmentFromDB = departments.First(d => d.DeptName == "Accounting");

            // How are the "accounting" and "accountingDepartmentFromDB" objects different?
            //  Why are they different?
            Console.WriteLine($"                accounting --> {accounting.Id}: {accounting.DeptName}");
            Console.WriteLine($"accountingDepartmentFromDB --> {accountingDepartmentFromDB.Id}: {accountingDepartmentFromDB.DeptName}");

            Pause();

            // Change the name of the Accounting department and save the change to the database.
            accountingDepartmentFromDB.DeptName = "Creative Accounting";
            repository.UpdateDepartment(accountingDepartmentFromDB.Id, accountingDepartmentFromDB);

            departments = repository.GetAllDepartments();
            PrintDepartmentReport("All Departments after updating Accounting department", departments);

            Pause();


            // Maybe we don't need an Accounting department after all...
            repository.DeleteDepartment(accountingDepartmentFromDB.Id);

            departments = repository.GetAllDepartments();
            PrintDepartmentReport("All Departments after deleting Accounting department", departments);

            Pause();

            // Create a new variable to contain a list of Employees and get that list from the database
            List<Employee> employees = repository.GetAllEmployees();

            // Does this method do what it claims to do, or does it need some work?
            PrintEmployeeReport("All Employees", employees);

            Pause();


            employees = repository.GetAllEmployeesWithDepartment();
            PrintEmployeeReport("All Employees with departments", employees);

            Pause();


            // Here we get the first department by index.
            //  We could use First() here without passing it a condition, but using the index is easy enough.
            Department firstDepartment = departments[0];
            employees = repository.GetAllEmployeesWithDepartmentByDepartmentId(firstDepartment.Id);
            PrintEmployeeReport($"Employees in {firstDepartment.DeptName}", employees);

            Pause();


            // Instantiate a new employee object.
            //  Note we are making the employee's DepartmentId refer to an existing department.
            //  This is important because if we use an invalid department id, we won't be able to save
            //  the new employee record to the database because of a foreign key constraint violation.
            Employee jane = new Employee
            {
                FirstName = "Jane",
                LastName = "Lucas",
                DepartmentId = firstDepartment.Id
            };
            repository.AddEmployee(jane);

            employees = repository.GetAllEmployeesWithDepartment();
            PrintEmployeeReport("All Employees after adding Jane", employees);

            Pause();


            // Once again, we see First() in action.
            Employee dbJane = employees.First(e => e.FirstName == "Jane");

            // Get the second department by index.
            Department secondDepartment = departments[1];

            dbJane.DepartmentId = secondDepartment.Id;
            repository.UpdateEmployee(dbJane.Id, dbJane);

            employees = repository.GetAllEmployeesWithDepartment();
            PrintEmployeeReport("All Employees after updating Jane", employees);

            Pause();


            repository.DeleteEmployee(dbJane.Id);
            employees = repository.GetAllEmployeesWithDepartment();

            PrintEmployeeReport("All Employees after updating Jane", employees);

            Pause();

        }



        /// <summary>
        ///  Prints a simple report with the given title and department information.
        /// </summary>
        /// <remarks>
        ///  Each line of the report should include the Department's ID and Name
        /// </remarks>
        /// <param name="title">Title for the report</param>
        /// <param name="departments">Department data for the report</param>
        public static void PrintDepartmentReport(string title, List<Department> departments)
        {
            /*
             * TODO: Complete this method
             *  For example a report entitled, "All Departments" should look like this:

                All Departments
                1: Marketing
                2: Engineering
                3: Design
             */
        }

        /// <summary>
        ///  Prints a simple report with the given title and employee information.
        /// </summary>
        /// <remarks>
        ///  Each line of the report should include the
        ///   Employee's ID, First Name, Last Name,
        ///   and department name IF AND ONLY IF the department is not null.
        /// </remarks>
        /// <param name="title">Title for the report</param>
        /// <param name="employees">Employee data for the report</param>
        public static void PrintEmployeeReport(string title, List<Employee> employees)
        {
            /*
             * TODO: Complete this method
             *  For example a report entitled, "All Employees", should look like this:

                All Employees
                1: Margorie Klingerman
                2: Sebastian Lefebvre
                3: Jamal Ross

             *  A report entitled, "All Employees with Departments", should look like this:

                All Employees with Departments
                1: Margorie Klingerman. Dept: Marketing
                2: Sebastian Lefebvre. Dept: Engineering
                3: Jamal Ross. Dept: Design

             */
        }


        /// <summary>
        ///  Custom function that pauses execution of the console app until the user presses a key
        /// </summary>
        public static void Pause()
        {
            Console.WriteLine();
            Console.Write("Press any key to continue...");
            Console.ReadLine();
            Console.WriteLine();
            Console.WriteLine();
        }
    }
}
```

## Supplemental: Comparison of data access tools

_                           | <span>ADO.NET</span>          | Micro-ORM (Dapper)                           | Full ORM (Entity Framework)
--------------------------- | ----------------------------- | -------------------------------------------- | -------------------------------------- |
**Dev Writes SQL**          | yes                           | yes                                          | no
**Boilerplate Code**        | yes                           | minimal                                      | no
**Automatic Model Binding** | no                            | yes                                          | yes
**Degree of "Magic"**       | none                          | a little                                     | a lot
**Pros**                    | Full control, best performance | Balance between control and ease of use      | Ease of use, Rapid development
**Cons**                    | Lots of code to write         | Can lead to writing more code than is needed | Too much magic, Performance can suffer
