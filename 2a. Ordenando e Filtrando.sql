-- Ordenar por uma coluna
SELECT TOP(100) * FROM DimStore
ORDER BY EmployeeCount DESC -- ordena em ordem do maior para menor (ASC seria do menor para maior)

-- Selecionar 2 colunas e ordernar por uma delas
SELECT * FROM DimProduct

SELECT TOP(10)
	ProductName,
	UnitCost
FROM
	DimProduct
ORDER BY UnitCost DESC

-- Ordernar por mais de uma coluna
SELECT
	TOP(10)
	ProductName,
	UnitCost,
	Weight
FROM
	DimProduct
ORDER BY UnitCost DESC, Weight DESC


-- Filtrar por valor (Quantos produtos tem um preço unitario maior que $1000?)
SELECT
	ProductName,
	UnitPrice
FROM
	DimProduct
WHERE UnitPrice >= 1000
-- Tem 158 produtos acima de $1000


-- Filtrar por string/texto
SELECT DISTINCT BrandName FROM DimProduct

SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam'

SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' AND ColorName = 'Blue'

SELECT * FROM DimProduct
WHERE ColorName = 'Black' OR ColorName = 'Silver'

SELECT * FROM DimEmployee
WHERE NOT DepartmentName = 'Marketing'


-- Filtrar por data ('yyy-mm-dd')
SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'

SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'
ORDER BY BirthDate DESC


-- Filtrar com IN: significa que o que tiver entre () vai ter a função de OR, então ou isso ou aquilo ou aquilo
SELECT * FROM DimProduct
WHERE ColorName IN ('Silver', 'Blue', 'White', 'Red', 'Black')


-- Like: verifica dentro da célula se tem o que procuramos, então se tiver mais de uma palavra e vc quer filtrar apenas uma delas (ex: pessoas q tenham em algum lugar sobrenome Cruz). 
-- Obs: tem que colocar % pra falar que pode estar escrito antes ou depois de algo
SELECT * FROM DimProduct
WHERE ProductName LIKE '%MP3 Player%'

SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%Type%' -- Retorna quem tem Type em algum lugar

SELECT * FROM DimProduct
WHERE ProductDescription LIKE 'Type%' -- Retorna só quem tem Type no COMEÇO


-- Between
SELECT * FROM DimProduct
WHERE UnitPrice BETWEEN 50 AND 100

SELECT * FROM DimProduct
WHERE UnitPrice NOT BETWEEN 50 AND 100

SELECT * FROM DimEmployee
WHERE HireDate BETWEEN '2000-01-01' AND '2000-12-31'

-- Is Null/Is Not Null
SELECT * FROM DimCustomer
WHERE CompanyName IS NOT NULL

SELECT * FROM DimCustomer
WHERE CompanyName IS NULL


