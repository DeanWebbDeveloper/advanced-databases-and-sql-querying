-------------------------------------
------------INDEXED VIEWS------------
-------------------------------------

USE AdventureWorks2017
GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF

IF object_id(N'dbo.MyQuizIndexView', 'V') IS NOT NULL
	DROP VIEW dbo.MyQuizIndexView
GO

CREATE VIEW dbo.MyQuizIndexView 
WITH SCHEMABINDING AS
SELECT TerritoryID, Name, CountryRegionCode FROM [Sales].[SalesTerritory] WHERE CountryRegionCode LIKE 'US'

GO
CREATE UNIQUE CLUSTERED INDEX MyQuizIndexView_IndexedView
ON dbo.MyQuizIndexView(TerritoryID)


SELECT * FROM MyQuizIndexView


--------------------------------------
--------------WITH CHECK--------------
--------------------------------------

CREATE VIEW MyViewWithCheck
AS
SELECT CustomerID, CustomerName FROM [dbo].[MyCustomer]
WHERE CustomerName LIKE '%e%'
WITH CHECK OPTION
;

SELECT * FROM MyViewWithCheck

--TEST THE CHECK - SHOULD NOT WORK AS MAKES IT SO THE VALID ENTRY 'DEAN' WOULD BE REMOVED--
UPDATE MyViewWithCheck
SET CustomerName = 'Dan'
WHERE CustomerName LIKE 'Dean'


-------------------------------------
-----------WITH ENCRYPTION-----------
-------------------------------------

CREATE VIEW MyViewWithEncryption
WITH ENCRYPTION
AS
SELECT [TerritoryID], [Name], [CountryRegionCode] FROM [Sales].[SalesTerritory]
WHERE [CountryRegionCode] LIKE 'US'

SELECT * FROM MyViewWithEncryption

--WITH ENCRYPTION MEANS IT IS USER SPECIFIC - CAN BE ACCESSED FROM THIS USER BUT IS OTHERWISE ENCRYPTED--


--------------------------------------
-----CHECK IF VIEW ALREADY EXISTS-----
--------------------------------------

USE AdventureWorks2017
GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF

--THIS BIT HERE CHECKS IF IT ALREADY EXISTS, IF WRITTEN YOURSELF INITIALLY WOULD NOT HAVE USED THIS--

IF object_id(N'dbo.MyQuizIndexView', 'V') IS NOT NULL
	DROP VIEW dbo.MyQuizIndexView
GO

-----------------------------------------------------------------------------------------------------

CREATE VIEW dbo.MyQuizIndexView 
WITH SCHEMABINDING AS
SELECT TerritoryID, Name, CountryRegionCode FROM [Sales].[SalesTerritory] WHERE CountryRegionCode LIKE 'US'

GO
CREATE UNIQUE CLUSTERED INDEX MyQuizIndexView_IndexedView
ON dbo.MyQuizIndexView(TerritoryID)


SELECT * FROM MyQuizIndexView
