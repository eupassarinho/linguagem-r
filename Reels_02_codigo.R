# Let's say that you have a data frame object which contains a time series,
# in month scale. In this example, the variable of the time series is the
# rainfall:

library(tibble)

df <- tibble(
  Ano = c(rep(2020, 12), rep(2021, 12)),
  Mes = rep(seq(1:12), 2),
  Chuva = c(rep(1, 10), c(NA,NA), rep(1, 12))
)

# In it, you want to exclude all data (or rows) of a year in which there is
# at least one missing data. A possible soluction is to use some dplyr resources...

library(dplyr)

ano_com_falha <-  df %>%
  # Here you're groupping the vars Ano (year) and Chuva (rainfall)
  # if there is any NA value in Chuva:
  group_by(Ano, is.na(Chuva)) %>%
  # And with the tally() function, R is going to count all NA occurrencies
  # in Chuva, and the year that it occurs, returning "TRUE" for any occorrence:
  tally() %>% filter(`is.na(Chuva)` == "TRUE")

# After all, use the identification made by the object "ano_com_falha"
# to exclude a entire year which contains one or more NA values:
df %>% filter(!Ano %in% ano_com_falha$Ano)
