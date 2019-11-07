#### Write the appropriate SQL to answer the following questions

Run the script below to create the BangazonSqlExercise database (The tables should look similar or identical to the ones used in your group project)

> **NOTE:** Some of these questions will require googling and/or asking for help from your instructors.

1. List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.
1. List each department ordered by budget amount with the highest first.
1. List each department name along with any employees (full name) in that department who are supervisors.
1. List each department name along with a count of employees in each department.
1. Write a single update statement to increase each department's budget by 20%.
1. List the employee full names for employees who are not signed up for any training programs.
1. List the employee full names for employees who are signed up for at least one training program and include the number of training programs they are signed up for.
1. List all training programs along with the count employees who have signed up for each.
1. List all training programs who have no more seats available.
1. List all future training programs ordered by start date with the earliest date first.
1. Assign a few employees to training programs of your choice.
1. List the top 3 most popular training programs. _(For this question, consider each record in the training program table to be a UNIQUE training program)_.
1. List the top 3 most popular training programs. _(For this question consider training programs with the same name to be the SAME training program)_.
1. List all employees who do not have computers.
1. List all employees along with their current computer information make and manufacturer combined into a field entitled `ComputerInfo`. If they do not have a computer, this field should say "N/A".
1. List all computers that were purchased before July 2019 that are have not been decommissioned.
1. List all employees along with the total number of computers they have ever had.

