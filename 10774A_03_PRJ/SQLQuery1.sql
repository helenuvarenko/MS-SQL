USE AdventureWorks2012;
GO

SELECT *
FROM Sales.Customers
GO

SELECT contactname, address, city, region, country
FROM Sales.Customers
GO

SELECT country
FROM Sales.Customers

SELECT DISTINCT city 
FROM Sales.Customers

SELECT city,region
FROM Sales.Customers

SELECT DISTINCT city,region
FROM Sales.Customers

SELECT C.contactname, C.contacttitle
FROM Sales.Customers AS C

SELECT contactname as Name, contacttitle as Title, companyname as [Company Name]
From Sales.Customers

SELECT P.productname as [Product Name]
FROM Production.Products as p


SELECT 
	city, country
FROM Sales.Customers;

select distinct productname, categoryid
from Production.Products

SELECT categoryid, productname,
CASE categoryid
WHEN 1 THEN 'Beverages'
WHEN 2 THEN 'Condiments'
WHEN 3 THEN 'Confections'
WHEN 4 THEN 'Dairy Products'
WHEN 5 THEN 'Graind\Cereals'
WHEN 6 THEN 'Meat\Poultry'
WHEN 7 THEN 'Produce'
WHEN 8 THEN 'Seafood'
ELSE 'Other'
END AS categoryname -- name of new column
FROM Production.Products

SELECT categoryid, productname,
CASE categoryid
WHEN 1 THEN 'Beverages'
WHEN 2 THEN 'Condiments'
WHEN 3 THEN 'Confections'
WHEN 4 THEN 'Dairy Products'
WHEN 5 THEN 'Graind\Cereals'
WHEN 6 THEN 'Meat\Poultry'
WHEN 7 THEN 'Produce'
WHEN 8 THEN 'Seafood'
ELSE 'Other'
END AS categoryname,
CASE 
WHEN categoryid IN (1, 7, 8) THEN 'Campaign Products'
ELSE 'Non-Campaign Products'
END AS iscampaign
FROM Production.Products