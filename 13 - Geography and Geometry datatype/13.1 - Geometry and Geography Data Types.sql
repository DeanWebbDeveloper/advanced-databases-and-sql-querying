CREATE DATABASE SpatialDB;

CREATE TABLE Spatial
(ID INT PRIMARY KEY NOT NULL,
SpatialData GEOMETRY);

USE SpatialDB;

SELECT TOP (1000) [ID]
	,	[SpatialData]
	,	[SpatialData].ToString() AS 'SpatialData'		--Plain text
	,	[SpatialData].AsGml() AS 'Spatial text'			--XML format

INSERT
INTO	[Spatial]
(		[SpatialData])
VALUES	('Point(7 12)')									--When geometry used, a third tab is created with 'Results' and 'Messages' called 'Spatial Results'. This shows a graph.
,		('Linestring(0 0, 7 8)')						--Line
,		('Polygon((0 0, 8 5, 9 6, 10 0, 0 0))');		--Polygon