```sql
USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'BangazonSqlExercise'
)
CREATE DATABASE BangazonSqlExercise
GO

USE BangazonSqlExercise
GO

DROP TABLE IF EXISTS EmployeeTraining;
DROP TABLE IF EXISTS TrainingProgram;
DROP TABLE IF EXISTS ComputerEmployee;
DROP TABLE IF EXISTS Computer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS OrderProduct;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS PaymentType;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS ProductType;



CREATE TABLE Department (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	Budget 	INTEGER NOT NULL
);

CREATE TABLE Employee (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	FirstName VARCHAR(55) NOT NULL,
	LastName VARCHAR(55) NOT NULL,
	DepartmentId INTEGER NOT NULL,
	IsSupervisor BIT NOT NULL DEFAULT(0),
    CONSTRAINT FK_EmployeeDepartment FOREIGN KEY(DepartmentId) REFERENCES Department(Id)
);

CREATE TABLE Computer (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	PurchaseDate DATETIME NOT NULL,
	DecomissionDate DATETIME,
	Make VARCHAR(55) NOT NULL,
	Manufacturer VARCHAR(55) NOT NULL
);

CREATE TABLE ComputerEmployee (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	EmployeeId INTEGER NOT NULL,
	ComputerId INTEGER NOT NULL,
	AssignDate DATETIME NOT NULL,
	UnassignDate DATETIME,
    CONSTRAINT FK_ComputerEmployee_Employee FOREIGN KEY(EmployeeId) REFERENCES Employee(Id),
    CONSTRAINT FK_ComputerEmployee_Computer FOREIGN KEY(ComputerId) REFERENCES Computer(Id)
);


CREATE TABLE TrainingProgram (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(255) NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	MaxAttendees INTEGER NOT NULL
);

CREATE TABLE EmployeeTraining (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	EmployeeId INTEGER NOT NULL,
	TrainingProgramId INTEGER NOT NULL,
    CONSTRAINT FK_EmployeeTraining_Employee FOREIGN KEY(EmployeeId) REFERENCES Employee(Id),
    CONSTRAINT FK_EmployeeTraining_Training FOREIGN KEY(TrainingProgramId) REFERENCES TrainingProgram(Id)
);

CREATE TABLE ProductType (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL
);

CREATE TABLE Customer (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	FirstName VARCHAR(55) NOT NULL,
	LastName VARCHAR(55) NOT NULL,
	CreationDate DATETIME NOT NULL,
	LastActiveDate DATETIME NOT NULL
);

CREATE TABLE Product (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	ProductTypeId INTEGER NOT NULL,
	CustomerId INTEGER NOT NULL,
	Price MONEY NOT NULL,
	Title VARCHAR(255) NOT NULL,
	[Description] VARCHAR(255) NOT NULL,
	Quantity INTEGER NOT NULL,
    CONSTRAINT FK_Product_ProductType FOREIGN KEY(ProductTypeId) REFERENCES ProductType(Id),
    CONSTRAINT FK_Product_Customer FOREIGN KEY(CustomerId) REFERENCES Customer(Id)
);


CREATE TABLE PaymentType (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	AcctNumber VARCHAR(55) NOT NULL,
	[Name] VARCHAR(55) NOT NULL,
	CustomerId INTEGER NOT NULL,
    CONSTRAINT FK_PaymentType_Customer FOREIGN KEY(CustomerId) REFERENCES Customer(Id)
);

CREATE TABLE [Order] (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	CustomerId INTEGER NOT NULL,
	PaymentTypeId INTEGER,
    CONSTRAINT FK_Order_Customer FOREIGN KEY(CustomerId) REFERENCES Customer(Id),
    CONSTRAINT FK_Order_Payment FOREIGN KEY(PaymentTypeId) REFERENCES PaymentType(Id)
);

CREATE TABLE OrderProduct (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	OrderId INTEGER NOT NULL,
	ProductId INTEGER NOT NULL,
    CONSTRAINT FK_OrderProduct_Product FOREIGN KEY(ProductId) REFERENCES Product(Id),
    CONSTRAINT FK_OrderProduct_Order FOREIGN KEY(OrderId) REFERENCES [Order](Id)
);


INSERT INTO Department (Name, Budget) VALUES ('HR', 300000);
INSERT INTO Department (Name, Budget) VALUES ('Executive Team', 2000000);
INSERT INTO Department (Name, Budget) VALUES ('Marketing', 540000);
INSERT INTO Department (Name, Budget) VALUES ('Occult Studies', 81200);
INSERT INTO Department (Name, Budget) VALUES ('Silly Walks', 3800000);
INSERT INTO Department (Name, Budget) VALUES ('IT', 45);

INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Allison', 'Patton', 1, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Bennett', 'Foster', 2, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Bobby', 'Brady', 3, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Brantley', 'Jones', 4, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Brian', 'Wilson', 5, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Carl', 'Barringer', 6, 1);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Curtis', 'Crutchfield', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Ellie', 'Ash', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Eric', 'Taylor', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Haroon', 'Iqbal', 4, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Jacquelyn', 'McCray', 5, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Joe', 'Snyder', 6, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Kelly', 'Coles', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Kevin', 'Sadler', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Maggie', 'Johnson', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Matthew', 'Ross', 4, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Michael', 'Stiles', 5, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Michelle', 'Jimenez', 6, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Noah', 'Bartfield', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Sarah', 'Fleming', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('William', 'Wilkinson', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Ali', 'Abdulle', 4, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Samuel', 'Alpren', 5, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Sam', 'Britt', 6, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Jameka', 'Echols', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Josh', 'Hibray', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Brian', 'Jobe', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('William', 'Mathison', 4, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Clifton', 'Matuszeski', 5, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('William', 'Mitchell', 6, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Joel', 'Mondesir', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Christopher', 'Morgan', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Meagan', 'Mueller', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Jonathan', 'Schaffer', 4, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Stephen', 'Senft', 5, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Alexander', 'Thacker', 6, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Anne', 'Vick', 1, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Rose', 'Wisotzky', 2, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Michael', 'Yankura', 3, 0);
INSERT INTO Employee (FirstName, LastName, DepartmentId, IsSupervisor) VALUES ('Selamawit', 'GebreKidan', 4, 0);


INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2010-01-01', '2014-12-31', 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Macbook Pro', 'Apple');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2015-01-01', null, 'Surface Pro', 'Microsoft');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-01-01', null, 'Oryx', 'System76');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');
INSERT INTO Computer (PurchaseDate, DecomissionDate, Make, Manufacturer) Values ('2019-07-01', null, 'XPS', 'Dell');


INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (1, 1, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (2, 2, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (3, 3, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (4, 4, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (5, 5, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (6, 6, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (7, 7, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (8, 8, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (9, 9, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (10, 10, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (11, 11, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (12, 12, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (13, 13, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (14, 14, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (15, 15, '2010-01-01', '2014-12-31');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (1, 16, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (2, 17, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (3, 18, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (4, 19, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (5, 20, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (6, 21, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (7, 22, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (8, 23, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (9, 24, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (10, 25, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (11, 26, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (12, 27, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (13, 28, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (14, 29, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (15, 30, '2015-01-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (19, 34, '2019-08-02', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (20, 44, '2019-08-02', '2019-08-04');
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (20, 45, '2019-08-04', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (21, 44, '2019-08-05', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (25, 31, '2019-08-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (29, 32, '2019-08-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (30, 33, '2019-08-01', null);
INSERT INTO ComputerEmployee (EmployeeId, ComputerId, AssignDate, UnassignDate) VALUES (39, 40, '2019-08-01', null);



INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Productivity and You', '2018-09-14', '2018-09-18', 20);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('HR Rules Are Important, Really', '2018-09-15', '2018-09-19', 15);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Making the most of your imposter syndrome', '2019-04-01', '2019-04-10', 100);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2019-05-01', '2019-05-04', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2019-05-10', '2019-05-14', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2019-06-01', '2019-06-04', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2019-06-10', '2019-06-14', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2019-07-01', '2019-07-04', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Customer Service: Is it ok to yell at them?', '2019-12-01', '2019-12-05', 10);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Managing Your Manager', '2019-12-01', '2019-12-05', 10);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Goal Setting When No One Knows What''s Coming Next', '2020-01-10', '2020-01-14', 10);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2020-05-01', '2020-05-04', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2020-05-10', '2020-05-14', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2020-06-01', '2020-06-04', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2020-06-10', '2020-06-14', 30);
INSERT INTO TrainingProgram (Name, StartDate, EndDate, MaxAttendees) VALUES ('Grifting', '2020-07-01', '2020-07-04', 30);


INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1, 1);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1, 2);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1, 3);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (2, 2);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (2, 3);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (20, 8);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (20, 8);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (2, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (3, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (4, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (5, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (6, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (7, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (8, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (9, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (10, 9);

-- Customer (100)
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2000-11-05','2019-02-24','Brent','Sawyer'),('2019-02-09','2019-03-10','Boris','Lindsey'),('2003-02-22','2019-05-06','Cruz','White'),('2005-11-05','2019-06-07','Alyssa','Olsen'),('2001-01-09','2019-07-03','Francis','Logan'),('2008-02-06','2019-09-08','Mason','Ingram'),('2014-07-31','2018-12-16','Riley','Bryan'),('2001-07-28','2019-03-02','Reagan','Chase'),('2012-08-11','2019-08-16','Erica','Booker'),('2018-12-01','2019-10-16','Alexander','Foster');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2016-12-23','2019-03-16','Hunter','Randolph'),('2001-03-02','2019-05-27','Ebony','Velasquez'),('2006-07-23','2018-12-14','Hilary','Duffy'),('2009-11-23','2018-12-18','Plato','Griffin'),('2015-11-15','2018-12-08','Myles','Moreno'),('2006-05-19','2019-01-25','Kane','Lara'),('2003-09-10','2018-11-29','Gary','Sutton'),('2018-04-04','2019-07-24','Alvin','Obrien'),('2005-07-10','2019-02-26','Kimberley','Howard'),('2016-11-11','2019-04-17','Jonas','Colon');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2019-07-22','2019-06-07','Raven','Mercado'),('2003-07-01','2019-10-29','Karly','Stewart'),('2013-11-05','2019-06-10','Ava','Knapp'),('2017-08-24','2019-01-18','Hasad','Langley'),('2009-05-01','2019-05-21','Glenna','Good'),('2009-06-26','2019-03-06','Cheyenne','Lyons'),('2013-12-19','2019-04-01','Jessica','Mann'),('2005-01-12','2019-03-29','Christen','Gillespie'),('2006-02-14','2019-01-26','Holmes','Stevens'),('2011-04-05','2019-04-10','Maryam','Reeves');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2016-09-16','2019-10-30','Mollie','Holloway'),('2013-07-18','2019-03-15','Giacomo','Hammond'),('2016-05-24','2019-06-27','Laurel','Boone'),('2009-02-24','2019-07-23','Callum','Mcgee'),('2005-11-30','2018-11-13','Jillian','Manning'),('2011-04-30','2019-04-18','Hector','Phillips'),('2017-06-10','2019-09-25','Chester','Mitchell'),('2014-11-30','2019-04-30','Hyatt','Puckett'),('2013-08-15','2019-02-15','Gabriel','Donaldson'),('2012-09-25','2019-09-23','Rebekah','Hahn');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2003-06-25','2019-08-21','Christopher','Lee'),('2019-02-16','2019-08-25','Dante','Goodman'),('2010-10-25','2018-11-18','Barry','Berry'),('2008-11-02','2019-01-23','Octavia','Gilmore'),('2001-01-03','2019-01-23','Brendan','Delacruz'),('2004-02-26','2019-06-29','Kyle','Rollins'),('2007-02-19','2019-10-03','TaShya','Ferguson'),('2018-11-27','2019-07-14','Clio','Bowman'),('2018-08-15','2019-04-26','Hilda','Allen'),('2014-03-09','2018-12-14','Baker','Fitzpatrick');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2010-11-10','2018-11-10','Odysseus','Pruitt'),('2014-10-09','2019-06-07','Petra','Love'),('2009-02-25','2019-03-14','Vernon','Wade'),('2013-01-20','2019-10-12','Alden','Baxter'),('2018-01-19','2019-07-07','Hedley','Guerra'),('2015-07-04','2019-04-22','Ulric','Livingston'),('2010-10-12','2019-02-09','Hunter','Ferrell'),('2005-01-19','2019-04-11','Orli','Griffith'),('2001-01-31','2018-12-20','Micah','Gay'),('2017-12-09','2019-09-01','Tanek','Silva');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2005-11-12','2019-04-12','Quinlan','Myers'),('2016-02-07','2019-03-08','Derek','Keith'),('2002-08-30','2019-01-01','Erica','Barber'),('2016-11-17','2019-02-17','Felix','Trevino'),('2019-02-11','2019-05-01','Zeph','Price'),('2018-10-29','2019-10-05','Hunter','England'),('2009-05-11','2018-12-08','Keely','Weeks'),('2001-03-11','2019-05-27','Zachery','Harper'),('2013-08-15','2019-04-19','Colin','Graham'),('2014-10-03','2018-12-19','Destiny','Roman');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2011-05-11','2019-05-27','Kay','Conner'),('2010-02-06','2019-04-23','Forrest','Bishop'),('2012-06-24','2019-08-10','Ivan','Buckley'),('2014-03-12','2019-04-12','Ahmed','Rollins'),('2013-05-17','2018-12-20','Jayme','Oneal'),('2001-05-19','2019-03-27','Mariko','Flores'),('2009-01-20','2018-12-09','Maris','Le'),('2005-02-28','2019-08-22','Leila','Odom'),('2002-04-18','2019-09-15','Ira','Cleveland'),('2009-07-15','2019-03-10','Hillary','Ramirez');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2018-07-10','2018-11-26','Justin','Aguirre'),('2017-06-09','2019-07-09','Bell','Lyons'),('2012-01-22','2019-08-03','Jin','Boyle'),('2018-08-15','2019-04-19','Bo','Justice'),('2003-07-11','2019-10-08','Alexander','Blackwell'),('2019-02-26','2019-09-05','Hayden','Dejesus'),('2018-05-26','2019-09-28','Lani','Sullivan'),('2006-02-16','2019-07-15','Burton','Mccray'),('2004-09-09','2019-06-17','Emerald','Smith'),('2018-11-12','2019-03-14','Paula','Stanton');
INSERT INTO Customer([CreationDate],[LastActiveDate],[FirstName],[LastName]) VALUES('2002-01-24','2019-05-11','Ivan','Townsend'),('2007-10-09','2019-08-24','Brenna','West'),('2011-02-16','2019-04-28','Laith','Richmond'),('2018-05-18','2019-03-13','Anastasia','Roberts'),('2010-10-19','2019-04-28','Chancellor','Hubbard'),('2016-09-21','2019-02-11','Ulric','Morris'),('2007-09-20','2018-12-11','Lester','Osborne'),('2001-10-12','2019-06-19','India','Best'),('2015-08-30','2019-04-19','Uta','Fitzpatrick'),('2002-01-17','2019-11-02','Ruby','Dunlap');


-- Product Type
INSERT INTO ProductType([Name])
    VALUES 
    ('Food'),
    ('Electronics'),
    ('Games'),
    ('Entertainment'),
    ('Furniture & Home Goods'),
    ('Clothing & Accessories'),
    ('Tools'),
    ('Kitchen Items'),
    ('Office Supplies')


-- Product (50)
INSERT INTO Product([ProductTypeId],[CustomerId],[Price],[Title],[Description],[Quantity]) 
    VALUES
    (1,48,3,'Mockaroos','Like Dunkaroos, but fake',137),
    (3,30,1577,'Pinball Machine','Classic Metallica pinball machine',2),
    (8,14,8,'Coffee mug.','Artisinally caffeinated',199),
    (6,51,189,'Ugg Boots,','#FallingForFallYall',50),
    (7,85,375,'Office Chair','Ergonomically correct office chair',65),
    (2,30,994,'T.V.','HD Television',145),
    (3,95,200,'Duck Hunt Arcade Game','Classic Nintendo game',95),
    (4,85,20,'Friends Season 1 DVDs','Only season 1',59),
    (5,8,40,'Squatty Potty','Make BMs easier',48),
    (4,44,50,'Toy Firetruck','Big enough to ride in',11);
INSERT INTO Product([ProductTypeId],[CustomerId],[Price],[Title],[Description],[Quantity]) 
    VALUES
    (5,75,46,'Leopard Print Bedsheets','Low thread count',174),
    (5,94,600,'Standing Desk','Good for the back and spine',12),
    (8,45,60,'Pizza Stone','Good for making pizzas',125),
    (6,89,80,'Bathrobe','Very comfortable',97),
    (6,15,100,'Backpack','Perfect for 15" laptop',13),
    (2,26,2500,'Macbook Pro','2019 Macbook Pro',4),
    (2,13,600,'iPad','Comes with s fancy sleeve',8),
    (8,26,20,'Water Bottle','Keeps cool things cool',196),
    (6,12,713,'Watch','Rolex',3),
    (7,12,25,'Screwdriver set','Set of 6',50);
INSERT INTO Product([ProductTypeId],[CustomerId],[Price],[Title],[Description],[Quantity]) 
    VALUES
    (3,9,82,'Xbox','Original gen Xbox',134),
    (3,56,200,'Ninetendo Switch','Comes with dock',195),
    (7,37,90,'Toolbelt','Leather toolbelt',92),
    (8,2,20,'French Press','Makes 4 cups of coffee',12),
    (2,7,15,'HDMI cable','HDMI cable',104),
    (3,11,300,'Lego Set','Star Wars lego set 1000pcs',200),
    (7,10,40,'Drill Bits','Set of 8',78),
    (3,12,200,'LiteBrite','Original LiteBrite',2),
    (8,94,2,'#1 Dad Mug','Only for #1 Dads',1),
    (2,53,100,'Bluetooth Speaker','Bluetooth Speaker',52);
INSERT INTO Product([ProductTypeId],[CustomerId],[Price],[Title],[Description],[Quantity]) 
    VALUES
    (2,48,300,'Headphones','Sony Headphones',15),
    (5,62,350,'Vacuum Cleaner.','Cordless vacuum',43),
    (2,40,250,'Keyboard','Mechanical Keyboard',33),
    (6,30,18,'Stretchy Pants','They look like real jeans',160),
    (7,18,40,'Umbrella','Stay dry',79),
    (6,46,60,'Winter Gloves,','Stay warm',29),
    (2,81,22,'Phone Charger','iPhone charger',100),
    (2,35,200,'Camera','4K 16MP Camera',77),
    (2,22,43,'DVD Player','Some people still watch DVDs',57),
    (2,10,1200,'Drone.','Foldable drone',78);
INSERT INTO Product([ProductTypeId],[CustomerId],[Price],[Title],[Description],[Quantity]) 
    VALUES
    (4,30,2400,'Telescope.','Can see real far',179),
    (9,28,12,'Stapler','Stapler',77),
    (7,22,290,'Plumbus','Just a regular old plumbus',176),
    (9,8,38,'Clock','Digital alarm clock',83),
    (5,50,360,'Hammock','Hammock',39),
    (6,22,65,'Wallet,','Leather wallet',115),
    (2,5,300,'Roomba','Roomba vacuum cleaner',86),
    (2,50,61,'WiFi Router','Wifi router',71),
    (5,84,38,'Detergent Pods','For laundry. Do not eat',159),
    (8,68,67,'Crockpot,','Slow cooker',41);

-- Payment Type (40)
INSERT INTO PaymentType([Name],[AcctNumber],[CustomerId]) 
    VALUES
    ('Mastercard','552 18120 06087 768',50),
    ('Mastercard','4539 8372 4325 2761',81),
    ('VISA','4929408110480',52),
    ('Mastercard','514 36479 61539 769',33),
    ('Mastercard','4909 4180 3773 0502',11),
    ('VISA','4024007144233185',16),
    ('Mastercard','5120 7666 9519 1635',19),
    ('VISA','4532251532261',61),
    ('VISA','4929289380514991',19),
    ('VISA','5129486506569512',91);
INSERT INTO PaymentType([Name],[AcctNumber],[CustomerId]) 
    VALUES
    ('Mastercard','528 03760 24493 128',10),
    ('VISA','4556627454561',6),
    ('VISA','4716140607075',2),
    ('VISA','553600 3462280641',5),
    ('Mastercard','5165 8300 3573 1322',6),
    ('VISA','5444780395118011',8),
    ('VISA','4532621291556',7),
    ('Mastercard','516144 3244778136',4),
    ('Mastercard','527650 173721 6898',6),
    ('VISA','4716055187253',2);
INSERT INTO PaymentType([Name],[AcctNumber],[CustomerId]) 
    VALUES
    ('VISA','4916577817730',4),
    ('Mastercard','551472 114475 6367',10),
    ('Mastercard','5402 3646 3794 7568',3),
    ('Mastercard','448 57232 75076 902',9),
    ('Mastercard','4539 9088 0733 1232',9),
    ('VISA','5381906367733678',10),
    ('VISA','4024007179662',5),
    ('Mastercard','546437 4249761351',4),
    ('Mastercard','531348 1002655044',5),
    ('Mastercard','557857 261189 1689',8);
INSERT INTO PaymentType([Name],[AcctNumber],[CustomerId]) 
    VALUES
    ('Mastercard','518387 9101314958',3),
    ('Mastercard','492926 4500264025',10),
    ('Mastercard','519766 349143 3691',10),
    ('Mastercard','4716 1809 9151 0436',7),
    ('VISA','4556641938599',9),
    ('Mastercard','4532 171 24 8667',9),
    ('Mastercard','553758 045358 6440',9),
    ('Mastercard','5534 6281 5196 0707',10),
    ('VISA','5334109182704416',3),
    ('Mastercard','4485 423 73 9951',4);

-- Order
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(17,24),(21,30),(66,13),(74,19),(40,2),(81,19),(76,8),(24,26),(71,4),(73,7);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(59,5),(60,4),(29,5),(57,31),(37,16),(13,14),(63,4),(90,15),(68,38),(22,35);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(47,19),(84,24),(72,35),(74,36),(20,1),(14,40),(9,9),(98,9),(36,2),(48,28);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(81,33),(13,35),(28,2),(33,22),(41,40),(91,11),(39,35),(34,1),(73,33),(52,23);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(49,21),(85,35),(90,5),(95,13),(28,4),(51,11),(54,37),(35,39),(45,1),(23,15);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(90,35),(80,20),(40,29),(91,26),(71,23),(4,8),(69,16),(35,7),(23,36),(19,14);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(53,17),(98,6),(15,1),(42,11),(37,29),(22,34),(37,29),(34,39),(10,13),(74,15);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(98,24),(78,15),(74,34),(40,40),(49,4),(83,27),(34,38),(94,37),(66,16),(43,24);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(14,15),(30,9),(68,3),(20,14),(16,29),(75,26),(81,25),(77,25),(1,36),(77,9);
INSERT INTO [Order]([CustomerId],[PaymentTypeId]) VALUES(76,7),(8,23),(77,13),(56,30),(11,38),(2,27),(45,39),(22,37),(37,19),(97,35);


-- OrderProduct (200)
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(84,14),(83,8),(99,45),(77,50),(23,24),(100,41),(99,10),(91,31),(97,10),(65,44);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(59,23),(43,38),(17,27),(72,37),(89,49),(49,16),(27,6),(98,1),(34,21),(51,13);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(76,10),(2,12),(12,46),(48,3),(95,35),(78,4),(54,39),(81,9),(22,3),(13,39);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(74,35),(23,8),(53,31),(22,2),(93,28),(77,9),(25,15),(1,36),(14,40),(20,25);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(81,3),(55,22),(58,14),(86,4),(74,15),(99,4),(49,45),(34,13),(89,49),(22,40);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(21,23),(35,33),(15,29),(62,10),(12,44),(39,29),(10,14),(50,36),(71,35),(15,18);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(47,34),(12,10),(68,39),(35,8),(31,42),(57,48),(86,20),(3,11),(70,1),(57,35);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(17,21),(73,17),(56,44),(37,5),(10,12),(57,45),(34,24),(60,5),(85,17),(25,20);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(10,25),(13,42),(18,47),(72,49),(82,30),(40,30),(33,7),(14,35),(65,48),(42,19);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(50,26),(55,16),(87,26),(52,14),(24,18),(17,45),(57,38),(12,41),(39,29),(71,43);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(10,19),(19,35),(7,30),(73,18),(97,35),(94,23),(81,15),(86,44),(14,34),(50,27);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(15,15),(44,3),(78,39),(96,30),(9,14),(7,9),(10,6),(20,25),(62,23),(8,3);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(27,27),(61,28),(99,5),(51,11),(26,30),(3,39),(46,21),(23,20),(38,36),(59,21);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(97,50),(100,14),(60,1),(32,38),(71,24),(79,43),(12,23),(37,34),(85,14),(62,18);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(35,3),(69,5),(2,13),(13,43),(60,35),(49,35),(98,33),(46,13),(88,45),(88,26);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(91,35),(93,2),(22,14),(37,13),(13,14),(4,25),(59,6),(65,48),(88,14),(13,40);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(37,2),(19,21),(41,40),(16,20),(99,18),(3,38),(11,1),(74,32),(4,36),(36,40);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(77,7),(86,21),(42,7),(76,29),(49,25),(39,3),(98,14),(92,33),(80,35),(10,40);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(33,42),(52,22),(14,36),(18,49),(94,1),(24,47),(63,12),(65,45),(14,49),(65,7);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(2,50),(66,25),(48,25),(72,39),(58,45),(73,33),(18,46),(20,1),(84,38),(63,47);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(79,41),(94,47),(85,17),(13,24),(97,42),(16,33),(3,30),(82,22),(30,47),(51,20);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(43,50),(85,34),(33,34),(83,43),(75,33),(35,31),(17,12),(24,9),(5,27),(94,29);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(27,30),(15,44),(42,13),(22,19),(17,17),(99,32),(68,16),(28,27),(64,26),(30,7);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(16,6),(91,9),(16,21),(22,20),(64,9),(64,36),(25,45),(55,19),(6,4),(79,22);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(35,29),(11,41),(88,7),(5,18),(59,11),(32,16),(17,11),(35,13),(96,24),(18,22);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(96,13),(73,1),(89,18),(74,33),(36,8),(74,4),(63,18),(22,43),(10,35),(31,25);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(50,37),(50,30),(54,38),(59,28),(68,46),(98,6),(19,15),(9,32),(61,9),(85,4);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(32,21),(42,1),(6,30),(5,16),(7,12),(42,46),(58,15),(20,29),(46,20),(65,9);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(70,32),(29,15),(66,40),(69,5),(78,31),(33,24),(13,43),(86,27),(44,16),(100,20);
INSERT INTO OrderProduct([OrderId],[ProductId]) VALUES(55,26),(72,6),(87,24),(79,17),(18,45),(2,26),(38,29),(25,21),(91,30),(76,2);
```