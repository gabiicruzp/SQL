--CRUD
/*
C Create
R Read
U Update
D Delete
*/


-- CREATE/DROP DATABASE
CREATE DATABASE Teste
DROP DATABASE Teste
CREATE DATABASE BDImpressionador

USE BDImpressionador  -- Para alterar para o banco de dados de interesse caso tenha mais de um


-- CREATE TABLE
/*
CREATE TABLE Nome_tabela(
	Coluna1 TIPO,
	Coluna2 TIPO,
	Coluna3 TIPO
*/
CREATE TABLE Produtos(
	id_produto INT,
	nome_produto VARCHAR(200),
	data_validade DATETIME,
	preco_produto FLOAT
)
SELECT * FROM Produtos


-- INSERT INTO
/*
Inserir infos na tabela. Podemos inserir baseado em outra tabela como abaixo. Obs: Após o select DEVE seguir a ordem das colunas que foi colocada após o INSERT INTO
*/

INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
SELECT
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
FROM ContosoRetailDW.dbo.DimProduct
SELECT * FROM Produtos


/*
Ou podemos adicionar do 0
*/
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
VALUES
	(1, 'Arroz', '29/12/2021', 10.50),
	(2, 'Feijão', '30/12/2021', 15.50),
	(3, 'Macarrão', '31/12/2021', 20),
	(4, 'Tapioca', '28/12/2021', 30)

SELECT * FROM Produtos


-- UPDATE
UPDATE Produtos
SET nome_produto = 'Abacate'
WHERE id_produto = 3
SELECT * FROM Produtos


-- DELETE
DELETE 
FROM Produtos
WHERE id_produto = 3
SELECT * FROM Produtos


CREATE TABLE Funcionarios(
	id_funcionario INT,
	nome_funcionario VARCHAR(100),
	salario FLOAT,
	data_nascimento DATETIME
)

 
INSERT INTO Funcionarios(id_funcionario, nome_funcionario, salario, data_nascimento)
VALUES
	(1, 'Lucas',	1500, '01/03/1990'),
	(2, 'Andressa',	2300, '05/04/1989'),
	(3, 'Felipe',	4000, '15/05/1998'),
	(4, 'Marcelo',	7100, '20/06/1987'),
	(5, 'Carla',	3200, '25/07/1998'),
	(6, 'Juliana',	5500, '30/08/1965'),
	(7, 'Mateus',	1900, '03/09/1954'),
	(8, 'Sandra',	3900, '13/10/1989'),
	(9, 'André',	1000, '23/11/1990'),
	(10, 'Julio',	4700, '17/12/1995')

SELECT * FROM Funcionarios


-- ALTER TABLE
ALTER TABLE Funcionarios
ADD Cargo VARCHAR (100), bonus FLOAT

UPDATE Funcionarios
SET Cargo = 'Analista', bonus = 0.15
WHERE id_funcionario = 1
SELECT * FROM Funcionarios

ALTER TABLE Funcionarios
ALTER COLUMN salario INT
SELECT * FROM Funcionarios

ALTER TABLE Funcionarios
DROP COLUMN bonus
SELECT * FROM Funcionarios
