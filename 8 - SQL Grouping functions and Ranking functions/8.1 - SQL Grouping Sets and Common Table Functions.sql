--CTE

USE AdventureWorks2017

SELECT * FROM [Sales].[SalesTerritory]

WITH CTE_SALESTERR
AS
(
	SELECT Name, CountryRegionCode FROM Sales.SalesTerritory
)

SELECT * FROM CTE_SALESTERR
WHERE Name Like 'North%';

--GROUP BY

SELECT * FROM [Sales].[SalesTerritory]

SELECT Name, NULL, NULL, SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name

UNION ALL

SELECT Name, CountryRegionCode, NULL, SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode

UNION ALL

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode, [Group]


--VERY INEFFICIENT MEANS OF GROUPING--

--USE GROUPING SETS INSTEAD--

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY GROUPING SETS
(
	(Name),
	(Name, CountryRegionCode),
	(Name, CountryRegionCode, [Group])
)


--ROLLUP

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY ROLLUP
(
	(Name, CountryRegionCode, [Group])
)


--CUBE

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY CUBE
(
	(Name, CountryRegionCode, [Group])
)
