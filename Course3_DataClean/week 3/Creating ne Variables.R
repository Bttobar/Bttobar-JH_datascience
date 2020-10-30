# Creating new variables 

# Para que crear nuevas variables: 
# valores que no estamos buscando en la data 
# usualmente hay que transformar la data para conseguir los datos que queremos. 
# usualmente agregar valores al dataframe 
# variables comunes para crear: indicador de missingness, aplicar transformaciones, crear variables factores de las cuantitativas

data <- read.csv("./data/restoran.csv")

s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length = 3); s2
x <- c(1,3,8,25,100); seq(along=x) # te crea indices para la cantidad de datos en x 

data$nearme = data$neighborhood %in% c("Roland Park", "Homeland")
table(data$nearme)
data$nearme

data$zipWrong = ifelse(data$zipCode < 0, T,F)
table(data$zipWrong,data$zipCode < 0)


data$zipGroups = cut(data$zipCode, breaks = quantile(data$zipCode))
table(data$zipGroups)
table(data$zipGroups,data$zipCode)
        
install.packages("Hmisc")
library(Hmisc)
data$zipGroups = cut2(data$zipCode,g=4) # Te separa en quantiles 
table(data$zipGroups)

data$zcf <- factor(data$zipCode)
data$zcf[1:10]

yesno <- sample(c("yes","no"), size= 10, replace = T)
yesnofac = factor(yesno, levels=c("yes","no"))
relevel(yesnofac, ref = "no") #ref es para cabiar el orden de los niveles. 

as.numeric(yesnofac)

library(Hmisc)
library(plyr)
data2 = mutate(data,zipGroups = cut2(zipCode, g=4)) 
# mutate es crea otro dataframe en el que se pueden cambiar o agregar variables 
table(data2$zipGroups)

# -abs(x)
# -sqrt(x)
# -ceiling(x) => redondear siempre al entero mas arriba 
# -floor(x)
# -round(x,digits=n)
# -signif(x,digits=n)
# -cos(x) sin(x)
# -log(x) log2(x) log10(X)
# -exp(x)











        
        