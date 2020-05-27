USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'DogWalkerMVC'
)
CREATE DATABASE DogWalkerMVC
GO

USE DogWalkerMVC
GO


DROP TABLE IF EXISTS Walks;
DROP TABLE IF EXISTS Walker;
DROP TABLE IF EXISTS Dog;
DROP TABLE IF EXISTS [Owner];
DROP TABLE IF EXISTS Neighborhood;


CREATE TABLE Neighborhood (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL
);

CREATE TABLE [Owner] (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	[Address] VARCHAR(255) NOT NULL,
	NeighborhoodId INTEGER,
	Phone VARCHAR(55) NOT NULL,
	CONSTRAINT FK_Owner_Neighborhood FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(Id)
);

CREATE TABLE Dog (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	OwnerId INTEGER NOT NULL,
	Breed VARCHAR(55) NOT NULL,
	Notes VARCHAR(255),
	ImageUrl VARCHAR(255),
	CONSTRAINT FK_Dog_Owner FOREIGN KEY (OwnerId) REFERENCES [Owner](Id)
);

CREATE TABLE Walker (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	NeighborhoodId INTEGER,
	CONSTRAINT FK_Walker_Neighborhood FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(Id)
);

CREATE TABLE Walks (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Date] DATETIME NOT NULL,
	Duration INTEGER NOT NULL,
	WalkerId INTEGER NOT NULL,
	DogId INTEGER NOT NULL,
	CONSTRAINT FK_Walks_Walker FOREIGN KEY (WalkerId) REFERENCES Walker(Id),
	CONSTRAINT FK_Walks_Dog FOREIGN KEY (DogId) REFERENCES Dog(Id)
);

INSERT INTO Neighborhood ([Name]) VALUES ('East Nashville');
INSERT INTO Neighborhood ([Name]) VALUES ('Antioch');
INSERT INTO Neighborhood ([Name]) VALUES ('Berry Hill');
INSERT INTO Neighborhood ([Name]) VALUES ('Germantown');
INSERT INTO Neighborhood ([Name]) VALUES ('The Gulch');

INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('John Sanchez', '355 Main St', 1, '(615)-553-2456');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('Patricia Young', '233 Washington St', 2, '(615)-448-5521');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('Robert Brown', '145 Sixth Ave', 3, '(615)-323-7711');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('Jennifer Wilson', '495 Cedar Rd', 1, '(615)-919-8944');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('Michael Moore', '88 Oak St', 2, '(615)-556-7273');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('Linda Green', '53 Lake Cir', 3, '(615)-339-4488');
INSERT INTO [Owner] ([Name], [Address], NeighborhoodId, Phone) VALUES ('William Anderson', '223 Hill St', 1, '(615)-232-6768');

INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Ninni', 1, 'Rottweiler');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Kuma', 1, 'Rottweiler');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Remy', 2, 'Greyhound');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Xyla', 3, 'Dalmation');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Chewy', 3, 'Beagle');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Groucho', 4, 'Dalmation');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Finley', 5, 'Golden Retriever');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Casper', 6, 'Golden Retriever');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Bubba', 7, 'English Bulldog');
INSERT INTO Dog ([Name], OwnerId, Breed) VALUES ('Zeus', 7, 'Schnauzer');

INSERT INTO Walker ([Name], NeighborhoodId) VALUES ('Paul Thompson', 1);
INSERT INTO Walker ([Name], NeighborhoodId) VALUES ('Margaret Phillips', 1);
INSERT INTO Walker ([Name], NeighborhoodId) VALUES ('Anthony Gray', 2);
INSERT INTO Walker ([Name], NeighborhoodId) VALUES ('Melissa Perez', 3);

INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-09 17:30:00', 1200, 1, 1);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-10 17:30:00', 1200, 1, 2);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-08 16:00:00', 900, 2, 9);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-09 08:30:00', 1800, 2, 6);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-10 12:00:00', 1750, 3, 3);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-08 09:00:00', 1275, 3, 7);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-09 13:30:00', 2000, 4, 4);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId) VALUES ('2020-04-09 13:30:00', 2000, 4, 5);