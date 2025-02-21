-- Step 1: Create the Customers table
CREATE TABLE v_w3_schools_customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100),
    Country VARCHAR(50)
);

-- Step 2: Insert data into Customers table
INSERT INTO dbo.v_w3_schools_customers  (CustomerID, CustomerName, ContactName, Address, City, Country)
VALUES
    (1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209'),
    (2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '5021'),
    (3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '5023'),
    (4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP'),
    (5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22'),
    (6, 'Blauer See Delikatessen', 'Hanna Moos', 'Forsterstr. 57', 'Mannheim', '68306'),
    (7, 'Blondel père et fils', 'Frédérique Citeaux', '24, place Kléber', 'Strasbourg', '67000'),
    (8, 'Bólido Comidas preparadas', 'Martín Sommer', 'C/ Araquil, 67', 'Madrid', '28023'),
    (9, 'Bon app''', 'Laurence Lebihans', '12, rue des Bouchers', 'Marseille', '13008'),
    (10, 'Bottom-Dollar Marketse', 'Elizabeth Lincoln', '23 Tsawassen Blvd.', 'Tsawassen', 'T2F 8M4'),
    (11, 'B''s Beverages', 'Victoria Ashworth', 'Fauntleroy Circus', 'London', 'EC2 5NT'),
    (12, 'Cactus Comidas para llevar', 'Patricio Simpson', 'Cerrito 333', 'Buenos Aires', '1010'),
    (13, 'Centro comercial Moctezuma', 'Francisco Chang', 'Sierras de Granada 9993', 'México D.F.', '5022'),
    (14, 'Chop-suey Chinese', 'Yang Wang', 'Hauptstr. 29', 'Bern', '3012'),
    (15, 'Comércio Mineiro', 'Pedro Afonso', 'Av. dos Lusíadas, 23', 'São Paulo', '05432-043');

-- Step 3: Create the View
CREATE VIEW dbo.v_w3_school_customers AS
SELECT CustomerID, CustomerName, ContactName, Address, City, Country
FROM Customers;

-- Q: How to extract first name from Contact Name?
-- A: Well, here is your problem...

SELECT t.ContactName
  FROM dbo.v_w3_schools_customers AS t
ORDER BY 1; 

--https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

SELECT t.ContactName
     , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') -1) AS first_name
  FROM dbo.v_w3_schools_customers AS t
 ORDER BY 1;

CREATE FUNCTION [dbo].[udf_parse_first_name]
(@v_combined_name AS VARCHAR(500)
)
RETURNS  VARCHAR(100)

/*****************************************************************************************************************
NAME:    dbo.udf_parse-first_name
PURPOSE: Parse First Name From combined name

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     02/21/2025   V Jena      1. Built this script for EC IT440


RUNTIME: 
1s

NOTES: 
Adapted from the following...
https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name
 
******************************************************************************************************************/

-- Q1: What should go here?
-- A1: Question goes on the previous line, intoduction to the answer goes on this line...

  BEGIN 
    
      DECLARE @v_first_name AS VARCHAR(100);

	  SET @v_first_name = left(@v_combined_name, CHARINDEX(' ', @v_combined_name + ' ') -1);

	  RETURN @v_first_name;

   END;

GO

SELECT t.ContactName
     , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') -1) AS first_name
	 ,dbo.udf_parse_first_name(t.ContactName) AS First_name2
  FROM   dbo.v_w3_school_customers AS t
  ORDER BY 1;

WITH s1 --Use a Common Table Expression and compare first_name to first_name2
     AS (SELECT t.ContactName
              , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') -1) AS first_name
	          ,dbo.udf_parse_first_name(t.ContactName) AS First_name2
          FROM dbo.v_w3_school_customers AS t)
	SELECT s1.*
	 FROM  s1
	 WHERE s1.first_name <> s1.first_name2; 

SELECT t.CustomerID
     , t.CustomerName
	 , t.ContactName
	 , dbo.udf_parse_first_name(t.ContactName) AS ContactName_first_name
	 , ''AS ContactName_last_name
	 , t.City
	 , t.Country 
 FROM dbo.v_w3_school_customers AS t
 ORDER BY 3