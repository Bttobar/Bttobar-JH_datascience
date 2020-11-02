

data <- read.csv("./data/surveyCom.csv")


wgtp_data <- names(data)[grep("wgtp",names(data))]
strsplit(wgtp_data,"wgtp")

strsplit(names(data),"wgtp")[123]

# Ej 2

url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,destfile = "./data/pib.csv", method = "curl")
data <- read.csv("./data/pib.csv",skip=3)

head(data)
data$US.dollars. <- as.numeric(as.character(gsub(",","",data$US.dollars.)) )
mean(data$US.dollars.,na.rm = TRUE)
sum(data$US.dollars.,na.rm = TRUE)
head(data)

library(dplyr)
df <- tbl_df(data)
head(df)
df1 <- select(data,X,Economy,US.dollars.)
df2 <- df1[-which(df1[,1:3]=="" | df1[,1:ncol(df1)]==NA),]
# para eliminar filas que tengan algunos NA usar completecase
df2 <- df2[complete.cases(df2),]
mean(df2$US.dollars.[1:190])

grep("^United",df2$Economy)


# Ejercicio 4

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile = "./data/educ.csv",method = "curl")
educ_data <- read.csv("./data/educ.csv")
pib_data <- read.csv("./data/pib.csv",skip=3)

head(educ_data)
head(pib_data)

names(educ_data)

df_pib <- tbl_df(pib_data)
df_pib <- df_pib %>%
        select(X,Ranking,Economy,US.dollars.) %>%
        rename(CountryCode = X) %>%
        filter(!df_pib[,1:4]== "") %>% 
        print

View(tail(df_pib,30))

df_educ <- tbl_df(educ_data)
df_educ <- df_educ %>% 
        select(CountryCode,Special.Notes) %>%
        filter(!Special.Notes == "") %>%
        print

merge_data <- merge(df_educ,df_pib,by = "CountryCode")
head(merge_data)
nrow(merge_data[grep("^Fiscal year end: June", merge_data$Special.Notes),])

merge_data$Economy

# Ejercicio 5 

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

head(amzn)
head(sampleTimes)

class(sampleTimes)
length(sampleTimes)

df_date <- tbl_df(sampleTimes)
df_date <- rename(df_date,Date = names(df_date)[1])
df_date

date_tbl <- table(wday(sampleTimes,week_start = 1),year(sampleTimes))
date_tbl
sum(date_tbl[,"2012"])



















