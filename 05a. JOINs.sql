-- JOIN

/*
Chave Primária é a coluna que identifica as info distintas em uma tabela, geralmente coluna de ID
Chave Estrangeira é uma coluna que permite relacionar as linhas de uma segunda tabela com a Chave Primária de uma primeira tabela

Tabela Dimensão: tabela com características de um determinado elemento: lojas, produtos, funcionários, clientes, etc. Elementos não se repetem. É onde tem as chaves primárias
Tabela Fato:tabela que vai registrar os fatos/acontecimentos de uma empresa/negócio em determinados períodos de tempo (vendas, devoluções, aberturas de chamados, receitas, despesas). Tabela c milharse de info e composta essencialmente por colunas de ID usadas p buscar info complementares. 
*/

-- Teoria
SELECT
	Tabela1.Coluna1, -- nao necessariamente precisa informar sempre a tabela antes, mas é necessário em caso de colunas com mesmo nome em tabelas diferentes
	Tabela1.Coluna2,
	Tabela1.Coluna3,
	Tabela2.Coluna1
FROM
	Tabela1
LEFT JOIN Tabela2  -- Variações: RIGHT JOIN, INNER JOIN, FULL JOIN
	ON Tabela1.Coluna3 = Tabela2.Coluna


-- Se queremos fazer um LEFT (ANTI) JOIN - e variaçoes - onde queremos uma tabela sem as infos de outras tabelas, temos que colocar o WHERE e filtrar por valores q não estariam na outra tabela, ou seja, valores NULL
SELECT
	Tabela1.Coluna1,
	Tabela1.Coluna2,
	Tabela1.Coluna3,
	Tabela2.Coluna1
FROM
	Tabela1
LEFT JOIN Tabela2
	ON Tabela1.Coluna3 = Tabela2.Coluna
WHERE coluna IS NULL


-- Exemplo
SELECT TOP(5) * FROM DimProduct
SELECT TOP(5) * FROM DimProductCategory

SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductCategoryKey, ProductCategoryName FROM DimProductCategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductCategory.ProductCategoryName
FROM
	DimProduct
INNER JOIN DimProductCategory
	ON DimProduct.ProductSubcategoryKey = DimProductCategory.ProductCategoryKey


-- Multiplos JOIN
SELECT TOP (3) ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT TOP (3) ProductSubcategoryKey, ProductSubcategoryName, ProductCategoryKey FROM DimProductSubcategory
SELECT TOP (3) ProductCategoryKey, ProductCategoryName FROM DimProductCategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductCategory.ProductCategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


-- UNION: para 2 tabelas com *exatamente* as mesmas colunas mas infos diferentes
-- OBS:ele une todas as linhas, mas exclui linhas duplicadas
SELECT * FROM DimCustomer
WHERE Gender = 'F'	-- supondo que exista uma coluna apenas com sexo F
UNION
SELECT * FROM DimCustomer
WHERE Gender = 'M'	-- supondo que exista uma coluna apenas com sexo M

-- UNION ALL: 
SELECT
	FirstName, 
	BirthDate
FROM DimCustomer
WHERE Gender = 'F'
UNION ALL -- Total de linhas: 18.484. Com "UNION", retorna apenas 18.450, ou seja, excluiu 34 linhas. Por isso usar UNION ALL
SELECT
	FirstName, 
	BirthDate
FROM DimCustomer
WHERE Gender = 'M'
