---------------------------------------------------
---------------6.2 QUERIES - START-----------------
---------------------------------------------------

------------------------------------------
----------USER DEFINED FUNCTIONS----------
------------------------------------------

SELECT * FROM [Sales].[SalesTerritory]

CREATE FUNCTION YTDSALES()
RETURNS MONEY
AS
BEGIN
DECLARE @YTDSALES MONEY
SELECT @YTDSALES = SUM(SALESYTD) FROM [Sales].[SalesTerritory]
RETURN @YTDSALES
END

DECLARE @YTDRESULTS AS MONEY
SELECT @YTDRESULTS = dbo.YTDSALES()
PRINT @YTDRESULTS

DROP FUNCTION YTDSALES

-------------------------------------------
----------PARAMATERIZED FUNCTIONS----------
-------------------------------------------

SELECT * FROM [Sales].[SalesTerritory]

CREATE FUNCTION YTD_GROUP
(@GROUP VARCHAR(50))

RETURNS MONEY
AS
BEGIN
DECLARE @YTDSALES AS MONEY
SELECT @YTDSALES =SUM(SalesYTD) FROM [Sales].[SalesTerritory]
WHERE [Group] = @GROUP
RETURN @YTDSALES
END

DECLARE @RESULTS MONEY
SELECT @RESULTS = dbo.YTD_GROUP('Europe')
PRINT @RESULTS

DROP FUNCTION YTD_GROUP

------------------------------------------
--------FUCNTIONS RETURNING TABLES--------
------------------------------------------

CREATE FUNCTION ST_TABVALUED
(@TerritoryID INT)

RETURNS TABLE
AS
RETURN
SELECT Name, CountryRegionCode, [Group], SalesYTD
FROM Sales.SalesTerritory
WHERE TerritoryID = @TerritoryID

SELECT Name, CountryRegionCode FROM dbo.ST_TABVALUED(7)


---------------------------------------------------
----------------6.2 QUERIES - END------------------
---------------------------------------------------


--TRANSACTIONS


USE AdventureWorks2017

SELECT * FROM [Sales].[SalesTerritory]

BEGIN TRANSACTION
	UPDATE [Sales].[SalesTerritory]
	SET CostYTD = 1.00
	WHERE TerritoryID = 1
COMMIT TRANSACTION


--@@error 0 = success, > 0 means error


DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
	INSERT INTO [Sales].[SalesTerritory]
           ([Name] 
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'US'
           ,'NA'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-12DE20267FF7'
           ,GETDATE())


	SET @ERRORRESULTS = @@ERROR

	IF (@ERRORRESULTS = 0)
		BEGIN
			PRINT 'SUCCESS!!!'
			COMMIT TRANSACTION
		END

	ELSE
		BEGIN
			PRINT 'STATEMENT FAILED!!!!'
			ROLLBACK TRANSACTION
		END


--CUSTOM ERROR MESSAGE


DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
	INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'US'
           ,'NA'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-12DE20267FF7'
           ,GETDATE())


	SET @ERRORRESULTS = @@ERROR

	IF (@ERRORRESULTS = 0)
		BEGIN
			PRINT 'SUCCESS!!!'
			COMMIT TRANSACTION
		END

	ELSE
		BEGIN
			RAISERROR('STATEMENT FAILED - THIS IS MY CUSTOM MESSAGE', 16, 1)
			ROLLBACK TRANSACTION
		END


-- TRY AND CATCH


BEGIN TRY

BEGIN TRANSACTION
DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
	INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'US'
           ,'NA'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-12DE20267FF7'
           ,GETDATE())

	COMMIT TRANSACTION

END TRY

BEGIN CATCH
	PRINT 'CATCH STATEMENT ENTERED'
	ROLLBACK TRANSACTION
END CATCH