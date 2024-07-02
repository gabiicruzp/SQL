-- VIEWS

-- CREATE VIEW
/*Ao colocar 'GO' antes e depois de criar o GO ele corrige o erro de 'sintaxe incorreta' que aparece*/
-- 1. Crie uma view contando as info de FirstName, EmailAddress e BirthDate da tabela DimCustomer.
GO
CREATE VIEW vwCliente AS
SELECT 
	FirstName AS 'Nome',
	EmailAddress AS 'Email',
	BirthDate AS 'Data Nasc'
FROM DimCustomer
GO

SELECT * FROM vwCliente

--2. Crie uma view contendo as info de ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice
GO
CREATE VIEW vwProdutos AS
SELECT 
	ProductKey AS 'ID',
	ProductName AS 'Produto',
	ProductSubcategoryKey AS 'ID Subcategoria',
	BrandName AS 'Marca',
	UnitPrice AS 'Preço'
FROM DimProduct
GO

SELECT * FROM vwProdutos


-- USE: Alterar entre tabelas de bancos de dados diferentes
USE ContosoRetailDW
SELECT * FROM DimProduct

USE OutraTabela
SELECT * FROM Tabela


-- ALTER VIEW:
--3. Altere a view criada no exemplo 1 e incluir apenas clientes do sexo F
SELECT * FROM vwCliente
GO
ALTER VIEW vwCliente AS
SELECT 
	FirstName AS 'Nome',
	EmailAddress AS 'Email',
	BirthDate AS 'Nasc',
	Gender AS 'Sexo'
FROM DimCustomer
WHERE Gender = 'F'
GO


-- DROP VIEW: excluir a view
DROP VIEW vwCliente --Tem que atualizar no banco de dados 