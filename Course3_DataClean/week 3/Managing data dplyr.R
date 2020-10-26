# dplyr package 

library(dplyr)

options(width = 105)

#select function 
data <- readRDS("./data/chicago.rds")
head(data)
tail(data)
dim(data)
str(data)
names(data)

head(select(data, city:dptp))
head(select(data,-(dptp:o3tmean2)))

# Para hacer lo mismo sin el package dplyr hacemos esto: 
i <- match("city",names(data)) #te entrega el indice de la columna 
j <- match("dptp",names(data))
head(data[,-(i:j)])

chic.f <- filter(data,pm25tmean2 > 30) # subset a partir de una condicion 
chic.f <- filter(data,pm25tmean2 > 30 & tmpd > 80) # se puede tener varias condiciones 
data["tmpd">80 & "pm2data5tmean2" > 30] # a este habria que quitarle los NA 

# SIMILAR AL ORDER ESTA EL ARRANGE 
data <- arrange(data, date)
data <- arrange(data, desc(date))

# rename function 
data <- rename(data, pm25 = pm25tmean2, dewpoint = dptp)

# mutate function

data <- mutate(data,pm25detrend = pm25-mean(pm25,na.rm = T))
head(select(data,pm25,pm25detrend))

# group by => split according a certain categorical variables 
data <- mutate(data, tempcat = factor(1*(tmpd>80),labels = c("cold","hot")))
hotcold <- group_by(data,tempcat)
summarize(hotcold,pm25 = mean(pm25, na.rm = T),o3 = max(o3tmean2),no2 = median(no2tmean2))


data <- mutate(data,year=as.POSIXlt(date)$year + 1900)
years <- group_by(data,year)
summarise(years,pm25=mean(pm25,na.rm = T),o3= max(o3tmean2),no2=median(no2tmean2))

head(data)
head(years)

# %>% con este operador se pueden ejecutar multiples funciones a la vez, usando el mismo df o variables 
# las siguientes funciones no necesitan como argumento las variables o df entregadas al comienzo de esta secuencia

# aparte del dplyr tenemos el datatable que esta hecho para tablas largas y rapidas
# y sql => dbi package. 


