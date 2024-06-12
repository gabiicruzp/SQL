-- GROUP BY + JOIN
SELECT TOP(3) * FROM DimDate
SELECT TOP(3) * FROM FactSales

-- Crie um agrupamento mostrando o total de vendas (Sales Quantity) por ano (CalendarYear).
SELECT
	SUM(SalesQuantity) AS 'Total Vendido', 
	DimDate.CalendarYear AS 'Ano'
FROM FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarYear

-- Considere apenas o m�s (CalendarMonthLabel) de 'January'
SELECT
	SUM(SalesQuantity) 'Total Vendido', 
	DimDate.CalendarYear AS 'Ano'
FROM FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
WHERE CalendarMonthLabel = 'January'
GROUP BY CalendarYear

-- Na tabela resultante, mostre apenas os anos com um total de vendas maior ou igual a de 1200000
SELECT
	SUM(SalesQuantity) 'Total Vendido', 
	DimDate.CalendarYear AS 'Ano'
FROM FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
WHERE CalendarMonthLabel = 'January' 
GROUP BY CalendarYear
HAVING SUM(SalesQuantity)  >= 1200000


-- 1a. Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente. 
SELECT TOP(3) * FROM DimChannel
SELECT TOP(3) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	DimChannel.ChannelName AS 'Canal de Venda'
FROM FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY ChannelName
ORDER BY SUM(SalesQuantity) DESC

-- b. Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
SELECT TOP(3) * FROM DimStore
SELECT TOP(3) * FROM FactSales

SELECT
	DimStore.StoreName AS 'Loja',
	SUM(SalesQuantity) AS 'Qnt. Vendida',
	SUM(ReturnQuantity) AS 'Qnt. Devolvida'
FROM FactSales
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY StoreName
ORDER BY StoreName


-- c. Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s (CalendarMonthLabel) e ano (CalendarYear). 
SELECT TOP(3) * FROM DimDate

SELECT
	DimDate.CalendarYear AS 'Ano',
	DimDate.CalendarMonthLabel AS 'M�s',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth
ORDER BY CalendarMonth ASC


-- 2 Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) por produto. 
SELECT TOP(3) * FROM FactSales
SELECT TOP(3) * FROM DimProduct

SELECT
	SUM(SalesAmount) AS 'Valor Total Vendido',
	DimProduct.ProductName AS 'Produto'
FROM FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName

-- a. Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity). 
SELECT
	SUM(SalesQuantity) AS 'Qnt. Vendido',
	DimProduct.ColorName AS 'Cor'
FROM FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
ORDER BY SUM(SalesQuantity) DESC

-- b. Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
SELECT
	SUM(SalesQuantity) AS 'Qnt. Vendido',
	DimProduct.ColorName AS 'Cor'
FROM FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) >= 3000000
ORDER BY SUM(SalesQuantity) DESC



-- 3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o entre FactSales e DimProductCategory n�o � direta. 
SELECT TOP(3) * FROM FactSales
SELECT TOP(3) * FROM DimProduct
SELECT TOP(3) * FROM DimProductSubcategory
SELECT TOP(3) * FROM DimProductCategory

SELECT
	SUM(SalesQuantity) AS 'Qnt. Vendida',
	DimProductCategory.ProductCategoryName AS Produto
FROM FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN DimProductSubcategory
			ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
				INNER JOIN DimProductCategory
					ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY ProductCategoryName
ORDER BY SUM(SalesQuantity) DESC


-- 4a. Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). 
SELECT TOP(3) * FROM FactOnlineSales
SELECT TOP(3) * FROM DimCustomer

SELECT TOP (3)
	DimCustomer.CustomerKey AS 'Categoria',
	DimCustomer.FirstName AS 'Nome',
	DimCustomer.LastName AS 'Sobrenome',
	SUM(SalesQuantity) AS 'Qnt. Vendida'
FROM FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY DimCustomer.CustomerKey, FirstName, LastName
ORDER BY SUM(SalesQuantity) DESC

-- b. Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto. 
SELECT
	ProductName,
	SUM(SalesQuantity) AS 'Qnt. Vendida'
FROM FactOnlineSales
INNER JOIN DimProduct
	ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE CustomerKey = 7665
GROUP BY ProductName
ORDER BY SUM(SalesQuantity) DESC


-- 5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
SELECT TOP(3) * FROM FactSales
SELECT TOP(3) * FROM FactOnlineSales
SELECT TOP(3) * FROM DimCustomer

SELECT
	SUM(SalesQuantity) AS 'Qnt. Produtos Comprados',
	Gender AS 'Sexo'
FROM FactOnlineSales
INNER JOIN DimCustomer
	ON DimCustomer.CustomerKey = FactOnlineSales.CustomerKey
WHERE Gender IS NOT NULL
GROUP BY Gender


-- 6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100. 
SELECT TOP(3) * FROM DimCurrency
SELECT TOP(3) * FROM FactExchangeRate

SELECT
	DimCurrency.CurrencyDescription,
	AVG(AverageRate) AS 'Taxa M�dia'
FROM FactExchangeRate
INNER JOIN DimCurrency
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY CurrencyDescription
HAVING AVG(AverageRate) BETWEEN 10 AND 100


-- 7. Descubra o valor total na tabela FactStrategyPlan destinado aos cen�rios: Actual e Budget. 
SELECT TOP(5) * FROM FactStrategyPlan
SELECT TOP(5) * FROM DimScenario

SELECT
	ScenarioName AS 'Cen�rio',
	SUM(Amount)	AS 'Total'
FROM FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY ScenarioName
HAVING ScenarioName IN ('Actual', 'Budget')


-- 8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico (FactStrategyPlan) por ano.
SELECT TOP(5) * FROM FactStrategyPlan
SELECT TOP(5) * FROM DimDate

SELECT
	CalendarYear AS 'Ano',
	SUM(Amount) AS 'Total'
FROM FactStrategyPlan
INNER JOIN DimDate
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY CalendarYear

-- 9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise apenas a marca Contoso e a cor Silver. 
SELECT TOP(3) * FROM DimProduct
SELECT TOP(3) * FROM DimProductSubcategory

SELECT
	ProductSubcategoryName AS 'Subcategoria',
	COUNT(*) AS 'Qnt. Produtos'
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE BrandName = 'Contoso' AND ColorName = 'Silver'
GROUP BY ProductSubcategoryName

-- 10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna BrandName

SELECT
	BrandName AS 'Marca',
	ProductSubcategoryName AS 'Subcategoria',
	COUNT(*) AS 'Qnt. Produtos'
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY BrandName, ProductSubcategoryName
ORDER BY BrandName ASC