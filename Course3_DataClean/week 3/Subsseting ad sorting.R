# Subsetting and sorting

set.seed(13435)
data <- data.frame("var1" = sample(1:5),"var2" = sample(6:10),"var3" = sample(11:15))
print(data)
data <- data[sample(1:5),]; data$var2[c(1,3)] = NA
print(data)

#formas de subset
data[,1]
data[,"var2"]
data[1:2,"var2"]
# con logical statement
# quiero buscar todas las filas de la data donde V3 < O IGUAL A 3 y v3 mayor a 11
data[(data$var1 <= 3 & data$var3 > 11),] 
data[(data$var1 <= 3 | data$var3 > 15),]

data[which(data$var2>6),] # no retorna los NA ! 

sort(data$var1)
sort(data$var1, decreasing = T)
sort(data$var2,na.last = T) # TODOS LOS NA AL FINAL DE LA FILA 

# Ordenar la data a partir de un valor en particular. 

data[order(data$var2),]
data[order(data$var1),]
data[order(data$var1, data$var2),] 
# primero ordena segun var1 luego si hay multiples valores iguales, se ordena segun var2

install.packages("plyr")
library(plyr)

arrange(data,var1) # lo mismo que el order()
arrange(data,desc(var1)) # order en decreasing order.

# agregar data al conjunto. 
data$var4 <- rnorm(5)
print(data)

y <- cbind(data,rnorm(5)) 
# cbind para juntar columnas, rbind para juntar filas.
# si se ponde el rnorm antes del data, se pegara la data en el lado izquierdo del dataset.
print(y)












