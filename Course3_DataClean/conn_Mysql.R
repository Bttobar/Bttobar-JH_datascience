install.packages("odbc"); require("odbc")
con <- dbConnect(odbc::odbc(), .connection_string = "Driver={MySQL ODBC 8.0 Unicode Driver};",
                 Server = "localhost", Database = "data", UID = "root", PWD= "polo12",
                 Port = 3306)
install.packages("quantmod")
require("quantmod")

ticker = "AAPL"
stock = getSymbols(ticker,auto.assign = FALSE)

idx = as.data.frame(index(stock))
stock = as.data.frame(cbind(idx,coredata(stock)))
colnames(stock) = c("Date","Open","High","Low","Close","Volume","Adjusted")
stock$Symbol = ticker

TYPES = list(Date = "date", Open = "double(10,2)",High = "double(10,2)",Low = "double(10,2)",
             Close = "double(10,2)",Volume = "Int(25)",Adjusted = "double(10,2)",Symbol = "varchar(5)")

system.time(dbWriteTable(con,name = "STK",value = stock, field.types = TYPES, row.names=FALSE))
# SE DEMORO 0,96 segundos en pasar la data al database. 



ticker = "AMZN"
stock = getSymbols(ticker,auto.assign = FALSE)

idx = as.data.frame(index(stock))
stock = as.data.frame(cbind(idx,coredata(stock)))
colnames(stock) = c("Date","Open","High","Low","Close","Volume","Adjusted")
stock$Symbol = ticker

TYPES = list(Date = "date", Open = "double(10,2)",High = "double(10,2)",Low = "double(10,2)",
             Close = "double(10,2)",Volume = "Int(25)",Adjusted = "double(10,2)",Symbol = "varchar(5)")

system.time(dbWriteTable(con,name = "tmp",value = stock, field.types = TYPES, row.names=FALSE))


dbSendQuery(con,"insert into stk select * from tmp")
dbSendQuery(con,"drop table tmp")
dbDisconnect(con)

# salvamos la conexion a la base de datos en library(DBI) 
# para buscar por tipo de empresa y no demorar mucho la busqueda, se crea un index para buscar especificamente 
# en el rango que tenga el simbolo deseado. 