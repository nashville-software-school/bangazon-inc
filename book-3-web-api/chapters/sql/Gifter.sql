USE [master]
GO

IF db_id('Gifter') IS NULL
  CREATE DATABASE [Gifter]
GO

USE [Gifter]
GO



DROP TABLE IF EXISTS [Subscription];
DROP TABLE IF EXISTS [Comment];
DROP TABLE IF EXISTS [Post];
DROP TABLE IF EXISTS [UserProfile];



CREATE TABLE [Post] (
  [Id] integer PRIMARY KEY NOT NULL,
  [Title] nvarchar(255) NOT NULL,
  [ImageUrl] nvarchar(255) NOT NULL,
  [Caption] nvarchar(255),
  [UserProfileId] integer NOT NULL,
  [DateCreated] datetime NOT NULL
)
GO

CREATE TABLE [UserProilfe] (
  [Id] integer PRIMARY KEY NOT NULL,
  [Name] nvarchar(255) NOT NULL,
  [Email] nvarchar(255) NOT NULL,
  [ImageUrl] nvarchar(255),
  [Bio] nvarchar(255),
  [DateCreated] datetime NOT NULL
)
GO

CREATE TABLE [Comment] (
  [Id] integer PRIMARY KEY NOT NULL,
  [UserProfileId] integer NOT NULL,
  [PostId] integer NOT NULL,
  [Message] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Subscription] (
  [Id] integer PRIMARY KEY NOT NULL,
  [SubscriberId] integer NOT NULL,
  [ProviderId] integer NOT NULL
)
GO

ALTER TABLE [Post] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProilfe] ([Id])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([PostId]) REFERENCES [Post] ([Id])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProilfe] ([Id])
GO

ALTER TABLE [Subscription] ADD FOREIGN KEY ([SubscriberId]) REFERENCES [UserProilfe] ([Id])
GO

ALTER TABLE [Subscription] ADD FOREIGN KEY ([ProviderId]) REFERENCES [UserProilfe] ([Id])
GO




SET IDENTITY_INSERT [UserProfile] ON
INSERT INTO [UserProfile]
  ([Id], [Name], [Email], [ImageUrl], [Bio], [DateCreated])
VALUES 
  (1, 'Oliver Hardy', 'olie@email.com', null, null, '06-21-2020');
INSERT INTO [UserProfile]
  ([Id], [Name], [Email], [ImageUrl], [Bio])
VALUES 
  (2, 'Stan Laurel', 'stan@email.com', null, null, '04-20-2020');
SET IDENTITY_INSERT [UserProfile] OFF

SET IDENTITY_INSERT [Post] ON
INSERT INTO [Post]
  ([Id], [Title], [ImageUrl], [Caption], [UserProfileId], [DateCreated])
VALUES
  (1, 'Wait...what?', 'https://media.giphy.com/media/j609LflrIXInkLNMts/giphy.gif', null, 1, '06-22-2020'),
  (2, 'Stop that', 'https://media.giphy.com/media/jroyKTvw89Dh3J1sss/giphy.gif', 'There''s this guy. He''s in a hall. He want''s you to stop', 1, '06-23-2020'),
  (3, 'Paintball', 'https://media.giphy.com/media/l2R09jc6eZIlfXKlW/giphy.gif', 'I believe I will win', 1, '06-29-2020'),
  (4, 'People!', 'https://media.giphy.com/media/u8mNsDNfHCTUQ/giphy.gif', 'animals are better', 1, '06-29-2020'),
  (5, 'Laughter', 'https://media.giphy.com/media/5vGkcQV9AfDPy/giphy.gif', null, 2, '04-20-2020');
SET IDENTITY_INSERT [Post] OFF


SET IDENTITY_INSERT [Comment] ON
INSERT INTO [Comment]
  ([Id], [UserProfileId], [PostId], [Message])
VALUES
  (1, 2, 1, 'A comment is a comment is a comment');
SET IDENTITY_INSERT [Comment] OFF