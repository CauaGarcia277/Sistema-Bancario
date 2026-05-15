import pandas as pd
import matplotlib.pyplot as plt
url = r'C:\\Users\\garci\\OneDrive\\Desktop\\Sistema Banco\\Dados_CSV\\transacoes.csv'
df = pd.read_csv(url, sep = ',')

##Retornando a média de gastos por cada conta de origem
media_c_origem = df.groupby('idContaOrigem')['valor'].mean(numeric_only = True)
#print(media_conta)

##Melhorando a vizualização transformando em um DataFrame com colchetes duplos no campo valor
##Utilizando sort_value para ordenar em ordem crescente a media
media_c_origem = df.groupby('idContaOrigem')[['valor']].mean(numeric_only = True).sort_values('valor')
print(media_c_origem)

##Quantidade de transações por conta origem
quantidade = df.groupby('idContaOrigem')[['valor']].count()


##Filtrando por valor de transacoes maior ou igual a 1000
dados = df.query('valor >= 1000')

##Contabilizando quantas transacoes maiores ou iguais a 1000 por cada conta de origem e ordenando do menor
##ao maior
transacao_maior_mil = dados.idContaOrigem.value_counts().sort_values()
print(transacao_maior_mil)

##Retornando uma conta específica que contenha o valor maior que mil
print(dados.query('idContaOrigem == 2'))


##Retornando os valores em formato percentual de cada conta origem, do qual gastou mais para o que gastou
##menos
df = df.idContaOrigem.value_counts(normalize = True).to_frame()
print(df)

##Buscando a porcentagem direto pelo id de conta
print(df.query('idContaOrigem == 2'))



##Criando uma tabela para a quantidade de transacoes feitas por conta
quantidade.plot(kind='bar')
plt.title('Média de gastos por conta')
plt.ylabel('Valor')
plt.show()
