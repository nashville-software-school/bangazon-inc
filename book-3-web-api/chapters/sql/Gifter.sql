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
  [Id] integer identity PRIMARY KEY NOT NULL,
  [Title] nvarchar(255) NOT NULL,
  [ImageUrl] nvarchar(255) NOT NULL,
  [Caption] nvarchar(255),
  [UserProfileId] integer NOT NULL
)
GO

CREATE TABLE [UserProfile] (
  [Id] integer identity PRIMARY KEY NOT NULL,
  [Name] nvarchar(255) NOT NULL,
  [Email] nvarchar(255) NOT NULL,
  [ImageUrl] nvarchar(255),
  [Bio] nvarchar(255)
)
GO

CREATE TABLE [Comment] (
  [Id] integer identity PRIMARY KEY NOT NULL,
  [UserProfileId] integer NOT NULL,
  [PostId] integer NOT NULL,
  [Message] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Subscription] (
  [Id] integer identity PRIMARY KEY NOT NULL,
  [SubscriberId] integer NOT NULL,
  [ProviderId] integer NOT NULL
)
GO

ALTER TABLE [Post] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([PostId]) REFERENCES [Post] ([Id])
GO

ALTER TABLE [Comment] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id])
GO

ALTER TABLE [Subscription] ADD FOREIGN KEY ([SubscriberId]) REFERENCES [UserProfile] ([Id])
GO

ALTER TABLE [Subscription] ADD FOREIGN KEY ([ProviderId]) REFERENCES [UserProfile] ([Id])
GO


SET IDENTITY_INSERT [UserProfile] ON
INSERT INTO [UserProfile]
  ([Id], [Name], [Email], [ImageUrl], [Bio])
VALUES 
  (1, 'Oliver Hardy', 'olie@email.com', null, null);
INSERT INTO [UserProfile]
  ([Id], [Name], [Email], [ImageUrl], [Bio])
VALUES 
  (2, 'Stan Laurel', 'stan@email.com', null, null);
SET IDENTITY_INSERT [UserProfile] OFF

SET IDENTITY_INSERT [Post] ON
INSERT INTO [Post]
  ([Id], [Title], [ImageUrl], [Caption], [UserProfileId])
VALUES
  (1, 'Wait...what?', 'https://media.giphy.com/media/j609LflrIXInkLNMts/giphy.gif', null, 1),
  (2, 'Stop that', 'https://media.giphy.com/media/jroyKTvw89Dh3J1sss/giphy.gif', 'There''s this guy. He''s in a hall. He want''s you to stop', 1),
  (3, 'Paintball', 'https://media.giphy.com/media/l2R09jc6eZIlfXKlW/giphy.gif', 'I believe I will win', 1),
  (4, 'People!', 'https://media.giphy.com/media/u8mNsDNfHCTUQ/giphy.gif', 'animals are better', 1),
  (5, 'Laughter', 'https://media.giphy.com/media/5vGkcQV9AfDPy/giphy.gif', null, 2);
SET IDENTITY_INSERT [Post] OFF
