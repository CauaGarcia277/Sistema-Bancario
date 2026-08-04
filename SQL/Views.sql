#View que retorna o valor que cada usuario gastou no total
CREATE VIEW vw_valor_gasto AS 
SELECT c.idCliente AS id, c.nome_cliente AS nome_cliente, SUM(t.valor) AS valor FROM conta AS co
INNER JOIN Cliente as c ON c.idCliente = co.idCliente
INNER JOIN transacao as t ON t.idContaOrigem = co.idConta
GROUP BY c.idCliente, c.nome_cliente
ORDER BY valor DESC;

SELECT * FROM vw_valor_gasto;

##View que retorna o valor que cada usuario recebeu no total
CREATE VIEW vw_valor_recebido AS
SELECT c.idCliente AS id, c.nome_cliente AS nome_cliente, SUM(t.valor) AS valor FROM conta AS co
INNER JOIN Cliente AS c ON c.idCliente = co.idCLiente
INNER JOIN Transacao AS t ON t.idContaDestino = co.idConta
GROUP BY c.idCliente, c.nome_cliente
ORDER BY valor DESC;

##Utilizando Select filtrando a view
SELECT * FROM vw_valor_recebido
WHERE valor > 2000 AND valor < 5000;