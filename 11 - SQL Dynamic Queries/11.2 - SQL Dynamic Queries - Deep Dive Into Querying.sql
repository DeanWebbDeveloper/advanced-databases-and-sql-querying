CREATE DATABASE PartitionDB

--Creates the partitions into 5 different buckets for every table below, each ranging for 1000 values--

USE PartitionDB

CREATE PARTITION FUNCTION cust_part_func(INT)
AS RANGE right
FOR VALUES (1000,2000,3000,4000,5000);

--	To use below, righ-click the PartitionDB database, click properties. Go to Filegroups, and add the filegroups 'fgp1-6'
--	Then go to File, Add 'fg1-6' and change each's Filegroup property to the associate filegroup ie fg1=fgp1

CREATE PARTITION scheme cust_part_scheme
AS PARTITION cust_part_func
TO (fgp1, fgp2, fgp3, fgp4, fgp5, fgp6);

CREATE TABLE partition
(EMPID INT IDENTITY (1,1) NOT NULL,
empdate DATETIME NULL
)
ON cust_part_scheme (EMPID);

DECLARE @i INT
SET @i = 0
WHILE @i<10000
BEGIN
INSERT INTO partition (empdate) VALUES (GETDATE())
SET @i = @i +1
END;

SELECT $partition.cust_part_func(EMPID) AS 'partition number', *
FROM partition;

--Can right-click table, select storage and create partition using UI version


----PIVOT----

SELECT * FROM Sales.SalesTerritory;

SELECT CountryRegionCode, [Group], SalesYTD
FROM Sales.SalesTerritory;

--CountyRegionCode	| NorthAmerica	| Europe
--US				| 23			| ..

SELECT CountryRegionCode, [North America], [Europe], [Pacific]
FROM Sales.SalesTerritory
PIVOT
(SUM(SalesYTD) FOR [Group]
IN ([North America], [Europe], [Pacific])
)
AS pvt

--Dynamic Queries

DECLARE @sqlstring varchar(2000);
SET @sqlstring = 'SELECT CountryRegionCode, [Group], ';
SET @sqlstring = @sqlstring + 'SalesYTD FROM Sales.SalesTerritory';

PRINT @sqlstring
EXEC (@sqlstring)
