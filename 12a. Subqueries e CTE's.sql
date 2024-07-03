/*
Este texto da consulta foi recuperado do XML do plano de execução e pode estar truncado.
*/

-- SUBQUERIES e CTE's
/* 
Subquerie é um select dentro de outro select. Você consegue consultar dentro de outra consulta. 
1. Junto com o WHERE, funciona como um filtro variável
1.1 filtro dinâmico e escalar (valor único)
SELECT
	Coluna1,
	Coluna2
FROM
	Tabela
WHERE Coluna1 = (SELECT)

1.2 filtro dinâmico e em lista (vários valores
SELECT
	Coluna1,
	Coluna2
FROM
	Tabela
WHERE Coluna1 IN (SELECT)

2. Junto com o SELECT, funciona como uma nova coluna na tabela
SELECT
	Coluna1,
	Coluna2,
	SELECT
FROM
	Tabela


3. Junto com o FROM, funciona como uma nova tabela
SELECT
	Coluna1,
	Coluna2
FROM
	(SELECT) AS TabelaAuxiliar

*/

-- 1. Selecione produtos com preço maior que a média
USE ContosoRetailDW

SELECT 
	* 
FROM 
	DimProduct
WHERE 
	UnitPrice > (SELECT AVG(UnitPrice) From DimProduct)
--2. Consulte a tabela DimProduct e considere apenas os produtos com custos acima da média
SELECT 
	* 
FROM 
	DimProduct
WHERE 
	UnitCost >= (SELECT AVG(UnitCost) From DimProduct)
--3. Filtre a tabela DimProduct e retorne produtos da categoria 'Televisions'. Como não temos a info de Nome de Subcategoria nessa tabela, faça um novo select que descubra o ID da categoria desejada e passe esse resultado como o valor que queremos filtrar dentro do WHERE
SELECT 
	* 
FROM 
	DimProduct
WHERE ProductSubcategoryKey =
	(SELECT ProductSubcategoryKey 
		FROM DimProductSubcategory
			WHERE ProductSubcategoryName = 'Televisions')
-- 4. Filtre a tabela FactSales mostrando apenas as vendas referentes às lojas com 100 ou mais funcionarios
/*SELECT
	StoreKey
FROM
	DimStore
WHERE EmployeeCount >=100*/

SELECT 
	* 
FROM 
	FactSales
WHERE StoreKey IN (
	SELECT 
		StoreKey
	FROM
		DimStore
	WHERE EmployeeCount >=100)
-- ANY, SOME, ALL
/*ANY e SOME funcionam da mesma maneira*/ 
CREATE TABLE Funcionarios(
	id_funcionario INT,
	nome VARCHAR (50),
	idade INT,
	sexo VARCHAR(50))
INSERT INTO funcionarios(id_funcionario, nome, idade, sexo)
VALUES
	(1,	'Julia', 20, 'F'),
	(2,	'Daniel', 21, 'M'),
	(3,	'Amanda', 22, 'F'),
	(4,	'Pedro', 23, 'M'),
	(5,	'André', 24, 'M'),
	(6,	'Luisa', 25, 'F')
SELECT * FROM funcionarios
--5. Selecione o sexo masculino utilizando a coluna de idade para isso 
SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)
SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')
/*O ANY funciona parecido ao IN, mas permite usar funções, como -, >= etc */
SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')
/*Abaixo vai retornar as linhas com valores maiores que o valor1, OU valor2 OU valor3. Ou seja, maior que o minimo*/
SELECT * FROM funcionarios
WHERE idade >= ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')
/*Abaixo vai retornar as linhas com valores menores que o valor1, OU valor2 OU valor3. Ou seja, menor que o maximo*/
SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')
/*Abaixo vai retornar as linhas com valores maiores que o valor1 E valor 2 E valor3*/
SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')
/*Abaixo vai retornar as linhas com valores menores que o valor1 E valor 2 E valor3*/
SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')
--EXIST
--6. Retorne uma tabela com todos os produtos (ID Produto e Nome Produto) que possuam alguma venda no dia 01/01/2007
USE ContosoRetailDW

SELECT COUNT(*) FROM DimProduct
SELECT TOP(100) * FROM FactSales
SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE EXISTS(
	SELECT
		ProductKey
	FROM
		FactSales
	WHERE
		DateKey = '01/01/2007'
		AND FactSales.ProductKey = DimProduct.ProductKey  --Preciso verificar se os ID resultantes das consultas são os mesmos que do filtro
	)
-- 7. Retorne uma tabela com todos os produtos e o total de vendas para cada produto
SELECT
	ProductKey,
	ProductName,
	(SELECT 
		COUNT(ProductKey)
	FROM
		FactSales 
	WHERE 
		FactSales.ProductKey = DimProduct.ProductKey) AS 'Qnt vendas' 
FROM
	DimProduct
--8. Retorne a quantidade total de produtos da marca Contoso
SELECT
	COUNT(*)
FROM DimProduct
WHERE BrandName ='Contoso'
SELECT
	COUNT(*)
FROM
	(SELECT 
		* 
	FROM DimProduct 
	WHERE BrandName = 'Contoso') AS Tabela


--9. Descubra os nomes dos clientes que ganham o segundo maior salário 
/*Precimos descobrir o maior salario, depois descobrir apenas o segundo maior salario, e então os nomes dos clientes que ganham o segundo maior salário*/
/* Dá pra fazer assim:
SELECT
	*
FROM
	DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC

SELECT
	DISTINCT TOP(2) YearlyIncome
FROM
	DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC

SELECT
	CustomerKey,
	FirstName, 
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = 160000*/

SELECT
	CustomerKey,
	FirstName, 
	LastName,
	YearlyIncome
FROM 
	DimCustomer
WHERE 
	YearlyIncome = (
		SELECT 
			MAX(YearlyIncome)
		FROM
			DimCustomer
		WHERE 
			YearlyIncome < (
				SELECT
					MAX(YearlyIncome) -- o valor max após o max valor
				FROM
					DimCustomer
				WHERE 
					CustomerType = 'Person'))

--CTE (Commom Table Expression) Permite armazenar o resultado de uma consulta
--10. Crie uma CTE para armazenar o resultado de uma consulta que tenha ProductKey, ProductName, BrandName, ColorName e UnitPrice, apenas para a marca contoso

WITH cte AS (
SELECT
	ProductKey,
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
FROM 
	DimProduct
WHERE BrandName = 'Contoso'
)

SELECT * FROM cte

--11. Crie uma CTEque seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca
WITH cte(Marca, Total) AS (		--Podemos já renomear as colunas aqui mesmo
SELECT
	BrandName, 
	COUNT(*)
FROM
	DimProduct
GROUP BY 
	BrandName
)
SELECT
	Marca,
	Total
FROM cte

/*12. Crie 2 CTE:
(1) produtos_contoso: a partir de DimProduct - ProductKey, ProductName, BrandName
(2) vendas_top100: top 100 vendas a partir de FactSales - SalesKey, ProductKey, DateKey, SalesQuantity*/

WITH produtos_contoso AS (
SELECT
	ProductKey, 
	ProductName, 
	BrandName
FROM DimProduct
WHERE BrandName = 'Contoso'
),
vendas_top100 AS (
SELECT TOP(100)
	SalesKey, 
	ProductKey,
	DateKey,
	SalesQuantity
FROM FactSales
ORDER BY DateKey DESC
)
SELECT * FROM vendas_top100
INNER JOIN produtos_contoso
	ON vendas_top100.ProductKey = produtos_contoso.ProductKey