#libraries

library(dplyr)
library(tidyverse)
library(reshape2)


#Importação do CSV

#recuperados
covid_recuperados <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv", header=TRUE)

#Converter em Data Frame
df_covid_recuperados <- data.frame(covid_recuperados)

#Converte as colunas de datas (menos as 4 primeiras) em linhas
df_covid_recuperados <- melt(df_covid_recuperados,id.vars = cbind(1:4))

#removo colunas não utilizadas
to.remove <- c('Province.State', 'Lat','Long') 
df_covid_recuperados <- df_covid_recuperados[, !colnames(df_covid_recuperados) %in% to.remove] 

#Renomeio as colunas
names(df_covid_recuperados) <- c('Paises','Data','Recuperados')

#removo X da coluna data
df_covid_recuperados$Data <- gsub("X","", as.character(df_covid_recuperados$Data))


#df_covid_recuperados %<>%  mutate(Data=as.Date(Data,format='%m.%d.%Y'))

str(df_covid_recuperados)
summary(df_covid_recuperados)


#Confirmados
covid_confirmados <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv", header=TRUE)

#Converter em Data Frame
df_covid_confirmados <- data.frame(covid_confirmados)

#Converte as colunas de datas (menos as 4 primeiras) em linhas
df_covid_confirmados <- melt(df_covid_confirmados,id.vars = cbind(1:4))

#removo colunas não utilizadas
to.remove <- c('Province.State', 'Lat','Long') 
df_covid_confirmados <- df_covid_confirmados[, !colnames(df_covid_confirmados) %in% to.remove] 

#Renomeio as colunas
names(df_covid_confirmados) <- c('Paises','Data','Confirmados')

#removo X da coluna data
df_covid_confirmados$Data <- gsub("X","", as.character(df_covid_confirmados$Data))


#df_covid_confirmados %<>%   mutate(Data=as.Date(Data,format='%m.%d.%Y'))

str(df_covid_confirmados)
summary(df_covid_confirmados)

#mortes
covid_mortes <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", header=TRUE)

#Converter em Data Frame
df_covid_mortes <- data.frame(covid_mortes)

#Converte as colunas de datas (menos as 4 primeiras) em linhas
df_covid_mortes <- melt(df_covid_mortes,id.vars = cbind(1:4))

#removo colunas não utilizadas
to.remove <- c('Province.State', 'Lat','Long') 
df_covid_mortes <- df_covid_mortes[, !colnames(df_covid_mortes) %in% to.remove] 

#Renomeio as colunas
names(df_covid_mortes) <- c('Paises','Data','Mortes')

#removo X da coluna data
df_covid_mortes$Data <- gsub("X","", as.character(df_covid_mortes$Data))


#df_covid_mortes %<>%  mutate(Data=as.Date(Data,format='%m.%d.%Y'))

str(df_covid_mortes)
summary(df_covid_mortes)

#Vacinação
covid_vacinas <- read.csv('https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/global_data/time_series_covid19_vaccine_global.csv', header=TRUE)
codigo_paises <- read.csv('https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv',header=TRUE)

#Gerar CSV
write.csv(df_covid_confirmados,"dados_covid_confirmados.csv",row.names = FALSE)
write.csv(df_covid_recuperados,"dados_covid_recuperados.csv",row.names = FALSE)
write.csv(df_covid_mortes,"dados_covid_mortes.csv",row.names = FALSE)
write.csv(covid_vacinas,"vacinacao.csv",row.names=FALSE)
write.csv(codigo_paises,'dCodigoPaises.csv',row.names=FALSE)
