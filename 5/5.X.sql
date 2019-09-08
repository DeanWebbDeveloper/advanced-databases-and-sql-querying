----------------------------------------------------------------------------------------
--CREATE A PROCEDURE TO RETURN NO OF EMPLOYEES AND DEPT NAME WHEN GROUPNAME IS ENTERED--
----------------------------------------------------------------------------------------

CREATE VIEW ProcEmployeeView
AS
SELECT A.[DepartmentID], A.[Name], A.[GroupName], B.[BusinessEntityID] FROM [HumanResources].[Department] A LEFT JOIN [HumanResources].[EmployeeDepartmentHistory] B
ON  A.DepartmentID = B.DepartmentID

SELECT * FROM ProcEmployeeView

DROP VIEW ProcEmployeeView

CREATE PROC ProcEmployeeCount
@DeptName VARCHAR(50) = ''
AS
SET NOCOUNT ON
SELECT @DeptName AS DeptName, COUNT(*) AS NoOfEmployees FROM ProcEmployeeView WHERE Name LIKE @DeptName

EXEC ProcEmployeeCount 'Engineering'

DROP PROC ProcEmployeeCount


-----------------------------------------
------LEARNING ABOUT WITH RECOMPILE------
-----------------------------------------

USE AdventureWorks2017;  
GO  
EXECUTE ProcEmployeeCount 'Engineering' WITH RECOMPILE;  
GO

--RECOMPILING IN SQL CAN BE FASTER THAN RUNNING THE QUERY AS IT CLEARS THE CURRENT QUERY EXECUTION PLAN AND REPLACES IT WITH THIS ONE--