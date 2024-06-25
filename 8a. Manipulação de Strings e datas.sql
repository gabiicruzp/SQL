-- Manipulando STRINGS e DATAS

-- LEN e DATALENGTH: 
SELECT LEN('Gabriela Cruz  ') AS 'Len'
SELECT DATALENGTH('Gabriela Cruz  ') AS 'DataLength' -- datalength diferencia do Len por considerar espaços adicionais


-- CONCAT: permite juntar mais de um texto em uma única palavra
SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail'
FROM DimCustomer


-- LEFT e RIGHT: extrai uma determinada quantidade de caracteres de um texto 
SELECT TOP(5) * FROM DimProduct

SELECT LEFT('Product0101001', 7)
SELECT RIGHT('Product0101001', 7)

SELECT 
	ProductName AS 'Produto', 
	UnitPrice AS 'Preço',
	LEFT(StyleName, 7) AS 'Cod1',
	RIGHT(StyleName, 7) AS 'Cod2'
FROM DimProduct


-- REPLACE: substitui um texto por outro
SELECT REPLACE('O Excel é o melhor', 'Excel', 'SQL') 

SELECT TOP(5) FROM DimCustomer
SELECT
	FirstName AS 'Nome', 
	LastName AS 'Sobrenome',
	Gender AS 'Sexo Abreviado', 
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo' --Precisa de um replace dentro de outro para substituir na mesma coluna. obs: tomar cuidado com a ordem e as palavras, se fosse o F antes do M, como "feminino" tem a letra M, ele vai substituir e ficar "FeMasculinonino"
FROM DimCustomer


-- TRANSLATE e STUFF: Translate substitui cada caractere na ordem encontrada no texto, e STUFF substitu qlq texto c uma qnt de caracteres limitados por outro texto
SELECT TRANSLATE ('10.241/444.124k23/1', './k', '---')
SELECT TRANSLATE ('10.241/444.124k23/1', './k', 'xxx')
SELECT TRANSLATE ('ABCD-490123', 'ABCD', 'WXYZ')

SELECT STUFF ('Python Impressionador', 1, 6, 'Excel') -- o segundo argumento é a posicao que começa o texto, o terceiro argumento é quantos caracteres tem o texto, e o quarto é qual o texto que vai entrar

SELECT
	STUFF ('MT98-Moto G', 1, 2, 'CEL'),
	STUFF ('AP01-Iphone', 1, 2, 'CEL'),
	STUFF ('SS61-Samsung', 1, 2, 'CEL')


-- UPPER e LOWER
SELECT
	FirstName AS 'Nome',
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer


-- FORMAT
--1. Formatar geral
SELECT FORMAT(5123, 'G') --G de geral
--2. Formatar número
SELECT FORMAT(5123, 'N') --N de número
--3. Formatar moeda
SELECT FORMAT(5123, 'C') --C de currency
--4. Formatar data
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'dd/MMMM/yyyy', 'en-US') -- O 3° argumento é p add idioma
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'dd')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'ddd')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'dddd')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'MM')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'MMM')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'MMMM')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'yy')
SELECT FORMAT(CAST('25/06/2024' AS DATETIME), 'yyyy')
--5. Formatação personalizada
SELECT FORMAT(1234567, '##-##-###')


-- CHARINDEX e SUBSTRING
--1. Descubra a posição em que começa o sobrenome da Raquel 
SELECT CHARINDEX('M', 'Raquel Moreno') -- a letra M esta na posição 8
SELECT CHARINDEX('Moreno', 'Raquel Moreno') -- a letra M esta na posição 8
--2. Extraia o sobrenome da Raquel 
SELECT SUBSTRING('Raquel Moreno', 8, 6) -- o 2° argumento é onde queremos extrair e p 3° até onde queremos
--3. Combine as 2 funções e extraia de forma automática
--podemos usar o charindex para selecionar algo em comum, no caso o espaço entre o nome e sobrenome, e então add '+1' pq queremos APÓS o espaço. E o argumento final (100) é a qnt max de caracteres que queremos
SELECT SUBSTRING('Bernardo Cavalcanti', CHARINDEX(' ', 'Bernardo Cavalcanti') +1 , 100)
SELECT SUBSTRING('Raquel Moreno', CHARINDEX(' ', 'Raquel Moreno') +1 , 100)
--4. Automatize a questão interior
DECLARE @varnome VARCHAR (100) = 'Bernardo Cavalcanti'
SELECT SUBSTRING(@varnome, CHARINDEX(' ', @varnome) +1 , 100)


-- TRIM, LTRIM, RTRIM: retira espaços adicionais no texto 
DECLARE @codigo VARCHAR(50) = '  ACB123   '
SELECT 
	TRIM(@codigo) AS 'Trim',
	LTRIM(@codigo) AS 'LTrim',
	RTRIM(@codigo) AS 'RTrim'

DECLARE @codigo VARCHAR(50) = '  ACB123   '
SELECT 
	DATALENGTH (TRIM(@codigo)) AS 'Trim',
	DATALENGTH (LTRIM(@codigo)) AS 'LTrim',
	DATALENGTH (RTRIM(@codigo)) AS 'RTrim'


-- DAY, MONTH e YEAR
DECLARE @data DATETIME = '25/06/2024'
SELECT
	DAY(@data) AS 'Data',
	MONTH(@data) AS 'Mês',
	YEAR(@data) AS 'Ano'


-- DATEFORMPARTS
DECLARE
	@dia INT = 25,
	@mes INT = 06,
	@ano INT = 2024

SELECT DATEFROMPARTS(@ano, @mes, @dia) AS 'Data'


-- GATDATE e SYSDATETIME: retorna data e hr atual do sistema
SELECT GETDATE()
SELECT SYSDATETIME()

-- DATENAME: Retorna info de uma data em formato de texto
DECLARE @data DATETIME = GETDATE()
SELECT 
	DATENAME(DAY, @data) AS 'Dia',
	DATENAME(MONTH, @data) AS 'Mes',
	DATENAME(YEAR, @data) AS 'Ano',
	DATENAME(DAYOFYEAR, @data) AS 'Dia do Ano'
-- DATEPART: Retorna info de uma data em formato de numero
SELECT 
	DATEPART(DAY, @data) AS 'Dia',
	DATEPART(MONTH, @data) AS 'Mes',
	DATEPART(YEAR, @data) AS 'Ano',
	DATEPART(DAYOFYEAR, @data) AS 'Dia do Ano'

SELECT
	SQL_VARIANT_PROPERTY(DATENAME(DAY, @data), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(DAY, @data), 'BaseType')


--DATEADD e DATEDIFF: permite add/subtrair uma qnt em relação a uma data e a outra calcula a diferença entre duas datas
DECLARE @data1 DATETIME = '10/07/2020'
DECLARE @data2 DATETIME = '05/03/2020'
DECLARE @data3 DATETIME = '14/11/2021'

SELECT
	DATEADD(DAY, 30, @data1),
	DATEADD(QUARTER, 1, @data1),
	DATEADD(QUARTER, -1, @data1)
SELECT
	DATEDIFF(DAY, @data2, @data3),
	DATEDIFF(MONTH, @data2, @data3),
	DATEDIFF(WEEK, @data2, @data3)