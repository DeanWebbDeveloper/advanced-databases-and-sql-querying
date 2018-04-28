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