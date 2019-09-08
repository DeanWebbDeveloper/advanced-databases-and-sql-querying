--CTE

USE AdventureWorks2017

SELECT * FROM [Sales].[SalesTerritory]

WITH CTE_SALESTERR
AS
(
	SELECT Name, CountryRegionCode FROM Sales.SalesTerritory
)

SELECT * FROM CTE_SALESTERR
WHERE Name Like 'North%';

--GROUP BY

SELECT * FROM [Sales].[SalesTerritory]

SELECT Name, NULL, NULL, SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name

UNION ALL

SELECT Name, CountryRegionCode, NULL, SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode

UNION ALL

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode, [Group]


--VERY INEFFICIENT MEANS OF GROUPING--

--USE GROUPING SETS INSTEAD--

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY GROUPING SETS
(
	(Name),
	(Name, CountryRegionCode),
	(Name, CountryRegionCode, [Group])
)


--ROLLUP

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY ROLLUP
(
	(Name, CountryRegionCode, [Group])
)


--CUBE

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM  [Sales].[SalesTerritory]
GROUP BY CUBE
(
	(Name, CountryRegionCode, [Group])
)


--8.3 RANKING FUNCTIONS--

SELECT PostalCode FROM [Person].[Address]
WHERE PostalCode IN ('98052', '98027', '98055', '97205')

SELECT PostalCode
,ROW_NUMBER() OVER (ORDER BY PostalCode) AS 'ROW NUMBER'
,RANK() OVER (ORDER BY PostalCode) AS 'RANK'
,DENSE_RANK() OVER (ORDER BY PostalCode) AS 'DENSE RANK'
,NTILE(10) OVER (ORDER BY PostalCode) AS 'NTILE'
FROM [Person].[Address]
WHERE PostalCode IN ('98052', '98027', '98055', '97205')



--XML DATATYPE

SELECT * FROM [dbo].[samplexmltable];

INSERT INTO [dbo].[samplexmltable] (xmldata) VALUES ('<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Dont forget me this weekend!</body>
</note>');

SELECT * FROM Sales.SalesTerritory
FOR XML AUTO, ELEMENTS, ROOT ('SalesTerritory');

SELECT * FROM Sales.SalesTerritory
FOR XML RAW, ELEMENTS, ROOT ('SalesTerritory');

SELECT [xmldata].query('/note/to') AS [to] FROM [dbo].[samplexmltable];

SELECT [xmldata].value('(/note/to)[1]', 'varchar(10)') AS [to] FROM [dbo].[samplexmltable];

SELECT TOP 10 TerritoryID FROM Sales.SalesTerritory
FOR XML AUTO, ELEMENTS, ROOT('SalesTerritory');

SELECT * FROM Sales.SalesTerritory
FOR XML AUTO, ELEMENTS, ROOT('SalesTerritory');

DECLARE @xmlhandle INT
DECLARE @xmldocument XML

SET @xmldocument = (SELECT * FROM Sales.SalesTerritory
FOR XML AUTO, ELEMENTS, ROOT('SalesTerritory'))

EXEC sp_xml_preparedocument @xmlhandle output , @xmldocument

SELECT * FROM openxml(@xmlhandle, '/SalesTerritory/Sales.SalesTerritory', 2)
WITH(TerritoryID INT, SalesYTD MONEY)

EXEC sp_xml_removedocument @xmlhandle

