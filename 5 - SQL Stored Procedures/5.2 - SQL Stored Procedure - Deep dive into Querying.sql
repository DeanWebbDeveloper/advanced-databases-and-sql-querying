-------------------------------------------
-------------STORED PROCEDURES-------------
-------------------------------------------

USE [AdventureWorks2017]

CREATE PROCEDURE MyTestProc
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]

EXECUTE MyTestProc

CREATE PROCEDURE MyTestProc2
AS
SET NOCOUNT OFF
SELECT * FROM [HumanResources].[Shift]

EXECUTE MyTestProc2

DROP PROC MyTestProc
DROP PROC MyTestProc2

CREATE PROCEDURE MyFirstParamProc
@ParamName VARCHAR(50)
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
WHERE Name = @ParamName

EXEC MyFirstParamProc @ParamName = 'Day'
EXEC MyFirstParamProc 'Day'
EXEC MyFirstParamProc

DROP PROC MyFirstParamProc

CREATE PROCEDURE MyFirstParamProc
@ParamName VARCHAR(50) = 'Evening'
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
WHERE Name =@ParamName

EXEC MyFirstParamProc 'Day'

--OUTPUT PARAMETERS
CREATE PROC MyOutputSP
@TopShift VARCHAR(50) OUTPUT
AS
SET @TopShift = (SELECT TOP (1) ShiftID FROM [HumanResources].[Shift])

DECLARE @OutputResult VARCHAR(50)
EXEC MyOutputSP @OutputResult OUTPUT
SELECT @OutputResult

--RETURNING VALUES FROM STROED PROCEDURES
CREATE PROC MyFirstReturningSP
AS
RETURN 12

DECLARE @ReturnValue INT
EXEC @ReturnValue = MyFirstReturningSP
SELECT @ReturnValue