---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL2012;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Open the project file F:\10774A_Labs\10774A_11_PRJ\10774A_11_PRJ.ssmssln and the T-SQL script 71 - Lab Exercise 3.sql. Ensure that you are connected to the TSQL2012 database.
--
-- Write a SELECT statement like that in exercise 2, task 1, but use a CTE instead of a derived table. Use inline column aliasing in the CTE query and name the CTE ProductBeverages.
--
-- Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 - Task 1 Result.txt. 
---------------------------------------------------------------------

WITH ProductsBeverages AS
(
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100. THEN N'high' ELSE N'normal' END AS pricetype
	FROM Production.Products
	WHERE categoryid = 1
)
SELECT
	productid, productname
FROM ProductsBeverages
WHERE pricetype = N'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement against Sales.OrderValues to retrieve each customerís ID and total sales amount for the year 2008. Define a CTE named c2008 based on this query using the external aliasing form to name the CTE columns custid and salesamt2008. Join the Sales.Customers table and the c2008 CTE, returning the custid and contactname columns from the Sales.Customers table and the salesamt2008 column from the c2008 CTE.
--
-- Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 - Task 2 Result.txt. 
---------------------------------------------------------------------

With c2008(custid, salesamt2008) As
(
	Select custid, Sum(val)
	From Sales.OrderValues
	Where Year(orderdate)='2008'
	Group By custid
)
Select c.custid, c.contactname, c2008.salesamt2008
From Sales.Customers As c
Left Outer Join c2008 On c.custid=c2008.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. Also retrieve the following calculated columns:
--  salesamt2008, representing the total sales amount for the year 2008
--  salesamt2007, representing the total sales amount for the year 2007 
--  percentgrowth, representing the percentage of sales growth between the year 2007 and 2008 
-- If percentgrowth is NULL, then display the value 0.
--
-- You can use the CTE from the previous task and add another CTE for the year 2007. Then join both of them with the Sales.Customers table. Order the result by the percentgrowth column.
--
-- Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 - Task 3 Result.txt.
---------------------------------------------------------------------

With c2008(custid, salesamt2008) As
(
	Select custid, Sum(val)
	From Sales.OrderValues
	Where Year(orderdate)='2008'
	Group By custid
)
,
c2007(custid, salesamt2007) As
(
	Select custid, Sum(val)
	From Sales.OrderValues
	Where Year(orderdate)='2007'
	Group By custid
)
Select c.custid, c.contactname, c2008.salesamt2008, c2007.salesamt2007, Coalesce((c2008.salesamt2008 - c2007.salesamt2007)/ c2007.salesamt2007 * 100.,0) As percentgrowth
From Sales.Customers As c
Left Outer Join c2008 On c2008.custid=c.custid
Left Outer Join c2007 On c2007.custid=c.custid
Order By percentgrowth Desc;