USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'DepartmentsEmployees'
)
CREATE DATABASE DepartmentsEmployees
GO

USE DepartmentsEmployees
GO


DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;


CREATE TABLE Department (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    DeptName VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentId INT NOT NULL,
    CONSTRAINT FK_EmployeeDepartment FOREIGN KEY(DepartmentId) REFERENCES Department(Id)
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
