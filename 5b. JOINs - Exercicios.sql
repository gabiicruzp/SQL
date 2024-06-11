--1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct. 
SELECT TOP(3) * FROM DimProduct
SELECT TOP(3) * FROM DimProductSubcategory

SELECT
	DimProduct.ProductName AS 'Nome do Produto',
	DimProduct.ProductKey AS 'ID Produto',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria'
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey


--2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN. 
SELECT TOP(3) * FROM DimProductSubcategory
SELECT TOP(3) * FROM DimProductCategory

SELECT
	DimProductSubcategory.ProductSubcategoryKey AS 'ID Subcategoria',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	DimProductCategory.ProductCategoryKey AS 'Categoria'
FROM DimProductSubcategory 
LEFT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


-- 3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT JOIN neste exercício
SELECT TOP(3) * FROM DimStore
SELECT TOP(3) * FROM DimGeography

/*
PARA CHECAR NOME DE COLUNAS EM COMUM 
SELECT
    c1.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS c1
JOIN
    INFORMATION_SCHEMA.COLUMNS c2
ON
    c1.COLUMN_NAME = c2.COLUMN_NAME
WHERE
    c1.TABLE_NAME = 'DimStore' AND c2.TABLE_NAME = 'DimGeography'
    AND c1.TABLE_SCHEMA = 'dbo' AND c2.TABLE_SCHEMA = 'dbo';
*/

SELECT
	DimStore.StoreKey AS 'ID Loja',
	DimStore.StoreName AS 'Loja',
	DimStore.EmployeeCount AS 'Qnt. Funcionarios',
	DimGeography.ContinentName AS 'Continente', 
	DimGeography.RegionCountryName AS 'Pais'
FROM DimStore
LEFT JOIN DimGeography
	ON DimStore.GeographyKey = DimGeography.GeographyKey

-- 4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes. 
SELECT TOP(3) * FROM DimProduct
SELECT TOP(3) * FROM DimProductCategory
SELECT TOP(3) * FROM DimProductSubcategory
/*
-- PARA CHECAR NOME DE COLUNAS EM COMUM 
SELECT
    c1.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS c1
JOIN
    INFORMATION_SCHEMA.COLUMNS c2
ON
    c1.COLUMN_NAME = c2.COLUMN_NAME
WHERE
    c1.TABLE_NAME = 'DimProduct' AND c2.TABLE_NAME = 'DimProductSubcategory'
    AND c1.TABLE_SCHEMA = 'dbo' AND c2.TABLE_SCHEMA = 'dbo';
 -- Coluna útil em comum entre DimProductCategory e DimProductSubcategory: ProductCategoryKey
 -- Coluna útil em comum entre DimProduct e DimProductSubcategory: ProductSubcategoryKey
*/

SELECT
	DimProduct.ProductName AS 'Produto',
	DimProduct.BrandName AS 'Marca',
	DimProduct.ColorName AS 'Cor',
	DimProductCategory.ProductCategoryDescription AS 'Descrição',
	DimProductSubcategory.ProductSubcategoryKey AS 'ID Subcategoria'
FROM
	DimProduct
LEFT JOIN DimProductSubcategory 
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		LEFT JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


-- 5. A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha representa um montante destinado a uma determinada AccountKey. 
--a. Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela. 
SELECT TOP(100) * FROM FactStrategyPlan
--b. Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: • StrategyPlanKey • DateKey • AccountName • Amount
SELECT TOP(5) * FROM DimAccount

SELECT 
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.Datekey,
	FactStrategyPlan.Amount,
	DimAccount.AccountName
FROM 
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey

-- 6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão. Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: • StrategyPlanKey • DateKey • ScenarioName • Amount 
SELECT TOP(3) * FROM FactStrategyPlan
SELECT TOP(3) * FROM DimScenario

SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.DateKey,
	FactStrategyPlan.Amount,
	DimScenario.ScenarioName
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey


-- 7. Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas
SELECT TOP(100) * FROM DimProductSubcategory
SELECT TOP(100) * FROM DimProduct

SELECT
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE ProductName IS NULL

-- 8. Há uma tabela que mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado.
SELECT TOP(3) * FROM DimProduct
SELECT TOP(3) * FROM DimChannel

SELECT
	DISTINCT.DimProduct.BrandName AS 'Marca',
	DimChannel.ChannelName AS 'Canal de Venda'
FROM 
	DimProduct
CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso', 'Fabrikam', 'Litware')


-- 9. Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse relacionamento. Retorne uma tabela contendo as seguintes colunas: • OnlineSalesKey • DateKey • PromotionName • SalesAmount A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’). Além disso, você deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente.
SELECT TOP(3) * FROM FactOnlineSales
SELECT TOP(3) * FROM DimPromotion

/*
-- PARA CHECAR NOME DE COLUNAS EM COMUM 
SELECT
    c1.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS c1
JOIN
    INFORMATION_SCHEMA.COLUMNS c2
ON
    c1.COLUMN_NAME = c2.COLUMN_NAME
WHERE
    c1.TABLE_NAME = 'FactOnlineSales' AND c2.TABLE_NAME = 'DimPromotion'
    AND c1.TABLE_SCHEMA = 'dbo' AND c2.TABLE_SCHEMA = 'dbo';
 -- Coluna útil em comum entre FactOnlineSales e DimPromotion: PromotionKey
 */ 

SELECT TOP(1000)
	FactOnlineSales.OnlineSalesKey,
	FactOnlineSales.DateKey,
	FactOnlineSales.SalesAmount, 
	DimPromotion.PromotionName
FROM FactOnlineSales
INNER JOIN DimPromotion
	ON FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE PromotionName <> 'No Discount'
ORDER BY DateKey ASC


-- 10. Há uma tabela no qual o resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct. Recrie esta consulta e classifique em ordem crescente de acordo com SalesAmount
SELECT TOP(3) * FROM FactSales
SELECT TOP(3) * FROM DimChannel
SELECT TOP(3) * FROM DimStore
SELECT TOP(3) * FROM DimProduct

SELECT TOP (100)
	FactSales.SalesKey,
	DimChannel.ChannelName,
	DimStore.StoreName,
	DimProduct.ProductName,
	FactSales.SalesAmount
FROM FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
		INNER JOIN DimStore
			ON FactSales.StoreKey = DimStore.StoreKey
				INNER JOIN DimProduct
					ON FactSales.ProductKey = DimProduct.ProductKey
ORDER BY SalesAmount DESC


-- PARA CHECAR NOME DE COLUNAS EM COMUM 
SELECT
    c1.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS c1
JOIN
    INFORMATION_SCHEMA.COLUMNS c2
ON
    c1.COLUMN_NAME = c2.COLUMN_NAME
WHERE
    c1.TABLE_NAME = 'FactSales' AND c2.TABLE_NAME = 'DimProduct'
    AND c1.TABLE_SCHEMA = 'dbo' AND c2.TABLE_SCHEMA = 'dbo';

-- FactSales x DimChannel: channelKey
-- FactSales x DimStore: StoreKey
-- FactSales x DimProduct: ProductKey

