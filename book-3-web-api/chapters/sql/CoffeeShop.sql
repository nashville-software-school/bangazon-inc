USE [master]
GO

IF db_id('CoffeeShop') IS NULL
  CREATE DATABASE [CoffeeShop]
GO

USE [CoffeeShop]
GO


DROP TABLE IF EXISTS Coffee;
DROP TABLE IF EXISTS BeanVariety;


CREATE TABLE BeanVariety (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL,
    Region VARCHAR(255) NOT NULL,
    Notes TEXT
);

CREATE TABLE Coffee (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Title VARCHAR(50) NOT NULL,
    BeanVarietyId INTEGER NOT NULL,

    CONSTRAINT [FK_Coffee_BeanVariety] FOREIGN KEY ([BeanVarietyId]) REFERENCES [BeanVariety] ([Id])
);


SET IDENTITY_INSERT BeanVariety ON
INSERT INTO BeanVariety 
    (Id, [Name], Region, Notes)
VALUES 
    (1, 'Arusha', 'Mount Meru in Tanzania, and Papua New Guinea', NULL),
    (2, 'Benguet', 'Philippines', 'Typica variety grown in Benguet in the Cordillera highlands of the northern Philippines since 1875.'),
    (3, 'Catuai', 'Latin America', 'This is a hybrid of Mundo Novo and Caturra bred in Brazil in the late 1940s.'),
    (4, 'Typica', 'Worldwide', ' 	Typica originated from Yemeni stock, taken first to Malabar, India, and later to Indonesia by the Dutch, and the Philippines by the Spanish'),
    (5, 'Ruiru 11', 'Kenya', 'Ruiru 11 was released in 1985 by the Kenyan Coffee Research Station. While the variety is generally disease resistant, it produces a lower cup quality than K7, SL28 and 34');
SET IDENTITY_INSERT BeanVariety OFF
    

SET IDENTITY_INSERT Coffee ON
INSERT INTO Coffee 
    (Id, Title, BeanVarietyId)
VALUES 
    (1, 'Espresso', 2), 
    (2, 'Cafe Con Leche', 3), 
    (3, 'Cappuccino', 1);
SET IDENTITY_INSERT Coffee OFF

