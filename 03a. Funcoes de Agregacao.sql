-- Função SUM
SELECT TOP(100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales

-- Função COUNT
SELECT
	COUNT(*) AS 'Total de produtos'
FROM
	DimProduct

SELECT
	COUNT(ProductName) AS 'Qnt de produtos'
FROM
	DimProduct

SELECT
	COUNT(Size) AS 'Tamanho' -- Não conta valores NULL, só linhas com valores preenchidos
FROM
	DimProduct


-- Função COUNT e DISTINCT
SELECT
	COUNT(DISTINCT ColorName) AS 'Qnt de Cores'
FROM 
	DimProduct


-- Funções MAX e MIN
SELECT
	MAX(UnitPrice) AS 'Custo Max',
	MIN(UnitPrice) AS 'Custo Min'
FROM
	DimProduct

-- Função AVARAGE
SELECT
	AVG(YearlyIncome) AS 'Média Anual Salário'
FROM
	DimCustomer









