-- 03. Comprobación de tablas y contenido de la vista (conectado a ProductCatalog)

SELECT name FROM sys.tables;
SELECT COUNT(*) AS Productos FROM dbo.Products;
GO

SELECT * FROM dbo.ProductCatalogView;
GO
