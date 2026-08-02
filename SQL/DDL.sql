CREATE DATABASE IF NOT EXISTS SistemaBanco;
USE SistemaBanco;
DROP DATABASE SistemaBanco;

CREATE TABLE Cliente(
idCliente INT AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
CPF CHAR(11) NOT NULL UNIQUE,
data_nascimento DATE NOT NULL,
CEP CHAR(8) NOT NULL,
senha INT(10) NOT NULL,

CONSTRAINT pk_cliente PRIMARY KEY (idCliente)
);

CREATE TABLE Cartao(
idCartao INT AUTO_INCREMENT,
numero INT NOT NULL,
tipo VARCHAR(45) NOT NULL,
limite DECIMAL (12,2) NOT NULL,
validade DATE NOT NULL,
status_cartao TINYINT NOT NULL,

CONSTRAINT pk_cartao PRIMARY KEY (idCartao)
);

CREATE TABLE Conta (
idConta INT AUTO_INCREMENT,
idCliente INT NOT NULL,
idCartao INT NOT NULL,
saldo DECIMAL(12,2),
tipo VARCHAR(50) NOT NULL,
data_abertura DATE NOT NULL,
status_conta TINYINT NOT NULL,

CONSTRAINT pk_conta PRIMARY KEY(idConta, idCliente),
CONSTRAINT fk_conta_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
CONSTRAINT fk_conta_cartao FOREIGN KEY (idcartao) REFERENCES Cartao(idCartao)

);

CREATE TABLE Agencia(
idAgencia INT AUTO_INCREMENT,
idConta INT NOT NULL,
numero INT NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado VARCHAR(50) NOT NULL,

CONSTRAINT pk_agencia PRIMARY KEY (idAgencia),
CONSTRAINT fk_agencia_conta FOREIGN KEY (idConta) REFERENCES Conta(idConta) ON DELETE CASCADE ON UPDATE CASCADE


);

CREATE TABLE Chave_pix (
idChave INT AUTO_INCREMENT,
idConta INT NOT NULL,
tipo VARCHAR(45) NOT NULL,
valor DECIMAL(12,2),

CONSTRAINT pk_chave_pix PRIMARY KEY (idChave),
CONSTRAINT fk_pix_conta FOREIGN KEY (idConta) REFERENCES Conta(idConta) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE TABLE Fatura(
idFatura INT AUTO_INCREMENT,
idCartao INT NOT NULL,
valor_total DECIMAL(12,2) NOT NULL,
vencimento DATE NOT NULL,
status_fatura VARCHAR(45) NOT NULL,

CONSTRAINT pk_fatura PRIMARY KEY (idFatura),
CONSTRAINT fk_fatura_cartao FOREIGN KEY (idCartao) REFERENCES Cartao(idCartao) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Categoria_transacao(
idCategoria INT AUTO_INCREMENT,
tipo VARCHAR(45),

CONSTRAINT pk_categoria_transacao PRIMARY KEY (idCategoria)
);

CREATE TABLE Transacao(
idTransacao INT AUTO_INCREMENT,
idContaOrigem INT NOT NULL,
idContaDestino INT NOT NULL,
idCategoria INT NOT NULL,
valor DECIMAL(12,2) NOT NULL,
data_realizada DATE NOT NULL,

CONSTRAINT pk_transacao PRIMARY KEY (idTransacao),
CONSTRAINT fk_transacao_contaorigem FOREIGN KEY (idcontaorigem) REFERENCES Conta(idConta) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_transacao_contadestino FOREIGN KEY (idContaDestino) REFERENCES Conta(idConta) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_transacao_idcategoria FOREIGN KEY (idcategoria) REFERENCES Categoria_transacao(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Investimento (
idInvestimento INT AUTO_INCREMENT,
idCliente INT NOT NULL,
valor NUMERIC(12,2) NOT NULL,
tipo VARCHAR(50) NOT NULL,
rendimento NUMERIC(10,2) NOT NULL,
valor_CDI NUMERIC(5,2) NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,


CONSTRAINT pk_investimento PRIMARY KEY (idInvestimento, idCliente),
CONSTRAINT fk_investimento_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE ON UPDATE CASCADE
);






ALTER TABLE Cliente CHANGE nome nome_cliente VARCHAR(50) NOT NULL;