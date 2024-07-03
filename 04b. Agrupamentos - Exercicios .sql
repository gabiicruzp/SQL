-- Exercicio 1
SELECT TOP(100) * FROM FactSales
-- a. Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey). 
SELECT
	channelkey AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM FactSales
GROUP BY channelkey

-- b. Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
SELECT
	StoreKey AS 'ID Loja',
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM FactSales
GROUP BY StoreKey

-- c. Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007
SELECT
	channelKey AS 'Canal de Venda',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM FactSales
WHERE DateKey BETWEEN '20070101' AND '20071231'
GROUP BY channelKey


-- Exercicio 2
SELECT TOP(100) * FROM FactSales
--Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto (ProductKey). 
--a. A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso, mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000. 
SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) > 5000000
ORDER BY SUM(SalesAmount) DESC -- order by deve vir APOS o having

--b. Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado
SELECT TOP(10)
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM FactSales
GROUP BY ProductKey
ORDER BY SUM(SalesAmount) DESC


-- Exercicio 3
SELECT TOP(100) * FROM FactOnlineSales
--a. Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). 
SELECT
	CustomerKey AS 'ID do Cliente',
	SUM(SalesQuantity) AS 'Total Comprado'
FROM FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC
-- ID do cliente: 19037

--b. Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a)
SELECT TOP (3)
	ProductKey AS 'ID do Produto',
	SUM(SalesQuantity) AS 'Total Comprado'
FROM FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

-- Exercicio 4
SELECT * FROM DimProduct
-- a. Faça um agrupamento e descubra a quantidade total de produtos por marca. 
SELECT 
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Qnt Produto'
FROM DimProduct
GROUP BY BrandName
ORDER BY COUNT(BrandName) DESC

-- b. Determine a média do preço unitário (UnitPrice) para cada ClassName.
SELECT 
	ClassName AS 'ClasseProduto',
	AVG(UnitPrice) AS 'MédiaPreço'
FROM DimProduct
GROUP BY ClassName
ORDER BY AVG(UnitPrice) DESC

-- c. Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui
SELECT 
	ColorName AS 'Cor',
	SUM(Weight) AS 'Peso Total'
FROM DimProduct
GROUP BY ColorName
ORDER BY SUM(Weight) DESC

--Exercicio 5
SELECT * FROM DimProduct
-- Você deverá descobrir o peso total para cada tipo de produto (StockTypeName). A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em ordem decrescente
SELECT 
	StockTypeName AS 'Tipo de Produto',
	SUM(Weight) AS 'Peso Total'
FROM DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC

-- Exercicio 6
SELECT * FROM DimProduct
-- Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores?
SELECT 
	BrandName AS 'Marca', 
	COUNT(DISTINCT ColorName) AS 'Qnt Cor'
FROM DimProduct
GROUP BY BrandName
ORDER BY COUNT(DISTINCT ColorName) DESC

SELECT
	DISTINCT ColorName
FROM DimProduct
WHERE BrandName = 'Proseware' -- checando lista de cores que essa marca tem


-- Exercicio 7
SELECT * FROM DimCustomer
-- Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus conhecimentos em SQL.
--OBS: o resultado inesperado é que aparece NULL como sexo pq tem clientes que sao empresas e nao pessoas
SELECT
	Gender AS 'Sexo',
	COUNT(Gender) AS 'Qnt Total Clientes',
	AVG(YearlyIncome) AS 'Média Salário'
FROM DimCustomer
WHERE Gender IS NOT NULL
GROUP BY Gender


-- Exercicio 8
SELECT * FROM DimCustomer
-- Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento.
SELECT
	Education AS 'Escolaridade',
	COUNT(Education) AS 'Qnt Total',
	AVG(YearlyIncome) AS 'Média Salário'
FROM DimCustomer
WHERE Education IS NOT NULL 
GROUP BY Education

-- Exercicio 9
SELECT * FROM DimEmployee
--Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o Departamento (DepartmentName). Importante: Você deverá considerar apenas os funcionários ativos
SELECT
	DepartmentName AS 'Departamento',
	COUNT(DepartmentName) AS 'Qnt total por Departamento'
FROM DimEmployee
WHERE EndDate IS NULL -- ou WHERE Status = 'Current'
GROUP BY DepartmentName
ORDER BY COUNT(DepartmentName) DESC

-- Exercicio 10
SELECT * FROM DimEmployee
-- Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você deve considerar apenas as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.
SELECT
	Title AS 'Cargo',
	SUM(VacationHours) AS 'Hr Totais'
FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance') AND (HireDate BETWEEN '1999-01-01' AND '2000-12-31')
GROUP BY Title

