------------------------------------------------------------------------------------------------------------------------
--1. Using the  [HumanResources].[EmployeePayHistory], Employee and Person.Person, find the 6th highest annual salary --
------------------------------------------------------------------------------------------------------------------------

USE AdventureWorks2017

SELECT		FirstName, LastName
FROM
(
SELECT		B.*
			,A.Rate * A.PayFrequency
AS			'TotalPay'
			,RANK() OVER (ORDER BY (Rate * PayFrequency) DESC)
AS			'Rank'
FROM		[HumanResources].[EmployeePayHistory] A LEFT JOIN [Person].[Person] B
ON			A.BusinessEntityID = B.BusinessEntityID
) AS		innerTable
WHERE		Rank = 6


-------------------------------------------------
----------DIFFERENCE RANK AND DENSE_RANK---------
-------------------------------------------------

--RANK lists overall position in table as in may skip over values if more than one (ie 1,1,1,4),--
--whereas DENSE_RANK will ALWAYS go 1,1,1,2--