/*1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas: 
valor1 = 10		valor2 = 5		Valor3 = 34		valor4 = 7
a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame essa vari�vel de soma. 
b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4. Chame essa vari�vel de subtracao. 
c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o valor4. Chame essa vari�vel de multiplicacao. 
d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro. Arredonde o resultado da letra d) para 2 casas decimais
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
SELECT @varssub AS 'Subtra��o'
SELECT @varmult AS 'Multiplica��o'
SELECT ROUND(@vardiv, 2)


/*2.  Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser especificado. 
a. Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�. 
b. Declare uma vari�vel chamada �quantidade� e atribua o valor de 12. 
c. Declare uma vari�vel chamada �preco� e atribua o valor 9.99. 
d. Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre �quantidade� e �preco�. e. Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT
*/
DECLARE @produto VARCHAR(10) = 'Celular', 
		@quantidade INT = 12,
		@preco FLOAT = 9.99
DECLARE @faturamento FLOAT = @quantidade * @preco

SELECT
	@produto AS 'Produto',
	@quantidade AS 'Quantidade',
	@preco AS 'Pre�o', 
	@faturamento AS 'Faturamento'


/*3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de usu�rios. Em resumo, esses dados s�o:
- Nome do usu�rio		-Data de nascimento		- Quantidade de pets que aquele usu�rio possui 
Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente
*/
DECLARE @nome VARCHAR(50) = 'Andr�',
		@data_nascimento DATETIME = '10/02/1998',
		@num_pets INT = 2

SELECT 'Meu nome � ' + CAST(@nome AS VARCHAR(50)) + ', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pets AS VARCHAR(30)) + ' pets.'

/*4.Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as lojas da empresa. A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho. O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura: �As lojas fechadas no ano de 2008 foram:  � + nome_das_lojas Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado.
*/
DECLARE @loja VARCHAR(50) = ''
SELECT
	@loja = @loja + StoreName + ', '
FROM DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008
PRINT 'As lojas fechadas no ano de 2008 foram ' + @loja


/*5.Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria espec�fica: �Lamps�. Utilize o conceito de vari�veis para chegar neste resultado
*/
SELECT TOP(5) * FROM DimProduct
SELECT TOP(5) * FROM DimProductSubcategory

DECLARE @subcategoria VARCHAR(50) = 'Lamps'
DECLARE @id_subcategoria INT = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @subcategoria)
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = @id_subcategoria

