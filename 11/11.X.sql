----------------------------------------------------------------------------------------------------
------1. Write the same SQL as shown in the Pivot video.  But do not hardcode the column names------
----------------------------------------------------------------------------------------------------

SELECT	[CountryRegionCode]
,		[Group]
,		[SalesYTD]
FROM	[Sales].[SalesTerritory];

SELECT	[CountryRegionCode]
,		[North America]
,		[Europe]
,		[Pacific]
FROM	[Sales].[SalesTerritory]
PIVOT
(SUM	(SalesYTD)
FOR		[Group]
IN		([North America]
,		[Europe]
,		[Pacific])
)
AS		pvt;

DECLARE @sqlstring varchar(2000);
SELECT @sqlstring = COALESCE(@sqlstring+'], [', '[') + [Group] FROM (SELECT DISTINCT [Group] FROM [Sales].[SalesTerritory]) d;


PRINT @sqlstring;

DECLARE @sqlstring1 varchar(2000);

SET @sqlstring1 =	'SELECT [CountryRegionCode], '
+					@sqlstring
+					'] FROM [Sales].[SalesTerritory] PIVOT (SUM (SalesYTD) FOR [Group] IN ('
+					@sqlstring
+					'])) AS pvt;';

PRINT @sqlstring1;
EXEC (@sqlstring1);
