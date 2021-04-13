USE [master]

IF db_id('Roommates') IS NULl
    CREATE DATABASE [Roommates]
GO

use [Roommates]
go



DROP TABLE IF EXISTS RoommateChore;
DROP TABLE IF EXISTS Chore;
DROP TABLE IF EXISTS Roommate;
DROP TABLE IF EXISTS Room;



CREATE TABLE Room (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(55) NOT NULL,
    MaxOccupancy INTEGEr NOT NULL
);

CREATE TABLE Roommate (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(55) NOT NULL,
    LastName NVARCHAR(55) NOT NULL,
    RentPortion INTEGEr NOT NULL,
    MoveInDate DATETIME NOT NULL,
    RoomId INTEGER NOT NULL,

    CONSTRAINT FK_Roommate_Room FOREIGN KEY(RoomId) REFERENCES Room(Id)
);

CREATE TABLE Chore (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(55) NOT NULL
);

CREATE TABLE RoommateChore (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    RoommateId INTEGER NOT NULL,
    ChoreID INTEGER NOT NULL,

    CONSTRAINT FK_RoommateChore_Roomate FOREIGN KEY(RoommateId) REFERENCES Roommate(Id),
    CONSTRAINT FK_RoommateChore_Chore FOREIGN KEY(ChoreId) REFERENCES Chore(Id)
);



INSERT INTO Room 
    ([Name], MaxOccupancy)
VALUES 
    ('Front Bedroom', 4),
    ('Back Bedroom', 6),
    ('Living Room', 6),
    ('Kitchen', 2),
    ('Attic', 20),
    ('Basement', 12);


INSERT INTO Roommate
    (FirstName, LastName, RentPortion, MoveInDate, RoomId)
VALUES
    ('Wilma', 'Heartgoon', 10, '2019-10-31', 3),
    ('Juan', 'Piesapestosos', 10, '2019-10-31', 5),
    ('Karen', 'Kidsthesedays', 50, '1981-07-01', 1);


-- TODO: Add some data for the Chore and RoommateChore tables

