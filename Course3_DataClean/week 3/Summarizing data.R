# Summarizing data 

if(!file.exists("./data")){
        dir.create("./data")
}
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url,destfile = "./data/restoran.csv",method="curl")
data <- read.csv("./data/restoran.csv")

head(data, n = 3) # n = 3, que me muestre las primeras 3 
tail(data, n = 3)

summary(data)
str(data)

quantile(data$councilDistrict,na.rm = T)
quantile(data$councilDistrict,probs = c(0.5,0.7,0.86,0.9))

table(data$zipCode, useNA = "ifany") # ifany es para contar la cantidad de missing values 
table(data$councilDistrict,data$zipCode) # obs: por ejemplo el distrito 1 tiene 140 restoranes en el zip 21224

#contar missing values 
sum(is.na(data$councilDistrict))
any(is.na(data$councilDistrict))
all(data$councilDistrict > 0)

colSums(is.na(data)) # is.na (retorna el set con valores logicos TRUE FALSE dependiendo si es o no Na)
all(colSums(is.na(data))==0)

table(data$zipCode %in% c("21212")) # encontrar todas los zipcode que son iguales a 21212
table(data$zipCode == c("21212"))
table(data$zipCode %in% c("21212","21213")) 

data[data$zipCode %in% c("21212","21213"),]

data(UCBAdmissions) # es como un library pero de data 
df = as.data.frame(UCBAdmissions)
summary(df)
xt <- xtabs(Freq ~ Gender + Admit, data=df) 
# el primer valor es aquel que queremos mostrar en la tabla y lo quiero mostrar descompuesto en gender y admit. 
print(xt)

xt1 <- xtabs(Freq ~ Gender + Admit + Dept, data=df) 
xt1

warpbreaks$replicate <- rep(1:9,len=54) # repeticion 1:9 => 54 veces 
xt = xtabs(breaks ~.,data= warpbreaks) # breaks ~. => todas las variables 
print(xt)

ftable(xt) # compacta las multiples tablas mostradas con el anterior codigo. 
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")






