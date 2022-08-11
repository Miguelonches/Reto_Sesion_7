library(DBI)
library(RMySQL)
library(dplyr)
install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
# Una vez que se tengan las librerias necesarias se procede a la lectura 
# (podr? ser que necesites otras, si te las solicita instalalas y cargalas). 
# De la base de datos de Shiny, la cual es un demo y nos permite interactuar con 
# este tipo de objetos. El comando dbConnect es el indicado para realizar la 
# lectura, los dem?s par?metros son los que nos dan acceso a la BDD.

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Si no se arrojaron errores por parte de R, vamos a explorar la BDD

dbListTables(MyDataBase)

# Desplegar los campos o variables que contiene la tabla 
# City

dbListFields(MyDataBase, 'CountryLanguage')

# Consulta tipo MySQL

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

head(DataDB)



l.spanish <-  DataDB %>% filter(Language == "Spanish") 
class(l.spanish)
SP.df <- as.data.frame(l.spanish) 


SP.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()







