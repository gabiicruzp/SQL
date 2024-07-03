-- Agrupar
SELECT
	BrandName AS 'NomeMarca',
	COUNT(*) AS 'Qnt Total'
FROM DimProduct
GROUP BY BrandName


SELECT 
	StoreType AS 'TipoLoja',
	SUM(EmployeeCount)
FROM DimStore
GROUP BY StoreType


SELECT
	BrandName,
	AVG(UnitCost) AS 'MediaCusto'
FROM DimProduct
GROUP BY BrandName


SELECT
	ClassName AS 'Classe Produto', 
	MAX(UnitPrice) AS 'Preco Max'
FROM DimProduct
GROUP BY ClassName


SELECT 
	StoreType AS 'TipoLoja',
	SUM(EmployeeCount) AS 'Soma Funcionarios'
FROM DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC


SELECT
	ColorName AS 'Cor do produto',
	COUNT(*) AS 'Total de produtos'
FROM DimProduct
WHERE BrandName = 'Contoso'
GROUP BY ColorName


-- HAVING permite filtrar APÓS o agrupamento
SELECT
	BrandName AS 'Marca', 
	COUNT(Brandname) AS 'Total por Marca'
FROM DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) >=200
ORDER BY COUNT(Brandname) DESC


SELECT
	BrandName AS 'Marca', 
	COUNT(Brandname) AS 'Total por Marca'
FROM DimProduct
WHERE ClassName = 'Economy' -- Filtra a tabela original, antes do agrupamento
GROUP BY BrandName
HAVING COUNT(BrandName) >=200 -- Filrta a tabela após o agrupamento






