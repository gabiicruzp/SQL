-- Variáveis
/*
INT: Números inteiros
FLOAT, DECIMAL ou NUMERIC: Números decimais
STRING: Texto
DATETIME: Data
*/

-- Operações básicas
SELECT 10 AS 'Número'
SELECT 'Gabi' AS 'Nome'
SELECT '12/06/2024' AS 'Data'

SELECT 10 + 20 AS 'Soma'
SELECT 20 - 5 AS 'Subtração'
SELECT 30 * 40 AS 'Multiplicação'
SELECT 431/23 AS 'Divisão' -- vai dar resultado inteiro
SELECT 431.0/23 AS 'Divisão'

SELECT 'Gabi' + ' ' + 'Cruz' AS 'Nome'

-- SQL_VARIANT_PROPERTY
SELECT SQL_VARIANT_PROPERTY(10, 'BaseType') -- Precisa da variavel e a propriedade
SELECT SQL_VARIANT_PROPERTY(49.50, 'BaseType') 
SELECT SQL_VARIANT_PROPERTY('Gabi', 'BaseType') 
SELECT SQL_VARIANT_PROPERTY('12/06/2024', 'BaseType') -- quando escrevemos data assim, sem declarar como data, ele entende como texto e não data. 


-- CAST
-- CAST é uma função para especificar o tipo dos dados
SELECT CAST (21.45 AS INT)
SELECT SQL_VARIANT_PROPERTY(CAST(21.45 AS INT),'BaseType')

SELECT CAST (21.45 AS FLOAT)
SELECT SQL_VARIANT_PROPERTY(CAST(21.45 AS FLOAT),'BaseType')

SELECT CAST ('21.45' AS FLOAT)

SELECT CAST ('12/06/2024' AS DATETIME)
SELECT SQL_VARIANT_PROPERTY(CAST('12/06/2024' AS DATETIME),'BaseType')

-- 1. Crie uma consulta juntando o texto "o valor é" com o valor "30,99"
SELECT 'O valor é ' + CAST(30.99 AS VARCHAR(50)) -- força o SQL entender que o número é texto entre parentesis é a qnt (n) de caracteres

-- 2. Adicione 1 dia à data '12/06/2024'
SELECT CAST('12/06/2024' AS DATETIME) + 1


-- FORMAT: permite alterar formatação de valores
--a) Numéricos
SELECT FORMAT(1000, 'N') -- N de number
SELECT FORMAT(1000, 'G') -- G de general

--b) Personalizados
SELECT FORMAT(123456789, '###-##-####')

--c) Data
SELECT FORMAT(CAST('12/06/2024' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('12/06/2024' AS DATETIME), 'dd/MMM/yyyy')
SELECT FORMAT(CAST('12/06/2024' AS DATETIME), 'dd/MMMM/yyyy')
SELECT FORMAT(CAST('12/06/2024' AS DATETIME), 'ddd')
SELECT FORMAT(CAST('12/06/2024' AS DATETIME), 'dddd')

-- 3. Crie uma consulta juntando o texto 'A validade do produto é' com a data: 17/abr/2025). Obs: use CAST para garantir que a data é entendida com DATETIME
SELECT 'A validade do produto é ' + FORMAT(CAST('17/03/2025' AS DATETIME), 'dd/MMM/yyyy')


-- ROUND
SELECT 431.0/23
SELECT ROUND (18.739130, 2) -- arredondar na 2° casa decimal
SELECT ROUND (18.739130, 2, 0) -- o 3° argumento perminte truncar o valor
SELECT ROUND (18.739130, 2, 1) -- o 3° argumento perminte truncar o valor

-- FLOOR: arredonda para baixo
SELECT FLOOR(18.739130)

-- CEILING: arredonda para cima
SELECT CEILING(18.739130)


-- DECLARE e SET
DECLARE @var tipo -- o tipo é o tipo de variavel
SET @var -- para armazenar o valor a variavel
SELECT @var -- para visualizar

DECLARE @var INT
SET @var = 10
SELECT @var

DECLARE @numero FLOAT
SET @numero = 1000

SELECT @numero
SELECT @numero * @numero
SELECT FORMAT(@numero * @numero, 'N')

-- 4. Declare uma variavel chamada idade e armazene o valor 30
DECLARE @idade INT
SET @idade = 30
SELECT @idade AS 'Idade'

-- 5. Declare uma variavel chamada preço e armazene o valor 10.89
DECLARE @preco FLOAT
SET @preco = 10.89
SELECT @preco AS 'Preço Unitário'

-- 6. Declare uma variavel chamada nome e armazene o valor Gabi
DECLARE @nome VARCHAR(30)
SET @nome = 'Gabi'
SELECT @nome AS 'Nome'

-- 7. Declare uma variavel chamada data e armazene a data 12/06/2024
DECLARE @data DATETIME
SET @data = '12/06/2024'
SELECT @data AS 'Data'

-- 8. Declare mais de uma variavel
DECLARE @var1 INT
DECLARE @texto VARCHAR (30)
DECLARE @data DATETIME

SET @var1 = 10
SET @texto = 'Texto qualquer'
SET @data = '12/06/2024'

