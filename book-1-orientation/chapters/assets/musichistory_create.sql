USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'MusicHistory'
)
CREATE DATABASE MusicHistory
GO

USE MusicHistory
GO
