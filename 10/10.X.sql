----------------------------------------------------------------------------------------------------------------------------------------------
--1. Split [AdventureWorks2012].[Production].[TransactionHistory] into 2 paritions – one for year 2013 entries and other for 2014 and above.--
----------------------------------------------------------------------------------------------------------------------------------------------

USE AdventureWorks2017

SELECT TransactionID, TransactionDate FROM Production.TransactionHistory WHERE TransactionDate LIKE '%2013%';

CREATE PARTITION FUNCTION cust_part_func(DATETIME)
AS RANGE RIGHT
FOR VALUES ('20130101', '20140101');

CREATE PARTITION scheme cust_part_scheme
AS PARTITION cust_part_func
TO (awfgp1, awfgp2, awfgp3)

SELECT $partition.cust_part_func(TransactionDate) AS 'partition number', * FROM Production.TransactionHistory WHERE TransactionDate LIKE '%2014%';