SELECT @var1, @texto, @data

/*
DECLARE @var1 INT,
		@texto VARCHAR (30),
		@data DATETIME

DECLARE @var1 INT = 10,
		@texto VARCHAR (30) = 'Texto Qualquer',
		@data DATETIME = '12/06/2024'
*/

-- 9. Sua loja fez uma venda de 100 camisas, cada uma custando 89.99. Faça um SELECT para obter o resultado do faturamento
SELECT 100 * 89.99 AS 'Faturamento'
DECLARE @qnt INT = 100,
		@valor FLOAT = 89.99
SELECT @qnt * @valor AS 'Faturamento'


-- 10. Aplique 10% de desconto em todos os preços de produtos. A consulta final deve ter colunas: ProductKey, ProductName, UnitPrice e Preço com desconto
SELECT TOP(5) * FROM DimProduct

DECLARE @valordesconto FLOAT = 0.10
SELECT
	DimProduct.ProductKey AS 'ID',
	DimProduct.ProductName AS 'Produto',
	DimProduct.UnitPrice AS 'Valor Unid',
	DimProduct.UnitPrice - (DimProduct.UnitPrice * @valordesconto) AS 'Valor com Desconto'
FROM DimProduct
/* ou */
DECLARE @valordesconto FLOAT = 0.10
SELECT
	DimProduct.ProductKey AS 'ID',
	DimProduct.ProductName AS 'Produto',
	DimProduct.UnitPrice AS 'Valor Unid',
	DimProduct.UnitPrice * (1 - @valordesconto) AS 'Valor com Desconto'
FROM DimProduct


-- 11. Crie uma variavel para armazenar a quantidade total de funcionarios da tabela DimEmployee

DECLARE @varTotalFunc INT = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalFunc AS 'Total Funcionários'

-- 12. Crie uma variavel para armazenar a qnt total de lojas com status off

DECLARE @varLojasOff INT = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOff AS 'Lojas Fechadas'



DECLARE @varData DATETIME = '01/01/1980'
DECLARE @nFunc INT = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
DECLARE @nClientes INT = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)
/*
SELECT 'Número de Funcionários', @nFunc
UNION
SELECT 'Númerio de Clientes', @nClientes */


-- PRINT

DECLARE @varData DATETIME = '01/01/1980'
DECLARE @nFunc INT = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
DECLARE @nClientes INT = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)
PRINT 'Número de Funcionários = ' + CAST(@nFunc AS VARCHAR(MAX))
PRINT 'Número de Clientes = ' + CAST(@nClientes AS VARCHAR(MAX))

--13. Print a qnt de lojas On e a qnt de lojas Off da tabela DimStore. 
SET NOCOUNT ON --nao faz contagem de linha na hora que roda o resultado final
DECLARE @varLojasOn INT, @varLojasOff INT
SET @varLojasOn = (SELECT COUNT(*) FROM DimStore WHERE Status = 'On')
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOn AS 'Lojas Abertas', @varLojasOff AS 'Lojas Fechadas'
PRINT 'O total de lojas abertas é ' + CAST(@varLojasOn AS VARCHAR(MAX))
PRINT 'O total de lojas fechadas é ' + CAST(@varLojasOff AS VARCHAR(MAX))


-- 14. Qual é o nome do produto que teve a maior quantidade vendida em uma única venda da tabela FactSales
SELECT TOP (5) * FROM FactSales
SELECT TOP (5) * FROM DimProduct

SELECT TOP (3)
	DimProduct.ProductKey,
	DimProduct.ProductName AS 'Nome Produto',
	SalesQuantity AS 'Quantidade'
FROM DimProduct
LEFT JOIN FactSales
	ON DimProduct.ProductKey = FactSales.ProductKey
ORDER BY SalesQuantity DESC


DECLARE @varProdMaisVendido INT, @varTotalMaisVendido INT

SELECT TOP (1)
	@varProdMaisVendido = ProductKey,
	@varTotalMaisVendido = SalesQuantity
FROM
	FactSales
ORDER BY SalesQuantity DESC

PRINT @varProdMaisVendido
PRINT @varTotalMaisVendido


-- Print uma lista com os nomes das funcionárias do departamento de marketing
SELECT TOP (5) * FROM DimEmployee
/*
SELECT
	DimEmployee.DepartmentName AS 'Departamento',
	DimEmployee.FirstName AS 'Nome'
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'
*/

DECLARE @varLista VARCHAR(50)
SET @varLista = '' -- lista por enquanto vazia, iremos adicionar os nomes aos poucos

SELECT 
	@varLista = @varLista + FirstName + ', ' + CHAR(10) -- CHAR(10) permite printar 1 resultado por linha
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'
PRINT LEFT(@varLista, DATALENGTH(@varLista) - 3) -- ao usar a função LEFT e DATALENGHT podemos tirar os ultimos caracteres, removendo a ultima virgula 


--VARIAVEIS GLOBAIS: @@
SELECT @@SERVERNAME -- Saber o nome do servidor
SELECT @@VERSION -- Versão do programa

SELECT * FROM DimProduct
SELECT @@ROWCOUNT -- Conta a quantidade de linhas
