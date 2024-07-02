-- Funções Condicionais
/*
SELECT
	CASE
		WHEN teste_logico THEN 'resultado1'
		ELSE 'resultado2'
	END

SELECT
	CASE
		WHEN teste_logico THEN 'resultado1'
		WHEN teste_logico THEN 'resultado2'
		WHEN teste_logico THEN 'resultado3'
		ELSE 'resultado4'
	END
*/

DECLARE @nota FLOAT = 7
SELECT
	CASE
		WHEN @nota >=6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação do Aluno'


DECLARE 
	@data_vencimento DATETIME = '10/03/2022',
	@data_atual DATETIME = '30/04/2020'
SELECT
	CASE
		WHEN @data_atual > @data_vencimento THEN 'Produto Vencido'
		ELSE 'Produto dentro da Validade'
	END AS 'Produto'


--1. Faça SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e use o case para criar uma nova coluna com a info de "Masculino" ou "Feminino"

SELECT
	CustomerKey AS 'ID', 
	FirstName AS 'Nome',
	Gender,
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE 'Empresa'
	END AS 'Sexo'
FROM DimCustomer


--2. Crie um código para verificar a nota do aluno e deterimanr a situação:
--aprovado: nota maior ou igual a 6
--prova final: nota entre 4 a 6
--reprovado:nota abaixo de 4
DECLARE @nota FLOAT = 5.9

SELECT
	CASE
		WHEN @nota >= 6 THEN 'Aprovado'
		WHEN @nota >=4 THEN 'Prova Final'
		ELSE 'Reprovado'
	END AS 'Situação do Aluno'

--3. Classifique o produto de acordo com o seu preço
--Preco >= 40000: Luxo
--Preco >= 10000 e Preco <40000: Economico
--Preco <1000: Básico
DECLARE @preco FLOAT = 50000
SELECT 
	CASE
		WHEN @preco >=40000 THEN 'Luxo'
		WHEN @preco >=10000 THEN 'Economico'
		ELSE 'Básico'
	END AS 'Classe produto'


-- CASE AND e CASE OR
--4. Faça uma consulta à tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de preço com desconto. Caso o produto seja da marca contoso e da cor vermelha, o desconto será de 10%. Caso contrário não terá nenhum desconto

SELECT
	ProductName, 
	BrandName, 
	ColorName, 
	UnitPrice,
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS 'Preco com desconto'
FROM DimProduct

--5. Caso o produto seja da marca Litware ou Fabrikam ele receberá um desconto de 5%
SELECT
	ProductName, 
	BrandName, 
	ColorName, 
	UnitPrice,
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS 'Preco com desconto'
FROM DimProduct


-- CASE Anhinhado
SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
		CASE
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'Bonus'
FROM DimEmployee


-- CASE Aditivo
SELECT
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,
	UnitPrice,
	CASE WHEN ProductCategoryName = 'TV and Video' 
		THEN 0.10 ELSE 0 END
	+ CASE WHEN ProductSubcategoryName = 'Televisions' 
		THEN 0.05 ELSE 0 END
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


-- IIF:
/*
Qual a categoria de risco do projeto abaixo, de acordo com a sua nota:
Risco Alto: classificacao >= 5
Risco Baixo: classificacao <5
*/
DECLARE @classificacao INT = 9
SELECT
	IIF(
	@classificacao >=5,
	'Risco Alto', 
	'Risco Baixo')

/*
Crie uma coluna unica de Cliente, com nome do cliente, seja ele uma pessoa ou empresa .Traga a coluna de customerKey e CustomerType
*/
SELECT
	CustomerKey,
	CustomerType,
	IIF(
		CustomerType = 'Person', 
		FirstName, 
		CompanyName) AS 'Cliente'
FROM DimCustomer


-- ISNULL
SELECT 
	GeographyKey,
	ContinentName,
	CityName,
	ISNULL(CityName, 'Local Desconhecido')
FROM DimGeography