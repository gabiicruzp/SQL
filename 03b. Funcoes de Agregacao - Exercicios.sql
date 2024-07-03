-- 1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa:  Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa análise considerando a tabela FactSales
SELECT TOP(100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Qnt Vendida',
	SUM(ReturnQuantity) AS 'Qnt Devolvida'
FROM
	FactSales
WHERE channelKey = 1

-- 2.Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse resultado
SELECT TOP(100) * FROM DimCustomer

SELECT
	AVG(YearlyIncome) AS 'Média Anual Salário'
FROM
	DimCustomer
WHERE Occupation = 'Professional'


-- 3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa. O seu gerente te pediu os seguintes números e informações: 
-- a. Quantos funcionários tem a loja com mais funcionários? 
-- b. Qual é o nome dessa loja? 
-- c. Quantos funcionários tem a loja com menos funcionários? 
-- d. Qual é o nome dessa loja?
SELECT TOP(100) * FROM DimStore

SELECT TOP(1)
	StoreName AS 'NomeLoja',
	EmployeeCount AS 'Qnt Funcionarios'
FROM
	DimStore
ORDER BY EmployeeCount DESC

SELECT TOP(1)
	StoreName AS 'NomeLoja',
	EmployeeCount AS 'Qnt Funcionarios'
FROM
	DimStore
WHERE EmployeeCount IS NOT NULL
ORDER BY EmployeeCount ASC


-- 4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino e do sexo Feminino. 
-- a. Descubra essas duas informações utilizando o SQL. 
-- b. O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de cada um deles: Nome, E-mail, Data de Contratação
SELECT TOP(100) * FROM DimEmployee

SELECT
	COUNT(FirstName) AS 'Nome'
FROM
	DimEmployee
WHERE Gender = 'F'

SELECT TOP(1)
	FirstName,
	EmailAddress,
	HireDate
FROM 
	DimEmployee
WHERE Gender = 'F'
ORDER BY HireDate


SELECT
	COUNT(FirstName) AS 'Nome'
FROM
	DimEmployee
WHERE Gender = 'M'

SELECT TOP(1)
	FirstName,
	EmailAddress,
	HireDate
FROM 
	DimEmployee
WHERE Gender = 'M'
ORDER BY HireDate

-- 5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações: 
-- a. Quantidade distinta de cores de produtos. 
-- b. Quantidade distinta de marcas 
-- c. Quantidade distinta de classes de produto 
-- Para simplificar, você pode fazer isso em uma mesma consulta
SELECT * FROM DimProduct

SELECT
	COUNT(DISTINCT ColorName) AS 'Qnt de Cores',
	COUNT(DISTINCT BrandName) AS 'Marcas',
	COUNT(DISTINCT ClassName) AS 'Classe Produto'
FROM 
	DimProduct


