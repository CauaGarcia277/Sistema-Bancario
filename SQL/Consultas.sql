##Selecionando o total gasto das contas dos usuarios
SELECT c.nome, co.tipo, SUM(t.valor)
FROM conta AS co
INNER JOIN cliente AS c ON c.Idcliente = co.idCliente
INNER JOIN transacao AS t ON co.idConta = t.idContaOrigem
GROUP BY c.nome, co.tipo
ORDER BY c.nome, SUM(t.valor) DESC;


##Gasto total por usuario e ordenando em ordem decrescente
SELECT c.nome, SUM(t.valor)
FROM conta AS co
INNER JOIN cliente AS c ON c.Idcliente = co.idCliente
INNER JOIN transacao AS t ON co.idConta = t.idContaOrigem
GROUP BY c.nome
ORDER BY SUM(t.valor) DESC;


##Buscando quem teve mais gastos
SELECT c.nome AS nome, SUM(t.valor) AS valor
FROM conta AS co
INNER JOIN cliente AS c ON c.Idcliente = co.idCliente
INNER JOIN transacao AS t ON co.idConta = t.idContaOrigem
GROUP BY c.nome
ORDER BY SUM(t.valor) DESC
LIMIT 1;

##Selecionando quem recebeu entrada de valor em conta corrente e organizando em decrescente
## simplificando com natural join por o nome das colunas idCliente na tabela cliente e conta
##serem os mesmos, usando where para filtrar as contas para apenas conta corrente.
SELECT c.nome AS nome, co.tipo AS tipo, SUM(t.valor) AS valor
FROM conta AS co 
NATURAL JOIN cliente AS c
INNER JOIN transacao AS t WHERE t.idContaDestino = co.idConta AND co.tipo = 'Corrente'
GROUP BY nome
ORDER BY SUM(t.valor) DESC;

##Selecionando os gastos totais de conta corrente dos usuarios. Usando novamente Natural join por terem o mesmo nome de coluna.
SELECT c.nome AS nome, co.tipo AS tipo, SUM(t.valor) AS valor
FROM conta AS co 
NATURAL JOIN cliente AS c
INNER JOIN transacao AS t WHERE t.idContaOrigem = co.idConta AND co.tipo = 'Corrente'
GROUP BY nome
ORDER BY SUM(t.valor) DESC;
