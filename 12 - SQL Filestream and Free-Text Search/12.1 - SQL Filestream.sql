CREATE DATABASE FilestreamDB;

USE FilestreamDB;

CREATE TABLE Files
(DocID UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL UNIQUE DEFAULT NEWID(),
Doc VARBINARY(MAX) FILESTREAM NULL
);

DECLARE @DOC AS VARBINARY(MAX);
SELECT @DOC = CAST(BULKCOLUMN AS VARBINARY(MAX))
FROM OPENROWSET 
(BULK 
'D:\Web Development\Courses\Udemy\advanced-databases-and-sql-querying\12 - SQL Filestream and Free-Text Search\Filestream\TEST.txt', SINGLE_BLOB) AS DOC

INSERT INTO Files (DOC)
VALUES(@DOC);

SELECT DOC FROM Files;
SELECT DOC.PathName() FROM Files;