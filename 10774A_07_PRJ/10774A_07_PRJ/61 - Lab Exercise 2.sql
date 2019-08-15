---------------------------------------------------------------------
-- LAB 07
--
-- Exercise 2
---------------------------------------------------------------------

USE AdventureWorks2012;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Open the project file F:\10774A_Labs\10774A_07_PRJ\10774A_07_PRJ.ssmssln and the T-SQL script 61 - Lab Exercise 2.sql. Ensure that you are connected to the TSQL2012 database.
--
-- Write a SELECT statement to retrieve distinct values for the custid column from the Sales.Orders table. Filter the results to include only orders placed in February 2008.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
---------------------------------------------------------------------
select distinct custid 
from Sales.Orders
where month(orderdate) = 2 and year(orderdate) = 2008

---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement with these columns:
--  Current date and time
--  First date of the current month
--  Last date of the current month
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt.
---------------------------------------------------------------------
select 
CURRENT_TIMESTAMP as currentdatetime,
CAST(DATEADD(day, -day(current_timestamp)+1, CURRENT_TIMESTAMP) as date) as firstmonthday,
EOMONTH(CURRENT_TIMESTAMP) as lastmonthday; 


---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement against the Sales.Orders table and retrieve the orderid, custid, and orderdate columns. Filter the results to include only orders placed in the last five days of the order month.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
---------------------------------------------------------------------
select orderid, custid, orderdate
from Sales.Orders
where DATEDIFF(day, orderdate, EOMONTH(orderdate)) <5; 



---------------------------------------------------------------------
-- Task 4
-- 
-- Write a SELECT statement against the Sales.Orders and Sales.OrderDetails tables and retrieve all the distinct values for the productid column. Filter the results to include only orders placed in the first 10 weeks of the year 2007.
--
-- Execute the written statement and compare the results that you got with the recommended result shown in the file 65 - Lab Exercise 2 - Task 4 Result.txt.
---------------------------------------------------------------------
select distinct od.productid
from Sales.OrderDetails as od 
join Sales.Orders as o on od.orderid = o.orderid
where DATEPART(week, orderdate) <= 10 and YEAR(orderdate) = 2007; 