-- Comentários podem ser feitos com -- ou ao colocar /* ... */
SELECT * FROM tabela -- seleciona todas as colunas da tabela
SELECT Coluna1, Coluna2, Coluna3 FROM tabela -- seleciona apenas as colunas que queremos
SELECT DISTINCT Coluna1 FROM tabela -- Seleciona os valores distintos daquela coluna
SELECT TOP(N) * FROM tabela -- Seleciona as N primeiras linhas da tabela
SELECT TOP(N) * PERCENT FROM tabela -- Seleciona as N% primeiras linhas da tabela
SELECT Coluna1 AS 'NovoNome' FROM tabela -- renomeia as colunas, mas a tabela original nao é alterado


-- 1. Vc é responsável por controlar os dados de clientes e de produtos da sua empresa. O que precisa fazer é confirmar se
-- a. Existem 2.517 produtos cadastrados na base e, se não tiver, vc deverá reportar ao seu gestor para saber se existe alguma defasagem no controle de produtos
SELECT * FROM DimProduct
SELECT DISTINCT ProductName FROM DimProduct
-- Se olhar abaixo da tabela no canto inferior direito, vai ver info de linhas. Se temos valores distintos, podemos ver o n que resultou. 
-- Poderiamos usar coluna ProductKey já que é a chave para cada valor unico

-- b. Até mes passado, a empresa tinha total de 19.500 clientes na base de controle, verifique se o n aumentou ou diminuiu
SELECT * FROM DimCustomer
SELECT DISTINCT CustomerKey FROM DimCustomer
-- A base tem 18.869 clientes atualmente, ou seja, menos que no mês anterior


-- 2. Você trabalha no setor de marketing da empresa Contoso e acaba de ter uma ideia de oferecer descontos especiais para os clientes no dia de seus aniversários. Para isso, você vai precisar listar todos os clientes e as suas respectivas datas de nascimento, além de um contato. 
-- a. Selecione as colunas: CustomerKey, FirstName, EmailAddress, BirthDate da tabela dimCustomer. 
-- b. Renomeie as colunas dessa tabela usando o alias (comando AS).
SELECT
	CustomerKey AS 'ID', 
	FirstName AS 'PrimeiroNome', 
	EmailAddress AS 'E-mail', 
	BirthDate AS 'Aniversário'
FROM DimCustomer


-- 3. A Contoso está comemorando aniversário de inauguração de 10 anos e pretende fazer uma ação de premiação para os clientes. A empresa quer presentear os primeiros clientes desde a inauguração. Você foi alocado para levar adiante essa ação. Para isso, você terá que fazer o seguinte: 
-- a. A Contoso decidiu presentear os primeiros 100 clientes da história com um vale compras de R$ 10.000. Utilize um comando em SQL para retornar uma tabela com os primeiros 100 primeiros clientes da tabela dimCustomer (selecione todas as colunas). 
-- b. A Contoso decidiu presentear os primeiros 20% de clientes da história com um vale compras de R$ 2.000. Utilize um comando em SQL para retornar 10% das linhas da sua tabela dimCustomer (selecione todas as colunas). 
-- c. Adapte o código do item a) para retornar apenas as 100 primeiras linhas, mas apenas as colunas FirstName, EmailAddress, BirthDate. 
-- d. Renomeie as colunas anteriores para nomes em português
SELECT TOP(100) * FROM DimCustomer
SELECT TOP(20) PERCENT * FROM DimCustomer

SELECT TOP(100)
	FirstName AS 'PrimeiroNome', 
	EmailAddress AS 'E-mail', 
	BirthDate AS 'Aniversário'
FROM 
	DimCustomer


-- 4. A empresa Contoso precisa fazer contato com os fornecedores de produtos para repor o estoque. Você é da área de compras e precisa descobrir quem são esses fornecedores. Utilize um comando em SQL para retornar apenas os nomes dos fornecedores na tabela dimProduct e renomeie essa nova coluna da tabela.
SELECT * FROM DimProduct
SELECT 
	DISTINCT 
	Manufacturer AS 'Produtor' 
FROM
	DimProduct


-- 5. O seu trabalho de investigação não para. Você precisa descobrir se existe algum produto registrado na base de produtos que ainda não tenha sido vendido. Tente chegar nessa informação. 
-- Obs: caso tenha algum produto que ainda não tenha sido vendido, você não precisa descobrir qual é, é suficiente saber se teve ou não algum produto que ainda não foi vendido
SELECT * FROM DimProduct
SELECT TOP(1000) * FROM FactSales --Tabela muito grande que vai demorar um tempo pra rodar, por isso usou o top(n)
SELECT DISTINCT ProductKey FROM FactSales
-- Vai ver que tem 2516 produtos vendidos de 2.517 produtos cadastrados na base, então ou um produto nao foi vendido ou ele foi cadastrado errado
