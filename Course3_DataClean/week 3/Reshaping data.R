# Reshaping data

# no siempre va a estar ordenada => 1 dejar buen formato. 
# data ordenada: 1) cada variable tiene su propia columna
# 2) Cada variable tiene su propia fila
# 3) Cada tabla/Archivo guarda data solo 1 tipo de observacion

install.packages("reshape")
library(reshape)
head(mtcars)

install.packages("reshape2") # may already be installed
library(reshape2)

# melt = fundir, derretir 
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars = c("mpg","hp"))
# measure variables las deja en 1 sola columna 
# ahora tenemos una tall skinny set 
head(carMelt)
tail(carMelt)

cylData <- dcast(carMelt, cyl ~ variable) 
# variables es hp o mpg 
# ejemplo: para 4 cilindros tenemos 11 medidas mpg y 11 hp 

cylData <- dcast(carMelt, cyl ~ variable, mean)
# sacamos el promedio de la medida hp o mpg por cilindro


#Averaging values 
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum) # tapply => apply along a index 
# apply to count along the index spray the function sum 

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount = lapply(spIns,sum)
sprCount

#another way to combine

unlist(sprCount) # volvemos a la lista antes del apply 
sapply(spIns,sum) # apply and combine 

library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN = sum))
spraySums
dim(spraySums)

# tutorial plyr => this is faster and efficient dplyr super package para el reshape  => work with dataframes 
# a lot of the keys of dplyr are code in C++
# acast 
# arrange => faster ordering 
# mutate => add new variables 

# select: return a subset of columns of a df 
# filter : extract subset of rows 
# arrange : reorder rows of df 
# rename
# mutate 
# summarise / summarize : summary statistics 
# the result is new dataframe 

















