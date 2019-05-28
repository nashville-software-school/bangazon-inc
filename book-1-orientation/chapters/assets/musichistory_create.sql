USE MASTER
GO

IF NOT EXISTS (
    SELECT [name]
    FROM sys.databases
    WHERE [name] = N'Music History'
)
CREATE DATABASE Music History
GO

USE Music History
GO
