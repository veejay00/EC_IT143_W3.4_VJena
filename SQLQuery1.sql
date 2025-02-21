SELECT pa.*
  FROM Person.Address AS pa
WHERE pa.city = 'Bothell';

USE [AdventureWorks2022]
GO
CREATE NONCLUSTERED INDEX IX_my_Address_StateProvinceID
ON [Person].[Address] ([City])

Go