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