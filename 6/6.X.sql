-------------------------------------
----------TEMP TABLE IN UDF----------
-------------------------------------

USE AdventureWorks2017

SELECT * FROM [Sales].[SalesTerritory]

CREATE FUNCTION TempTabFunc()

RETURNS TABLE
AS
RETURN
SELECT Name, CountryRegionCode, [Group], SalesYTD INTO #TempTable1 FROM [Sales].[SalesTerritory]

--You cannot run a temp table through a function, but you can use a table variable--

--------------------------------------
----------STORED PROC IN UDF----------
--------------------------------------

CREATE PROCEDURE StProcForFunc
AS
SET NOCOUNT ON
SELECT Name, SalesYTD FROM [Sales].[SalesTerritory]

DROP PROCEDURE StProcForFunc

CREATE FUNCTION StProcFunc()
RETURNS MONEY
AS
BEGIN
DECLARE @SalesYTD MONEY
SELECT @SalesYTD = SUM(SalesYTD) FROM StProcForFunc
RETURN @SalesYTD
END

DECLARE @StProcFuncSol AS MONEY
SELECT @StProcFuncSol = dbo.StProcFunc()
PRINT @StProcFuncSol

--Cannot put stored proc in a UDF--

--------------------------------------
--------CREATE FOLLOWING TABLE--------
--------------------------------------

USE [AdventureWorks2017] 
GO 
/****** Object:  Table [dbo].[Circle]    Script Date: 8/17/2015 6:24:00 PM ******/ 
SET ANSI_NULLS ON 
GO 
SET QUOTED_IDENTIFIER ON 
GO 
CREATE TABLE [dbo].[Circle]( 
[CircleID] [int] NULL, 
[Radius] [float] NULL, 
[Area] [float] NULL 
) ON [PRIMARY] 
 
 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (1, 3, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (2, 5, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (3, 3.2, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (4, 5.76, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (5, 3.22, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (6, 4, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (7, 3.66, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (8, 9.22332, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (9, 12, NULL) 
GO 
INSERT [dbo].[Circle] ([CircleID], [Radius], [Area]) VALUES (10, 10, NULL) 
GO 

SELECT * FROM Circle

--------------------------------------
----CALC AREA FOR CIRCLES IN TABLE----
--------------------------------------

CREATE FUNCTION CircArea
(@CircleID INT)

RETURNS NUMERIC(10,5)
AS
BEGIN
DECLARE @CircRad AS NUMERIC(10,5)
SELECT @CircRad = Radius FROM [dbo].[circle]
WHERE CircleID = @CircleID
RETURN @CircRad
END

DROP FUNCTION CircArea

DECLARE @Radius Numeric(10,5)
SELECT @Radius = [dbo].[CircArea](10)
UPDATE [dbo].[circle]
SET
Area = @Radius * @Radius * 3.14
WHERE Radius = @Radius
SELECT * FROM Circle

--WORKS, BUT SEE IF CAN CHANGE FUNCTION TO OUTPUT THE AREA--