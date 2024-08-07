-- Exercicios aula

-- 1. Selecione todas as linhas da tabela DimEmployee de Funcionarios do sex feminino e do departamenteo de Finanças
SELECT DISTINCT DepartmentName FROM DimEmployee

SELECT * FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName = 'Finance'

-- 2. Selecione todas as linhas da tabela DimProduct de produtos da marca Contoso e da cor vermelha e que tenhm um UnitPrice maior ou igual a $100
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Red' AND UnitPrice >= 100

-- 3. Selecione todas as linahs da tabela DimProduct com produtos da marca Litware ou da marca Fabrikam ou da marca preta
SELECT * FROM DimProduct
WHERE BrandName = 'Litware' OR BrandName = 'Fabrikam' OR ColorName = 'Black'

-- 4. Selecione todas as linhas da tabela DimSalesTerritory onde o continente é europa mas o pais não é Italia
SELECT TOP(1000) * FROM DimSalesTerritory
SELECT DISTINCT SalesTerritoryCountry FROM DimSalesTerritory

SELECT * FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry = 'Italy'

-- 5. Selecione todas as linhas da tabela DimProduct onde a cor do produto pode ser preto ou vermelho, mas a marca deve ser Fabrikam
SELECT * FROM DimProduct
WHERE (ColorName = 'Black' OR ColorName = 'Red') AND BrandName = 'Fabrikam'

-- Exercicios extras
-- 1. Você é o gerente da área de compras e precisa criar um relatório com as TOP 100 vendas, de acordo com a quantidade vendida. Você precisa fazer isso em 10min pois o diretor de compras solicitou essa informação para apresentar em uma reunião. Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total vendido (SalesAmount)
SELECT TOP(100) * FROM FactSales
ORDER BY SalesQuantity DESC

-- 2.Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo preço. Porém, a empresa quer diferenciar esses preços de acordo com o peso (Weight) de cada um. O que você precisará fazer é ordenar esses top 10 produtos, de acordo com a coluna de UnitPrice e, além disso, estabelecer um critério de desempate, para que seja mostrado na ordem, do maior para o menor. Caso ainda assim haja um empate entre 2 ou mais produtos, pense em uma forma de criar um segundo critério de desempate (além do peso).
SELECT TOP(10) * 
FROM
	DimProduct
ORDER BY UnitPrice DESC, Weight DESC, AvailableForSaleDate ASC

-- 3. Você é responsável pelo setor de logística da empresa Contoso e precisa dimensionar o transporte de todos os produtos em categorias, de acordo com o peso. Os produtos da categoria A, com peso acima de 100kg, deverão ser transportados na primeira leva. Faça uma consulta no banco de dados para descobrir quais são estes produtos que estão na categoria A. 
-- a. Você deverá retornar apenas 2 colunas nessa consulta: Nome do Produto e Peso. 
-- b. Renomeie essas colunas com nomes mais intuitivos. 
-- c. Ordene esses produtos do mais pesado para o mais leve.
SELECT 
	ProductName AS 'Produto',
	Weight AS 'Peso'
FROM 
	DimProduct
WHERE Weight >= 100
ORDER BY Weight DESC

-- 4. Você foi alocado para criar um relatório das lojas registradas atualmente na Contoso. 
-- a. Descubra quantas lojas a empresa tem no total. Na consulta que você deverá fazer à tabela DimStore, retorne as seguintes informações: StoreName, OpenDate, EmployeeCount. 
-- b. Renomeeie as colunas anteriores para deixar a sua consulta mais intuitiva. 
-- c. Dessas lojas, descubra quantas (e quais) lojas ainda estão ativas.
SELECT * FROM DimStore

SELECT DISTINCT StoreName FROM DimStore

SELECT
	StoreName AS 'NomeLoja',
	OpenDate AS 'DataAbertura', 
	EmployeeCount AS 'QntFuncionario'
FROM
	DimStore
WHERE StoreType = 'Store' AND Status = 'On'


-- 5. O gerente da área de controle de qualidade notificou à Contoso que todos os produtos Home Theater da marca Litware, disponibilizados para venda no dia 15 de março de 2009, foram identificados com defeitos de fábrica. O que você deverá fazer é identificar os ID’s desses produtos e repassar ao gerente para que ele possa notificar as lojas e consequentemente solicitar a suspensão das vendas desses produtos.
SELECT * FROM DimProduct
WHERE BrandName = 'Litware' AND ProductName LIKE '%Home Theater%' AND AvailableForSaleDate = '20090315'

-- 6. Imagine que você precise extrair um relatório da tabela DimStore, com informações de lojas. Mas você precisa apenas das lojas que não estão mais funcionando atualmente. 
--a. Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que não estão mais funcionando. 
--b. Agora imagine que essa coluna de Status não existe na sua tabela. Qual seria a outra forma que você teria de descobrir quais são as lojas que não estão mais funcionando
SELECT * FROM DimStore
WHERE Status = 'Off'

SELECT * FROM DimStore
WHERE CloseDate IS NOT NULL

-- 7. De acordo com a quantidade de funcionários, cada loja receberá uma determinada quantidade de máquinas de café. As lojas serão divididas em 3 categorias: 
--CATEGORIA 1: De 1 a 20 funcionários -> 1 máquina de café 
--CATEGORIA 2: De 21 a 50 funcionários -> 2 máquinas de café 
--CATEGORIA 3: Acima de 51 funcionários -> 3 máquinas de café 
--Identifique, para cada caso, quais são as lojas de cada uma das 3 categorias acima (basta fazer uma verificação)
SELECT * FROM DimStore
WHERE EmployeeCount BETWEEN 1 AND 20

SELECT * FROM DimStore
WHERE EmployeeCount BETWEEN 21 AND 50

SELECT * FROM DimStore
WHERE EmployeeCount > 50

-- 8. A empresa decidiu que todos os produtos LCD receberão um super desconto no próximo mês. O seu trabalho é fazer uma consulta à tabela DimProduct e retornar os ID’s, Nomes e Preços de todos os produtos LCD existentes
SELECT
	ProductDescription AS 'ID', 
	ProductName AS 'NomeProduto',
	UnitPrice AS 'PrecoProduto'
FROM DimProduct
WHERE ProductName LIKE '%LCD%'


-- 9. Faça uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes produtos devem ser exclusivamente das marcas: Contoso, Litware e Fabrikam
SELECT * FROM DimProduct
WHERE ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink') AND BrandName IN ('Contoso', 'Litware', 'Fabrikam')

-- 10. A empresa possui 16 produtos da marca Contoso, da cor Silver e com um UnitPrice entre 10 e 30. Descubra quais são esses produtos e ordene o resultado em ordem decrescente de acordo com o preço (UnitPrice)
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Silver' AND UnitPrice BETWEEN 10 AND 30
ORDER BY UnitPrice DESC












