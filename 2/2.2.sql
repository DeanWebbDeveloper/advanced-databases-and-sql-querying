-- =============================================
-- Create View template
-- =============================================
USE AdventureWorks
GO

IF object_id(N'dbo.Top10Sales', 'V') IS NOT NULL
	DROP VIEW dbo.Top10Sales
GO

CREATE VIEW dbo.Top10Sales AS
SELECT TOP 10 * FROM Sales.SalesOrderHeader ORDER BY TotalDue DESC

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[Sales].[SalesTerritory]

-- VIEWS (U.S. VIEW)
CREATE VIEW MYCustomUSView
AS
SELECT * FROM [Sales].[SalesTerritory]
WHERE CountryRegionCode LIKE 'US'

SELECT * FROM MYCustomUSView


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[Sales].[SalesPerson]

CREATE VIEW NASalesQuota AS
SELECT [Name], [Group], [SalesQuota], [Bonus]
FROM [Sales].[SalesTerritory] A INNER JOIN [Sales].[SalesPerson] B
ON A.TerritoryID = B.TerritoryID
WHERE [Group] LIKE 'North America'

SELECT * FROM NASalesQuota