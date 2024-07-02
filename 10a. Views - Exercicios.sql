/*1 
a. A partir da tabela DimProduct, crie uma View contendo as informa��es de ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View de vwProdutos. 
b. A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate, DepartmentName. Chame essa View de vwFuncionarios. 
c. A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e OpenDate. Chame essa View de vwLojas. 
*/
GO
CREATE VIEW vwProdutos AS
SELECT
	ProductName AS 'Produto', 
	ColorName AS 'Cor', 
	UnitPrice AS 'Pre�o',
	UnitCost AS 'Pre�o Unit'
FROM DimProduct
GO

GO
CREATE VIEW vwFuncionarios AS
SELECT
	FirstName AS 'Nome', 
	BirthDate AS 'Nasc', 
	DepartmentName AS 'Departamento'
FROM DimEmployee
GO

GO
CREATE VIEW vwLojas AS
SELECT
	StoreKey, 
	StoreName,
	OpenDate
FROM DimStore
GO

SELECT * FROM vwProdutos
SELECT * FROM DimEmployee
SELECT * FROM vwLojas

/*
2. Crie uma View contendo as informa��es de Nome Completo (FirstName + LastName), G�nero (por extenso), E-mail e Renda Anual (formatada com R$). Utilize a tabela DimCustomer. Chame essa View de vwCliente
*/
GO
CREATE VIEW vwCliente AS
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo',
	EmailAddress AS 'Email',
	FORMAT(YearlyIncome, 'C') AS 'Renda Atual'
FROM DimCustomer
GO
SELECT * FROM vwCliente

/* 3. 
a. A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Fa�a um SELECT de todas as colunas. Chame essa View de vwLojasAtivas. 
b. A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os funcion�rios da �rea de Marketing. Fa�a um SELECT das colunas: FirstName, EmailAddress e DepartmentName. Chame essa de vwFuncionariosMkt. 
c. Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e Litware. Al�m disso, a sua View deve considerar apenas os produtos de cor Silver. Fa�a um SELECT de todas as colunas da tabela DimProduct. Chame essa View de vwContosoLitwareSilver
*/
GO
CREATE VIEW vwLojasAtivas AS
SELECT * 
FROM DimStore
WHERE Status = 'On'
GO
SELECT * FROM vwLojasAtivas

GO
CREATE VIEW vwFuncionariosMkt AS
SELECT 
	FirstName AS 'Nome', 
	EmailAddress AS 'Email', 
	DepartmentName AS 'Departamento'
FROM DimEmployee
WHERE DepartmentName = 'Marketing'
GO
SELECT * FROM vwFuncionariosMkt

GO
CREATE VIEW vwContosoLitwareSilver AS
SELECT *
FROM DimProduct
WHERE BrandName IN ('Contoso', 'Litware') AND ColorName = 'Silver'
GO
SELECT * FROM vwContosoLitwareSilver


/*
4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do Produto. Chame esta View de vwTotalVendidoProdutos. 
OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas FactSales e DimProduct
*/
GO
CREATE VIEW vwTotalVendidoProdutos AS
SELECT
	ProductName AS 'Produto',
	SUM(SalesQuantity) AS 'Qnt Vendida'
FROM FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName
GO

SELECT * FROM vwTotalVendidoProdutos


/*
5. Fa�a as seguintes altera��es nas tabelas da quest�o 1. 
a. Na View criada na letra a da quest�o 1, adicione a coluna de BrandName. 
b. Na View criada na letra b da quest�o 1, fa�a um filtro e considere apenas os funcion�rios do sexo feminino. 
c. Na View criada na letra c da quest�o 1, fa�a uma altera��o e filtre apenas as lojas ativas.
*/
GO
ALTER VIEW vwProdutos AS
SELECT
	ProductName AS 'Produto', 
	ColorName AS 'Cor', 
	UnitPrice AS 'Pre�o',
	UnitCost AS 'Pre�o Unit',
	BrandName AS 'Marca'
FROM DimProduct
GO

GO
ALTER VIEW vwFuncionarios AS
SELECT
	FirstName AS 'Nome', 
	BirthDate AS 'Nasc', 
	DepartmentName AS 'Departamento'
FROM DimEmployee
WHERE Gender = 'F'
GO

GO
ALTER VIEW vwLojas AS
SELECT
	StoreKey, 
	StoreName,
	OpenDate
FROM DimStore
WHERE Status = 'On'
GO

SELECT * FROM vwProdutos
SELECT * FROM DimEmployee
SELECT * FROM vwLojas

/* 6.
a. Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O resultado esperado da consulta dever� ser o total de produtos por marca. Chame essa View de vw_6a. 
b. Altere a View criada no exerc�cio anterior, adicionando o peso total por marca. Aten��o: sua View final dever� ter ent�o 3 colunas: Nome da Marca, Total de Produtos e Peso Total. c. Exclua a View vw_6a
*/
GO
CREATE VIEW vw_6a AS
SELECT
	BrandName AS 'Marca', 
	COUNT(*) AS 'Total'
FROM DimProduct
GROUP BY BrandName
GO

GO
ALTER VIEW vw_6a AS
SELECT
	BrandName AS 'Marca', 
	COUNT(*) AS 'Total',
	SUM(Weight) AS 'Peso'
FROM DimProduct
GROUP BY BrandName
GO

SELECT * FROM vw_6a