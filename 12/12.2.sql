------------------------------------------------------
-----------------SQL Free-Text Search-----------------
------------------------------------------------------

--SSMS17, having issues with free-text index (error 7644)

--To use full-text search:

--Go to DB you want to use
--Go to Storage
--Go to Full Text Catalog
--Right-click, Create New Full-Text Catalog		(eg demo_catalog)

--Select table wanting to use					(eg Production.Product.Description)
--Right-Click, Full-Text Index
--Defin Full-Text Index
--Click through, set the Catalog as one created	(eg demo_catalog)
--Right-click again
--Full-Text Index, Start Full Population

USE AdventureWorks2017

SELECT * FROM [Production].[ProductDescription]
--WHERE FREETEXT(*, 'strong and sturdy');
--WHERE CONTAINS(*, 'strong');
--WHERE CONTAINS(*, 'strong' OR 'sturdy');
--WHERE CONTAINS(*, 'strong NEAR durability');
WHERE CONTAINS(*, 'FORMSOF(INFLECTIONAL, strong)');