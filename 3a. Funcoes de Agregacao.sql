-- Fun��o SUM
SELECT TOP(100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales

-- Fun��o COUNT
SELECT
	COUNT(*) AS 'Total de produtos'
FROM
	DimProduct

SELECT
	COUNT(ProductName) AS 'Qnt de produtos'
FROM
	DimProduct

SELECT
	COUNT(Size) AS 'Tamanho' -- N�o conta valores NULL, s� linhas com valores preenchidos
FROM
	DimProduct


-- Fun��o COUNT e DISTINCT
SELECT
	COUNT(DISTINCT ColorName) AS 'Qnt de Cores'
FROM 
	DimProduct


-- Fun��es MAX e MIN
SELECT
	MAX(UnitPrice) AS 'Custo Max',
	MIN(UnitPrice) AS 'Custo Min'
FROM
	DimProduct

-- Fun��o AVARAGE
SELECT
	AVG(YearlyIncome) AS 'M�dia Anual Sal�rio'
FROM
	DimCustomer









