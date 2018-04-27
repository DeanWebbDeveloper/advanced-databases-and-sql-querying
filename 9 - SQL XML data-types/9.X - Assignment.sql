----------------------------------------------
------1. What is XML Schema Collection? ------
----------------------------------------------

--SQL Server provides native storage of XML data.
--Can associate XML Schema definition (XSD) schema with a variable or column of xml type through XML Schema Collection
--Storing these can hen be used to:

-- - Validate XML instances
-- - Type XML data as it is stored in the database

--XML schema collection is metadata entity like a table in the database, can create, modify, drop

-- Typed XML is XML stored in a column of variable the schema is associated with. Used to optimise storage
-- uses it for type checking and to optimise queries and data modification

--SQL Server uses XML schema collection to validate XML instance in the case of typed XML
--If XML, stored, if not, rejected


------------------------------------------------------
------2. Explore the concept of FLWOR operations------
------------------------------------------------------

--XQuery defines FLWOR

--FOR		- selects a sequence of nodes
--LET		- binds a sequence to a variable
--WHERE		- filters the nodes
--ORDER BY	- sorts the nodes
--RETURN	- what to return (gets evaluated once for every node)



--doc("books.xml")/bookstore/book[price>30]/title

--above selects all title elements under the book that are under the bookstore element that have a price element > 30

--AKA

--	for $x in doc("books.xml")/bookstore/book
--	where $x/price>30
--	return $x/title


--Using FLWOR, can sort result

--for		$x in doc("books.xml)/bookstore/book		
--where		$x/price>30
--order by	$x/title
--return	$x/title

---------------------------------------------
--------------3. What is XPath?--------------
---------------------------------------------

--XPath is major element in XSLT stanard
--Used to navigate through elements and attribute in an XML doc

--Stands for XML Path Language
--Uses 'Path like' syntax to identify and navigate nodes in an XML doc
--Contains over 200 built-in functions
--W3C recommendation

-----------------------------------------------------------------------------------------------------------------------------
----4. Try to call a web service using MSXML. Note: This is a bit challenging. Bonus points if you are able to do this :)----
-----------------------------------------------------------------------------------------------------------------------------

--MSXML, legacy code - leave this for now--