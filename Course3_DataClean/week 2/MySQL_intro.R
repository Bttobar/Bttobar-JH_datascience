require("odbc")

# Conexion a la base de datos en el driver MYSQL 

con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "[your driver's name]",
                      Server   = "[your server's path]",
                      UID      = rstudioapi::askForPassword("Database user"),
                      PWD      = rstudioapi::askForPassword("Database password"),
                      Port     = 3306)

# Conexion a base de datos tipo MariaDB
# install.packages("RMariaDB")
library(DBI)
# Connect to my-db as defined in ~/.my.cnf
con <- dbConnect(RMariaDB::MariaDB(), group = "my-db")

# IMPORTANTE, DESDE AQUI PARTE EL CURSO.
# Para manejar gran parte de las bases de datos en R se tiene que instalar el package "RMySQL"
install.packages("RMySQL")
require("RMySQL")

# Ingresamos y obtenemos la base de datos de la pagina. 
ucscDB <- dbConnect(MySQL(),user = "genome",host = "genome-mysql.cse.ucsc.edu")
# tipo => Formal class 'MySQLConnection' [package "RMySQL"] with 1 slot ..@ Id: int [1:2] 0 0
result <- dbGetQuery(ucscDB,"show databases;"); dbDisconnect(ucscDB)
# siempre acordarse de desconectarse de la base de datos. 

#Ahora que ya sabemos las bases de datos dentro del repositorio de UCSC nos fijaremos en una de estas db

hg16 <- dbConnect(MySQL(),user = "genome", db = "hg16", host = "genome-mysql.cse.ucsc.edu")

allTables <- dbListTables(hg16)
length(allTables)

allTables[1:5]
# cada tabla corresponde a un tipo de entidad, por lo que cada tabla representa un conjunto de datos en particular.
# para mostrar los atributos de la tabla usamos lo siguiente:

dbListFields(hg16,"HInv") # En este casa la tabla tiene solo 3 propiedades. 

dbGetQuery(hg16,"select count(*) from ECgene") # cuantas filas contiene el registro de la tabla. 


HInvData <- dbReadTable(hg16,"HInv")
head(HInvData) # como extraer data de la base de datos HInv y importarla a un dataframe. 
# este tipo de extracción funciona bien cuando la cantidad de data extraida no es tan larga 
# para casos máximos donde la data extraida es extensa, conviene extraer en pequeñas porciones:
dbDisconnect(hg16)

# dbGetQuery() always returns a data.frame with as many rows as records were fetched and as many columns as fields in the result set, even if the result is a single value or has one or zero rows. 

hg19 <- dbConnect(MySQL(),host = "genome-mysql.cse.ucsc.edu", user = "genome", db = "hg19")
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)

# con el send command todavia no se extrae la data, se debe hacer el fetch para importarla al ordenador. 
# si queremos importar una pequeña parte de la data hacemos lo siguiente: donde n = numero de filas
affyMisSmall <- fetch(query,n=10); dbClearResult(query)
dim(affyMisSmall)

dbDisconnect(hg19)

# The function dbSendQuery only submits and synchronously executes the SQL query to the database engine. 
# It does not extract any records --- for that you need to use the function dbFetch, and then you must 
# call dbClearResult when you finish fetching the records you need. For interactive use, you should almost 
# always prefer dbGetQuery. 

# dbGetQuery comes with a default implementation that calls dbSendQuery, 
# then dbFetch, ensuring that the result is always free-d by dbClearResult

#QUIZ PART

install.packages("sqldf")
# The sqldf package allows for execution of SQL commands on R data frames.

acs <- read.csv("getdata_data_ss06pid.csv")
sqldf::sqldf("select pwgtp1 from acs where AGEP<50")
sqldf::sqldf("select distinct AGEP from acs")
sqldf::sqldf("select unique AGEP from acs") # erro sintax, unique no existe => distinct es lo correct7o 


