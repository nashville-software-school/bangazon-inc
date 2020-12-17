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
DROP TABLE IF EXISTS WalkStatus;
DROP TABLE IF EXISTS Walker;
DROP TABLE IF EXISTS Dog;
DROP TABLE IF EXISTS [Owner];
DROP TABLE IF EXISTS Neighborhood;
GO

CREATE TABLE Neighborhood (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL
);

CREATE TABLE [Owner] (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	Email VARCHAR(255) NOT NULL,
	[Name] VARCHAR(55) NOT NULL,
	[Address] VARCHAR(255) NOT NULL,
	NeighborhoodId INTEGER,
	Phone VARCHAR(55) NOT NULL,
	CONSTRAINT FK_Owner_Neighborhood FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(Id),
	CONSTRAINT UQ_OWNER_Email UNIQUE(Email)
);

CREATE TABLE Dog (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	OwnerId INTEGER NOT NULL,
	Breed VARCHAR(55) NOT NULL,
	Notes VARCHAR(255),
	ImageUrl VARCHAR(255),
	CONSTRAINT FK_Dog_Owner FOREIGN KEY (OwnerId) REFERENCES [Owner](Id) ON DELETE CASCADE
);

CREATE TABLE Walker (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Name] VARCHAR(55) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	ImageUrl VARCHAR(255),
	NeighborhoodId INTEGER,
	CONSTRAINT FK_Walker_Neighborhood FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(Id),
	CONSTRAINT UQ_WALKER_Email UNIQUE(Email)
);

CREATE TABLE WalkStatus (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Description] VARCHAR(55) NOT NULL,
);

