---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 4
---------------------------------------------------------------------

USE AdventureWorks2012;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Open the project file F:\10774A_Labs\10774A_07_PRJ\10774A_07_PRJ.ssmssln and the T-SQL script 81 - Lab Exercise 4.sql. Ensure that you are connected to the TSQL2012 database.
--
-- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table. Based on this column, add a calculated column named lastname, which should consist of all the characters before the comma.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 82 - Lab Exercise 4 - Task 1 Result.txt. 
---------------------------------------------------------------------
select contactname, 
SUBSTRING(contactname, 0, CHARINDEX(N',', contactname)) as lastname
from Sales.Customers



---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table and replace the comma in the contact name with an empty string. Based on this column, add a calculated column named firstname, which should consist of all the characters after the comma.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 83 - Lab Exercise 4 - Task 2 Result.txt. 
---------------------------------------------------------------------
SELECT
	REPLACE(contactname, ',', '') AS newcontactname,
	SUBSTRING(contactname, CHARINDEX(N',', contactname)+1, LEN(contactname)-CHARINDEX(N',', contactname)+1) AS firstname
FROM Sales.Customers;

---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to retrieve the custid column from the Sales.Customers table. Add a new calculated column to create a string representation of the custid as a fixed-width (6 characters) customer code prefixed with the letter C and leading zeros. For example, the custid value 1 should look like C00001.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 84 - Lab Exercise 4 - Task 3 Result.txt. 
---------------------------------------------------------------------

SELECT 
	custid,
	N'C' + RIGHT(REPLICATE('0', 5) + CAST(custid AS VARCHAR(5)), 5) AS custnewid
FROM Sales.Customers;

-- new function in SQL Server 2012
SELECT
	FORMAT(custid, N'\C00000')
FROM Sales.Customers;

---------------------------------------------------------------------
-- Task 4
--
-- Write a SELECT statement to retrieve the contactname column from the Sales.Customers table. Add a calculated column, which should count the number of occurrences of the character ‘a’ inside the contact name. (Hint: Use the string functions REPLACE and LEN.) Order the result from rows with the highest occurrences to lowest.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 85 - Lab Exercise 4 - Task 4 Result.txt. 
---------------------------------------------------------------------
SELECT
	contactname,
	LEN(contactname) - LEN(REPLACE(contactname, 'a', '')) AS numberofa
FROM Sales.Customers
ORDER BY numberofa DESC;

-- task 5

SELECT
  c.contactname,
  LEN(c.contactname) - LEN(REPLACE(c.contactname, 'a', '')) AS numberofa
FROM Sales.Customers as c JOIN Sales.orders as o ON c.custid= o.custid
WHERE MONTH(o.orderdate) = 2
ORDER BY numberofa DESC;