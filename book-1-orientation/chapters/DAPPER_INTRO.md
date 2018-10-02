# Object Relational Mapping with Dapper

Mapping the relationships between objects in C# that represent the relationships you established in your database.

```
mkdir -p ~/workspace/csharp/exercises/dapperdepartments && cd $_
dotnet new console
dotnet add package Dapper
dotnet add package Microsoft.Data.Sqlite
dotnet restore
touch departments.sql
touch departments.db
mkdir Models
```

Open SQL file. Paste in the following table definitions.

```sql
CREATE TABLE `Department` (
    `Id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `DeptName` TEXT NOT NULL
);

CREATE TABLE `Employee` (
    `Id`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `FirstName`    TEXT NOT NULL,
    `LastName`    TEXT NOT NULL,
    `DepartmentId`    INTEGER NOT NULL,
    FOREIGN KEY(`DepartmentId`) REFERENCES `Department`(`Id`),
);

INSERT INTO Department (DeptName) VALUES ('Marketing');
INSERT INTO Department (DeptName) VALUES ('Engineering');
INSERT INTO Department (DeptName) VALUES ('Design');

INSERT INTO Employee
    (FirstName, LastName, DepartmentId)
VALUES
    ('Margorie', 'Klingerman', 1);

INSERT INTO Employee
    (FirstName, LastName, DepartmentId)
VALUES
    ('Sebastian', 'Lefebvre', 2);

INSERT INTO Employee
    (FirstName, LastName, DepartmentId)
VALUES
    ('Jamal', 'Ross', 3);

```

#### Models/Department.cs

```cs
namespace dapperdepartment
{
    // C# representation of the Department table
    public class Department
    {
        public int Id { get; set; }

        public string DeptName { get; set; }
    }
}
```

#### Models/Employee.cs

```cs
namespace dapperdepartment
{
    // C# representation of the Employee table
    public class Employee
    {
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Title { get; set; }

        /*
            This is to hold the actual foreign key integer
        */
        public int DepartmentId { get; set; }

        /*
            This property is for storing the C# object representing the department
        */
        public Department Department { get; set; }
    }
}
```

#### DatabaseInterface.cs

```cs
using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Data.Sqlite;
using System.Collections;
using Dapper;

namespace nss.Data
{
    public class DatabaseInterface
    {
        public static SqliteConnection Connection
        {
            get
            {
                string _connectionString = $"Data Source=/change/me/to/path/to/your/project/nss.db";
                return new SqliteConnection(_connectionString);
            }
        }


        public static void CheckDepartmentTable()
        {
            SqliteConnection db = DatabaseInterface.Connection;

            try
            {
                List<Department> departments = db.Query<Department>
                    ("SELECT Id FROM Department").ToList();
            }
            catch (System.Exception ex)
            {
                if (ex.Message.Contains("no such table"))
                {
                    db.Execute(@"CREATE TABLE `Department` (
                        `Id` INTEGER PRIMARY KEY AUTOINCREMENT,
                        `DeptName` TEXT NOT NULL
                    )");

                    db.Execute(@"
                    INSERT INTO Department (DeptName) VALUES ('Marketing');
                    INSERT INTO Department (DeptName) VALUES ('Engineering');
                    INSERT INTO Department (DeptName) VALUES ('Design');
                    ");
                }
            }
        }

        public static void CheckEmployeeTable()
        {
            SqliteConnection db = DatabaseInterface.Connection;

            try
            {
                List<Employee> employees = db.Query<Employee>
                    ("SELECT Id FROM Employee").ToList();
            }
            catch (System.Exception ex)
            {
                if (ex.Message.Contains("no such table"))
                {
                    db.Execute($@"CREATE TABLE `Employee` (
                        `Id`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                        `FirstName`    TEXT NOT NULL,
                        `LastName`    TEXT NOT NULL,
                        `DepartmentId`    INTEGER NOT NULL,
                        FOREIGN KEY(`DepartmentId`) REFERENCES `Department`(`Id`),
                    )");

                    db.Execute($@"
                    INSERT INTO Employee (FirstName, LastName, DepartmentId) VALUES ('Margorie', 'Klingerman', 1);

                    INSERT INTO Employee (FirstName, LastName, DepartmentId) VALUES ('Sebastian', 'Lefebvre', 2);

                    INSERT INTO Employee (FirstName, LastName, DepartmentId) VALUES ('Jamal', 'Ross', 3);
                    ");
                }
            }
        }
    }
}
```

#### Program.cs

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Data.Sqlite;
using nss.Data;
using Dapper;
using System.Text;

/*
    To install required packages from NuGet
        1. `dotnet add package Microsoft.Data.Sqlite`
        2. `dotnet add package Dapper`
        3. `dotnet restore`
 */

namespace nss
{
    class Program
    {
        static void Main(string[] args)
        {
            SqliteConnection db = DatabaseInterface.Connection;
            DatabaseInterface.CheckDepartmentTable();
            DatabaseInterface.CheckEmployeeTable();

            /*
                1. Query database
                2. Convert result to list
                3. Use ForEach to iterate the collection
            */
            List<Department> departments = db.Query<Department>(@"SELECT * FROM Department").ToList();
            departments.ForEach(dept => Console.WriteLine($"{dept.DeptName}"));

            // Chaining LINQ statements together
            db.Query<Employee>(@"SELECT * FROM Employee")
              .ToList()
              .ForEach(emp => Console.WriteLine($"{emp.FirstName} {emp.LastName"));




            /*
                Query the database for each employee, and join in the employee's department
                Since an employee is only assigned to one department at a time, you can simply
                assign the corresponding deparment as a property on the instance of the
                Employee class that is created by Dapper.
             */
            db.Query<Employee, Department, Employee>(@"
                SELECT e.Id,
                       e.FirstName,
                       e.LastName,
                       d.Id,
                       d.DeptName
                FROM Employee e
                JOIN Department d ON d.Id = e.DepartmentId
            ", (employee, department) =>
            {
                employee.Cohort = department;
                return employee;
            })
            .ToList()
            .ForEach(emp => Console.WriteLine($"{emp.FirstName} {emp.LastName} works in the  {emp.Deparment.DeptName}"));
        }
    }
}
```