CREATE TABLE Walks (
	Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
	[Date] DATETIME NOT NULL,
	Duration INTEGER NOT NULL,
	WalkerId INTEGER NOT NULL,
	DogId INTEGER NOT NULL,
    WalkStatusId INTEGER NOT NULL,
	CONSTRAINT FK_Walks_Walker FOREIGN KEY (WalkerId) REFERENCES Walker(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Walks_Dog FOREIGN KEY (DogId) REFERENCES Dog(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Walks_WalkStatus FOREIGN KEY (WalkStatusId) REFERENCES WalkStatus(Id),
);


INSERT INTO Neighborhood ([Name]) VALUES ('East Nashville');
INSERT INTO Neighborhood ([Name]) VALUES ('Antioch');
INSERT INTO Neighborhood ([Name]) VALUES ('Berry Hill');
INSERT INTO Neighborhood ([Name]) VALUES ('Germantown');
INSERT INTO Neighborhood ([Name]) VALUES ('The Gulch');
INSERT INTO Neighborhood ([Name]) VALUES ('Downtown');
INSERT INTO Neighborhood ([Name]) VALUES ('Music Row');
INSERT INTO Neighborhood ([Name]) VALUES ('Hermitage');
INSERT INTO Neighborhood ([Name]) VALUES ('Madison');
INSERT INTO Neighborhood ([Name]) VALUES ('Green Hills');
INSERT INTO Neighborhood ([Name]) VALUES ('Midtown');
INSERT INTO Neighborhood ([Name]) VALUES ('West Nashville');
INSERT INTO Neighborhood ([Name]) VALUES ('Donelson');
INSERT INTO Neighborhood ([Name]) VALUES ('North Nashville');
INSERT INTO Neighborhood ([Name]) VALUES ('Belmont-Hillsboro');

INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('John Sanchez', 'john@gmail.com', '355 Main St', 1, '(615)-553-2456');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('Patricia Young', 'patty@gmail.com', '233 Washington St', 2, '(615)-448-5521');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('Robert Brown', 'robert@gmail.com', '145 Sixth Ave', 3, '(615)-323-7711');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('Jennifer Wilson', 'Jennifer@gmail.com', '495 Cedar Rd', 1, '(615)-919-8944');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('Michael Moore', 'mike@gmail.com', '88 Oak St', 2, '(615)-556-7273');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('Linda Green', 'linda@gmail.com', '53 Lake Cir', 3, '(615)-339-4488');
INSERT INTO [Owner] ([Name], Email, [Address], NeighborhoodId, Phone) VALUES ('William Anderson', 'willy@gmail.com', '223 Hill St', 1, '(615)-232-6768');

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


INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Claudelle', 'Claudelle@gmail.com', 'https://avatars.dicebear.com/v2/female/c117aa483c649ecbc46c6d65172bf6e6.svg', 15);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Roi', 'Roi@gmail.com', 'https://avatars.dicebear.com/v2/male/ebf2f3a7c07a83e6bce11358860bec57.svg', 9);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Shena', 'Shena@gmail.com', 'https://avatars.dicebear.com/v2/female/08c75cdd62072da8400654c560a5ed6b.svg', 10);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Gibb', 'Gibb@gmail.com', 'https://avatars.dicebear.com/v2/male/6640bd96cd90587bf8e00d9e7f187b36.svg', 8);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Tammy', 'Tammy@gmail.com', 'https://avatars.dicebear.com/v2/female/e092d74ffd42e2d1d1be3e3f71b88289.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Rufe', 'Rufe@gmail.com', 'https://avatars.dicebear.com/v2/male/3a47dbe77df7fcab368e15983a39725c.svg', 11);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Cassandry', 'Cassandry@gmail.com', 'https://avatars.dicebear.com/v2/female/91c2e90fb83e3a21d388c84de5746b60.svg', 12);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Cully', 'Cully@gmail.com', 'https://avatars.dicebear.com/v2/male/bdd61e876afcf343969a266c9fdfb111.svg', 4);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Agnesse', 'Agnesse@gmail.com', 'https://avatars.dicebear.com/v2/female/08f7c5edb1dd8760e24283373c640a7b.svg', 14);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Koo', 'Koo@gmail.com', 'https://avatars.dicebear.com/v2/male/0156bd784b34e8939bb52051c6f0dc44.svg', 1);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Diana', 'Diana@gmail.com', 'https://avatars.dicebear.com/v2/female/14e803e1cf517d1d4d3eef8ba7fc60bf.svg', 7);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Moreen', 'Moreen@gmail.com', 'https://avatars.dicebear.com/v2/female/bb9466af25bc563d1aabb6dd483691ec.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Sonni', 'Sonni@gmail.com', 'https://avatars.dicebear.com/v2/male/1277989709535d07963ab9e151a94645.svg', 7);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Nadiya', 'Nadiya@gmail.com', 'https://avatars.dicebear.com/v2/female/163709759da882ea4e2cc3d3861a3096.svg', 13);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Olag', 'Olag@gmail.com', 'https://avatars.dicebear.com/v2/male/df7fc4df997b29e3b85053f147b6e160.svg', 9);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Alasdair', 'Alasdair@gmail.com', 'https://avatars.dicebear.com/v2/male/c67a009970c7a35cda8039f70219520e.svg', 12);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Jo ann', 'Joann@gmail.com', 'https://avatars.dicebear.com/v2/female/4b6292a84c37f09b7a0582b664f729fb.svg', 12);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Ewen', 'Ewen@gmail.com', 'https://avatars.dicebear.com/v2/male/e62a9cecd6a394ddc316865298fcdae2.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Andee', 'Andee@gmail.com', 'https://avatars.dicebear.com/v2/male/88743740e1662fc6a5869572374b0202.svg', 5);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Sada', 'Sada@gmail.com', 'https://avatars.dicebear.com/v2/male/84176a49e936b8e96cc59ec6c93204d5.svg', 12);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Tasia', 'Tasia@gmail.com', 'https://avatars.dicebear.com/v2/female/03d18e3cc792c17b2b56f2d6020f7aaa.svg', 3);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Sherry', 'Sherry@gmail.com', 'https://avatars.dicebear.com/v2/female/d34b3224c0b0c634d079268793fc24bf.svg', 5);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Witty', 'Witty@gmail.com', 'https://avatars.dicebear.com/v2/male/096016a22a50249a13e8b65edce2a8bd.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Ezekiel', 'Ezekiel@gmail.com', 'https://avatars.dicebear.com/v2/male/5c547461917ca2e1c3822918e206caaf.svg', 5);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Emmeline', 'Emmeline@gmail.com', 'https://avatars.dicebear.com/v2/female/2c42187eaa119e3c5f428c5a585335a6.svg', 1);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Darrick', 'Darrick@gmail.com', 'https://avatars.dicebear.com/v2/male/95fcc9b6b982ddf29995b444f2e051f6.svg', 9);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Redford', 'Redford@gmail.com', 'https://avatars.dicebear.com/v2/male/e24b38d3697510528018612d833ea86f.svg', 14);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Kippie', 'Kippie@gmail.com', 'https://avatars.dicebear.com/v2/male/4a82ce26c283a47a19f358848148f2a6.svg', 2);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Gayleen', 'Gayleen@gmail.com', 'https://avatars.dicebear.com/v2/female/08c75cdd62072da8400654c560a5ed6b.svg', 7);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Tony', 'Tony@gmail.com', 'https://avatars.dicebear.com/v2/male/045851a484e7fa012df4caf5abdf8d70.svg', 14);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Trever', 'Trever@gmail.com', 'https://avatars.dicebear.com/v2/male/39e345ca7674521b91727ffdfce820fc.svg', 11);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Juieta', 'Juieta@gmail.com', 'https://avatars.dicebear.com/v2/female/bc4376e3cff539569b327a369dd07d93.svg', 5);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Briny', 'Briny@gmail.com', 'https://avatars.dicebear.com/v2/male/924f410b03365286d91be381b1de557e.svg', 3);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Claudette', 'Claudette@gmail.com', 'https://avatars.dicebear.com/v2/female/e6e514d1e0fdf15d84693d59f63ea0d4.svg', 14);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Melessa', 'Melessa@gmail.com', 'https://avatars.dicebear.com/v2/female/8eb9c006f613724ee3ca7a55901c8a49.svg', 3);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Thaxter', 'Thaxter@gmail.com', 'https://avatars.dicebear.com/v2/male/df7fc4df997b29e3b85053f147b6e160.svg', 15);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Andy', 'Andy@gmail.com', 'https://avatars.dicebear.com/v2/male/ebf2f3a7c07a83e6bce11358860bec57.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Bonnie', 'Bonnie@gmail.com', 'https://avatars.dicebear.com/v2/female/2b991b0897d31032383f6d59ce02becb.svg', 3);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Thibaud', 'Thiband@gmail.com', 'https://avatars.dicebear.com/v2/male/0afa0b256de6694e5823980d8cca11ff.svg', 12);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Cristabel', 'Cristabel@gmail.com', 'https://avatars.dicebear.com/v2/female/4b6292a84c37f09b7a0582b664f729fb.svg', 7);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Elfrieda', 'Elfrieda@gmail.com', 'https://avatars.dicebear.com/v2/female/a2b6eb5dc1093f4b6fd8b8e973c5f291.svg', 4);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Daryn', 'Daryn@gmail.com', 'https://avatars.dicebear.com/v2/male/6ea4f4234ca9a2cf83a193110ab3f96a.svg', 15);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Corney', 'Corney@gmail.com', 'https://avatars.dicebear.com/v2/male/19fa24bf6e089d4c591304f9a79f5102.svg', 2);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Janeczka', 'Janeczka@gmail.com', 'https://avatars.dicebear.com/v2/female/fa94752e3c6101f5abb2743fcd701619.svg', 10);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Golda', 'Golda@gmail.com', 'https://avatars.dicebear.com/v2/male/a335368f726b814c43da589c07244b47.svg', 15);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Polly', 'Polly@gmail.com', 'https://avatars.dicebear.com/v2/female/163709759da882ea4e2cc3d3861a3096.svg', 7);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Shaughn', 'Shaughn@gmail.com', 'https://avatars.dicebear.com/v2/male/8138849e241c885652134ca6ab7cd337.svg', 9);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Hilliary', 'Hilliary@gmail.com', 'https://avatars.dicebear.com/v2/female/8eb9c006f613724ee3ca7a55901c8a49.svg', 15);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Beilul', 'Beilul@gmail.com', 'https://avatars.dicebear.com/v2/male/3483b1f7f691e7ded77bb828df752554.svg', 6);
INSERT INTO Walker ([Name], Email, ImageUrl, NeighborhoodId) values ('Marcille', 'Marcille@gmail.com', 'https://avatars.dicebear.com/v2/male/e62a9cecd6a394ddc316865298fcdae2.svg', 12);

INSERT INTO WalkStatus ([Description]) VALUES ('Pending');
INSERT INTO WalkStatus ([Description]) VALUES ('Approved');
INSERT INTO WalkStatus ([Description]) VALUES ('Completed');

INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-09 17:30:00', 1200, 1, 1, 1);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-10 17:30:00', 1200, 1, 2, 1);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-08 16:00:00', 900, 2, 9, 2);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-09 08:30:00', 1800, 2, 6, 3);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-10 12:00:00', 1750, 3, 3, 3);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-08 09:00:00', 1275, 3, 7, 3);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-09 13:30:00', 2000, 4, 4, 3);
INSERT INTO Walks ([Date], Duration, WalkerId, DogId, WalkStatusId) VALUES ('2020-04-09 13:30:00', 2000, 4, 5, 3);
