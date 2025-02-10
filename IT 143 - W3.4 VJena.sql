/*****************************************************************************************************************
NAME:    Adventure Works 
PURPOSE: Creating answers
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/02/2025      VJena   1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This script is for the answers to my adventure works questions 
 
******************************************************************************************************************/

-- Q1: What is the total number of products available in the AdventureWorks inventory?

 
  SELECT COUNT(*) AS TotalNumberOfProduct

-- Q2: How many customers are based in the state of California?

SELECT COUNT(*) AS NumberOfCustomersInCalifornia

-- Q3: How many active customers does AdventureWorks currently have?

SELECT COUNT(*) AS ActiveCustomerCount

-- Q4: What is the total number of sales transactions recorded in the database?

SELECT COUNT(*) AS TotalSalesTransaction

-- Q5: How many total customers have placed orders in the United States?

SELECT COUNT(*) AS TotalCustomersInUS

--Q6: How many employees work in the Marketing department?
   
SELECT COUNT(*) AS EmployeesInMarketing

--Q7: Which tables in AdventureWorks have relationships with the "SalesOrderDetail" table through foreign keys, and what are the key column names?

 SELECT 
    fk.name AS FK_name,
    tp.name AS ReferencedTable,
    refc.name AS ReferencedColumn,
    rt.name AS ReferencingTable,
    rc.name AS ReferencingColumn
FROM 
    sys.foreign_keys AS fk
JOIN 
    sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
JOIN 
    sys.tables AS tp ON fkc.referenced_object_id = tp.object_id
JOIN 
    sys.columns AS refc ON fkc.referenced_column_id = refc.column_id AND tp.object_id = refc.object_id
JOIN 
    sys.tables AS rt ON fkc.parent_object_id = rt.object_id
JOIN 
    sys.columns AS rc ON fkc.parent_column_id = rc.column_id AND rt.object_id = rc.object_id
WHERE 
    rt.name = 'SalesOrderDetail';

--Q8: Can you list all tables in the AdventureWorks database that contain a column called "CustomerID"?

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'CustomerID';

    SELECT GETDATE() AS my_date;