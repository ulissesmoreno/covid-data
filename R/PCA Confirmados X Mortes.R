pacotes <- c("plotly", #plataforma gráfica
             "tidyverse", #carregar outros pacotes do R
             "ggrepel", #geoms de texto e rótulo para 'ggplot2' que ajudam a
             #evitar sobreposição de textos
             "knitr", "kableExtra", #formatação de tabelas
             "reshape2", #função 'melt'
             "PerformanceAnalytics", #função 'chart.Correlation' para plotagem
             "psych", #elaboração da fatorial e estatísticas
             "ltm", #determinação do alpha de Cronbach pela função 'cronbach.alpha'
             "Hmisc", # matriz de correlações com p-valor
             "readxl") # importar arquivo Excel

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

df_covid_confirmados <- read.csv("dados_covid_confirmados.csv")
df_covid_mortes<- read.csv("dados_covid_mortes.csv")


df_completo <- merge(df_covid_confirmados,df_covid_mortes, by.x = c('Paises','Data'), by.y = c('Paises','Data'))

write.csv(df_completo,'Mortes x Confirmados.csv',row.names = FALSE)
str(df_completo)

summary(df_completo)

rho <- rcorr(as.matrix(df_completo[,3:4]), type="pearson")

corr_coef <- rho$r # Matriz de correlações
corr_sig <- round(rho$P, 5) # Matriz com p-valor dos coeficientes

# Teste de esfericidade de Bartlett
cortest.bartlett(df_completo[, 3:4])

fatorial <- principal(df_completo[, 3:4],
                      nfactors = length(df_completo[, 3:4]),
                      rotate = "none",
                      scores = TRUE)
fatorial

eigenvalues <- round(fatorial$values, 5)
eigenvalues
round(sum(eigenvalues), 2)
variancia_compartilhada <- as.data.frame(fatorial$Vaccounted) %>% 
  slice(1:3)
rownames(variancia_compartilhada) <- c("Autovalores",
                                       "Prop. da Variância",
                                       "Prop. da Variância Acumulada")

# Cálculo dos scores fatoriais
scores_fatoriais <- as.data.frame(fatorial$weights)
# Cálculo dos fatores propriamente ditos
fatores <- as.data.frame(fatorial$scores)

rho <- rcorr(as.matrix(fatores), type="pearson")
round(rho$r, 4)

k <- sum(eigenvalues > 1)
print(k)

fatorial2 <- principal(df_completo[, 3:4],
                       nfactors = k,
                       rotate = "none",
                       scores = TRUE)
fatorial2

comunalidades2 <- as.data.frame(unclass(fatorial2$communality)) %>%
  rename(comunalidades = 1)

