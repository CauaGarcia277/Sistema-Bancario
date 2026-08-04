## Criando uma tabela para melhor vizualização
CREATE TABLE faturamento_diario(
Cliente VARCHAR(45),
Dia DATE,
faturamento_total DECIMAL(12,2)
);

##Criando um trigger que atualizará a tabela faturamento_diário depois de cada insert feito na tabela transação
##Onde irá deletar todos os registros e atualizará novamente.
DELIMITER //
CREATE TRIGGER faturamento_diario
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN

DELETE FROM faturamento_diario;

INSERT INTO faturamento_diario(cliente, dia, faturamento_total)
SELECT c.nome_cliente AS nome_cliente, t.data_realizada AS Dia, SUM(t.valor) AS valor_total FROM conta AS co
INNER JOIN transacao AS t ON t.idContaOrigem = co.idConta
INNER JOIN cliente AS c ON c.idCLiente = co.idCliente
GROUP BY c.nome_cliente, t.data_realizada
ORDER BY valor_total DESC;

END //
DELIMITER ;

##Teste
INSERT INTO Transacao (idContaOrigem,idContaDestino,idCategoria,valor,data_realizada)
VALUES (1,3,1,1200.00,'2026-05-20');

SELECT * FROM faturamento_diario;



##Trigger que irá atualizar a conta após um insert na tabela de transação,
##subtraindo da conta de origem e somando na conta de destino

DELIMITER //
CREATE TRIGGER movimentacao_conta
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN

UPDATE conta 
SET saldo = saldo + NEW.valor
WHERE idconta = NEW.idContaDestino;

UPDATE conta
SET saldo = saldo - NEW.valor
WHERE idconta = NEW.idContaOrigem;

END//
DELIMITER ;

##Teste
INSERT INTO Transacao (idContaOrigem,idContaDestino,idCategoria,valor,data_realizada)
VALUES(1,2,1,200.00,'2026-07-02');

##Melhor vizualizacao
SELECT co.idConta AS idConta, c.nome_cliente as nome_cliente, co.saldo AS saldo FROM conta AS co
INNER JOIN cliente AS c ON c.idCliente = co.idCliente;



