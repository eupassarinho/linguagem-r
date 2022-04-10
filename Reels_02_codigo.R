# Suponha que você tem um data frame com uma série
# histórica de dados mensais. No nosso exemplo é
# a chuva mensal:

library(tibble)

df <- tibble(
  Ano = c(rep(2020, 12), rep(2021, 12)),
  Mes = rep(seq(1:12), 2),
  Chuva = c(rep(1, 10), c(NA,NA), rep(1, 12))
)

# Nele você quer excluir os dados de um ano em que
# há pelo menos um dado faltante. Uma solução é
# usar alguns recursos do dplyr...

library(dplyr)

ano_com_falha <-  df %>%
  # Aqui você agrupa as variáveis Ano e a Chuva se
  # houver NA na chuva:
  group_by(Ano, is.na(Chuva)) %>%
  # E com a função tally() o R conta as ocorrências
  # de NA na chuva e em que ano elas ocorrem,
  # retornando "TRUE" para a ocorrência:
  tally() %>% filter(`is.na(Chuva)` == "TRUE")

# Depois disso, use a identificação feita pelo :
df %>% filter(!Ano %in% ano_com_falha$Ano)
