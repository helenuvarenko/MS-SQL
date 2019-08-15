﻿---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 1
---------------------------------------------------------------------

USE AdventureWorks2012;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Open the project file F:\10774A_Labs\10774A_12_PRJ\10774A_12_PRJ.ssmssln and the T-SQL script 51 - Lab Exercise 1.sql. To set your database context to that of the TSQL2012 database, highlight the statement USE TSQL2012; and execute the highlighted code. After executing this statement, the TSQL2012 database should be selected in the Available Databases box. In subsequent exercises, you will simply be instructed to ensure that you are connected to the TSQL2012 database.
--
-- Write a SELECT statement to return the productid and productname columns from the Production.Products table. Filter the results to include only products that have a categoryid value 4.

-- Execute the written statement and compare the results that you got with the desired results shown in the file 52 - Lab Exercise 1 - Task 1 Result.txt. Remember the number of rows in the result.

---------------------------------------------------------------------
Select productid, productname
From Production.Products
Where categoryid = '4';


---------------------------------------------------------------------
-- Task 2
-- 
-- Write a SELECT statement to return the productid and productname columns from the Production.Products table. Filter the results to include only products that have a total sales amount of more than $50,000. For the total sales amount, you will need to query the Sales.OrderDetails table and aggregate all order line values (qty * unitprice) for each product.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 53 - Lab Exercise 1 - Task 2 Result.txt. Remember the number of rows in the result.
---------------------------------------------------------------------
Select od.productid, p.productname
From Production.Products As p
Inner Join Sales.OrderDetails As od On p.productid=od.productid
Group By od.productid, p.productname
Having Sum(od.qty*od.unitprice) > 5000; 


---------------------------------------------------------------------
-- Task 3
-- 
-- Write a SELECT statement that uses the UNION operator to retrieve the productid and productname columns from the T-SQL statements in task 1 and task 2.
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 54 - Lab Exercise 1 - Task 3_1 Result.txt. 
--
-- What is the total number of rows in the result? If you compare this number with an aggregate value of the number of rows from task 1 and task 2 is there any difference? 
--
-- Copy the T-SQL statement and modify it to use the UNION ALL operator. 
--
-- Execute the written statement and compare the results that you got with the desired results shown in the file 55 - Lab Exercise 1 - Task 3_2 Result.txt. 
--
-- What is the total number of rows in the result? What is the difference between the UNION and UNION ALL operators?
---------------------------------------------------------------------
Select productid, productname
From Production.Products
Where categoryid = 4

Union

Select od.productid, p.productname
From Sales.OrderDetails As od
Inner Join Production.Products As p On p.productid=od.productid
Group By od.productid, p.productname
Having Sum(od.qty*od.unitprice) > 5000; 

Select productid, productname
From Production.Products
Where categoryid = 4

Union All

Select od.productid, p.productname
From Sales.OrderDetails As od
Inner Join Production.Products As p On p.productid=od.productid
Group By od.productid, p.productname
Having Sum(od.qty * od.unitprice) > 5000; 

---------------------------------------------------------------------
-- Task 4
-- 
-- Write a SELECT statement to retrieve the custid and contactname columns from the Sales.Customers table. Display the top 10 customers by sales amount for January 2008 and display the top 10 customers by sales amount for February 2008 (Hint: Write two SELECT statements each joining Sales.Customers and ​Sales.OrderValues and use the appropriate set operator.)
--
-- Execute the T-SQL code and compare the results that you got with the desired results shown in the file 56 - Lab Exercise 1 - Task 4 Result.txt. 
---------------------------------------------------------------------
Select c1.custid, c1.contactname
From
(
	Select Top(10) o.custid, c.contactname
	From Sales.OrderValues As o
	Inner Join Sales.Customers As c On o.custid=c.custid
	Where o.orderdate >= '20080101' And o.orderdate < '20080201'
	Group By o.custid, c.contactname
	Order By Sum(o.val) Desc
) As c1

Union

Select c2.custid, c2.contactname
From
(
	Select Top(10) o.custid, c.contactname
	From Sales.OrderValues As o
	Inner Join Sales.Customers As c On o.custid=c.custid
	Where o.orderdate >= '20080201' And o.orderdate < '20080301'
	Group By o.custid, c.contactname
	Order By Sum(o.val) Desc
) As c2;
