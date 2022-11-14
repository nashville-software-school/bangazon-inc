USE [master]
GO

IF db_id('Streamish') IS NOT NULL
BEGIN
  ALTER DATABASE [Streamish] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [Streamish]
END
GO

CREATE DATABASE [Streamish]
GO

USE [Streamish]
GO

---------------------------------------------------------------------------

CREATE TABLE [UserProfile] (
  [Id] INTEGER PRIMARY KEY IDENTITY NOT NULL,
  [Name] VARCHAR(25) NOT NULL,
  [Email] VARCHAR(255) NOT NULL,
  [ImageUrl] VARCHAR(255) NULL,
  [DateCreated] DATETIME NOT NULL
)
GO

CREATE TABLE [Video] (
  [Id] INTEGER PRIMARY KEY IDENTITY NOT NULL,
  [Title] VARCHAR(255) NOT NULL,
  [Description] VARCHAR(MAX),
  [Url] VARCHAR(255) NOT NULL,
  [DateCreated] DATETIME NOT NULL,
  [UserProfileId] INTEGER NOT NULL,

  CONSTRAINT FK_Video_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(Id)
)
GO

CREATE TABLE [Comment] (
  [Id] INTEGER PRIMARY KEY IDENTITY NOT NULL,
  [Message] VARCHAR(MAX) NOT NULL,
  [VideoId] INTEGER NOT NULL,
  [UserProfileId] INTEGER NOT NULL,

  CONSTRAINT FK_Comment_Video FOREIGN KEY (VideoId) REFERENCES Video(Id),
  CONSTRAINT FK_Comment_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(Id)
)
GO

CREATE TABLE [Favorite] (
  [Id] INTEGER PRIMARY KEY IDENTITY NOT NULL,
  [VideoId] INTEGER NOT NULL,
  [UserProfileId] INTEGER NOT NULL,

  CONSTRAINT FK_Favorite_Video FOREIGN KEY (VideoId) REFERENCES Video(Id),
  CONSTRAINT FK_Favorite_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(Id)
)
GO
 
---------------------------------------------------------------------------

SET IDENTITY_INSERT [UserProfile] ON
INSERT INTO [UserProfile]
    ([Id], [Name], [Email], [DateCreated], [ImageUrl])
VALUES
    (1, 'Groucho', 'groucho@marx.com', SYSDATETIME(), NULL),
    (2, 'Harpo', 'harpo@marx.com', SYSDATETIME(), NULL),
    (3, 'Chico', 'chico@marx.com', SYSDATETIME(), NULL);
SET IDENTITY_INSERT [UserProfile] OFF


SET IDENTITY_INSERT [Video] ON
INSERT INTO [Video]
    ([Id], [DateCreated], [Title], [Description], [Url], [UserProfileId])
VALUES
    (1, '2019-10-3', 'Erlang the Movie', 'A beautiful film about an elegant, but ugly lanaguage', 'https://www.youtube.com/embed/xrIjfIjssLE', 1),
    (2, '2019-5-20', 'Early Computing', 'Early Computing: Crash Course Computer Science #1', 'https://www.youtube.com/embed/O5nskjZ_GoI', 2),
    (3, '2020-1-2', 'C# 101', 'What is C#? It''s a powerful and widely used programming language that you can use to make websites, games, mobile apps, desktop apps and more with .NET', 'https://www.youtube.com/embed/BM4CHBmAPh4', 2),
    (4, '2020-12-15', '.NET 101', 'What is .NET, anyway?', 'https://www.youtube.com/embed/eIHKZfgddLM', 3)
SET IDENTITY_INSERT [Video] OFF


SET IDENTITY_INSERT [Comment] ON
INSERT INTO [Comment]
    ([Id], [Message], [VideoId], [UserProfileId])
VALUES
    (1, 'I have thoughts about this video! ...thoughts AND OPINIONS!', 1, 2),
    (2, 'This video makes me angry on the internet!!!', 1, 3)
SET IDENTITY_INSERT [Comment] OFF

