##Selecionando o total gasto das contas dos usuarios
SELECT c.nome, co.tipo, SUM(t.valor)
from conta as co
inner join cliente as c on c.Idcliente = co.idCliente
inner join transacao as t on co.idConta = t.idContaOrigem
group by c.nome, co.tipo
order by c.nome, SUM(t.valor) desc;


##Gasto total por usuario e ordenando em ordem decrescente
SELECT c.nome, SUM(t.valor)
from conta as co
inner join cliente as c on c.Idcliente = co.idCliente
inner join transacao as t on co.idConta = t.idContaOrigem
group by c.nome
order by SUM(t.valor) desc;


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
SELECT c.nome as nome, co.tipo as tipo, SUM(t.valor) as valor
from conta as co 
NATURAL JOIN cliente AS c
INNER JOIN transacao AS t where t.idContaDestino = co.idConta and co.tipo = 'Corrente'
GROUP BY nome
ORDER BY SUM(t.valor) desc;

##Selecionando os gastos totais de conta corrente dos usuarios. Usando novamente Natural join por terem o mesmo nome de coluna.
SELECT c.nome as nome, co.tipo as tipo, SUM(t.valor) as valor
from conta as co 
NATURAL JOIN cliente AS c
INNER JOIN transacao AS t where t.idContaOrigem = co.idConta and co.tipo = 'Corrente'
GROUP BY nome
ORDER BY SUM(t.valor) desc;
