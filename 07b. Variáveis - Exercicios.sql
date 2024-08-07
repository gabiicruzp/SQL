/*1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas: 
valor1 = 10		valor2 = 5		Valor3 = 34		valor4 = 7
a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma. 
b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao. 
c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao. 
d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro. Arredonde o resultado da letra d) para 2 casas decimais
*/
DECLARE @valor1 FLOAT = 10, 
		@valor2 FLOAT = 5,
		@valor3 FLOAT = 34,
		@valor4 FLOAT = 7 
DECLARE @varsoma FLOAT = @valor1 + @valor2
DECLARE @varssub FLOAT = @valor3 - @valor4
DECLARE @varmult FLOAT = @valor1 * @valor4
DECLARE @vardiv FLOAT = @valor3 / @valor4

SELECT @varsoma AS 'Soma'
SELECT @varssub AS 'Subtração'
SELECT @varmult AS 'Multiplicação'
SELECT ROUND(@vardiv, 2)


/*2.  Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado. 
a. Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’. 
b. Declare uma variável chamada ‘quantidade’ e atribua o valor de 12. 
c. Declare uma variável chamada ‘preco’ e atribua o valor 9.99. 
d. Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’. e. Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT
*/
DECLARE @produto VARCHAR(10) = 'Celular', 
		@quantidade INT = 12,
		@preco FLOAT = 9.99
DECLARE @faturamento FLOAT = @quantidade * @preco

SELECT
	@produto AS 'Produto',
	@quantidade AS 'Quantidade',
	@preco AS 'Preço', 
	@faturamento AS 'Faturamento'


/*3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são:
- Nome do usuário		-Data de nascimento		- Quantidade de pets que aquele usuário possui 
Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente
*/
DECLARE @nome VARCHAR(50) = 'André',
		@data_nascimento DATETIME = '10/02/1998',
		@num_pets INT = 2

SELECT 'Meu nome é ' + CAST(@nome AS VARCHAR(50)) + ', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pets AS VARCHAR(30)) + ' pets.'

/*4.Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa. A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho. O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura: ‘As lojas fechadas no ano de 2008 foram:  ’ + nome_das_lojas Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado.
*/
DECLARE @loja VARCHAR(50) = ''
SELECT
	@loja = @loja + StoreName + ', '
FROM DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008
PRINT 'As lojas fechadas no ano de 2008 foram ' + @loja


/*5.Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’. Utilize o conceito de variáveis para chegar neste resultado
*/
SELECT TOP(5) * FROM DimProduct
SELECT TOP(5) * FROM DimProductSubcategory

DECLARE @subcategoria VARCHAR(50) = 'Lamps'
DECLARE @id_subcategoria INT = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @subcategoria)
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = @id_subcategoria

