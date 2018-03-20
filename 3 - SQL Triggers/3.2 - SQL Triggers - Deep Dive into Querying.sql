--======================================
--  Create T-SQL Trigger Template
--======================================
USE AdventureWorks
GO

IF OBJECT_ID ('Sales.uStore','TR') IS NOT NULL
   DROP TRIGGER Sales.uStore 
GO

CREATE TRIGGER Sales.uStore 
   ON  Sales.Store 
   AFTER UPDATE
AS UPDATE Sales.Store SET ModifiedDate = GETDATE() FROM inserted WHERE inserted.CustomerID = Sales.Store.CustomerID
GO

---------------------------------------------------
----------------------TRIGGER----------------------
---------------------------------------------------

SELECT * FROM [HumanResources].[Shift]
CREATE TRIGGER DemoTrigger
ON [HumanResources].[Shift]
AFTER INSERT
AS
BEGIN
PRINT 'Insert is not allowed! You need approval!'
ROLLBACK TRANSACTION
END

GO

--TEST TRIGGER

INSERT INTO [HumanResources].[Shift]
([Name],
[StartTime],
[EndTime],
[ModifiedDate])
VALUES
('Red',
'2018-8-7',
'2018-8-9',
'2018-8-10')

SELECT * FROM [HumanResources].[Shift]

----------------------------------------------------
---------------DATABASE LEVEL TRIGGER---------------
----------------------------------------------------

CREATE TRIGGER DemoDBLevelTrigger
ON DATABASE
AFTER CREATE_TABLE
AS
BEGIN
PRINT 'Creation of tables is not allowed!'
ROLLBACK TRANSACTION
END

GO

CREATE TABLE MyDemoTable (Name VARCHAR(10))