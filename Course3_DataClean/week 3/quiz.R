# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products. Assign that logical 
# vector to the variable agricultureLogical. Apply the which() function like this 
# to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# 
# What are the first 3 values that result?

data <- read.csv("quiz.csv")

library(dplyr)
cran <- tbl_df(data)

# acres => ACR 
# Agriculture products sale = AGS 

cran1 <- select(cran,SERIALNO,ACR,AGS)
res <- cran1[which( cran1$ACR > 2 & cran1$AGS > 5),]
which( cran1$ACR > 2 & cran1$AGS > 5) # te da los numeros de las filas que son verdaderas 
arrange(res,SERIALNO)
which(res)


# Ejercicio 2 
library(jpeg)
data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "./data/photo.jpg", method = "curl")
data <- readJPEG("./data/photo.jpg",native=TRUE)
quantile(data,c(0.3,0.8))

# Ejercicio 3

if (!file.exists("./data/")){
        dir.create("./data/")
}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./data/pib.csv", method="curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./data/country.csv", method="curl")


#data

pib_data <- read.csv("./data/pib.csv",skip = 3)
country_data <- read.csv("./data/country.csv")

# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in 
# descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

library(dplyr)
library(plyr)
library(tidyr)

# tablas df 
country_data <- tbl_df(country_data)
pib_data <-tbl_df(pib_data)

pib_clean <-  pib_data %>% 
        select(1,2,4,5) %>%
        dplyr::rename(CountryCode = X) %>% 
        filter(!Ranking=="") %>%
        print

pib_clean <- pib_clean[-which(pib_clean[,1:4]==""),] # se eliminan 317-228 filas 
# pib_clean1 <- na.omit(pib_clean)

df1 <- merge(pib_clean,country_data, by.x = "CountryCode",by.y = "CountryCode",all = F )
df1 <- tbl_df(df1)
names(df1)


df2 <- df1 %>%
        select(CountryCode:Long.Name,Income.Group) %>%
        mutate(Ranking = as.integer(df1$Ranking)) %>%
        arrange(desc(Ranking)) %>%
        print
print(df2[13,])

# join_data <- plyr::join(pib_clean1,country_data, "CountryCode")
# join_data <- tbl_df(join_data) 

#sq <- "select * from pib_clean1, country_data where pib_clean.CountryCode = country_data.CountryCode"
#which(pib_clean1$CountryCode == country_data$CountryCode)

#df2[which(df2$Economy == "Chile"),]

# Ejercicio 4: 

df2 %>% group_by(Income.Group) %>%
        dplyr::summarise(mean_rating = mean(Ranking)) %>%
        print

df3 <- df2 %>%
        filter( Income.Group == Income.Group[grep("OECD",Income.Group)]) %>% # esto me da los OECD Y nonOECD
        print

# Ejercicio 5

df4 <- df2 %>% mutate(quantile = cut(Ranking,breaks = 5, labels = c(1,2,3,4,5)) ) %>%
        print
table <- table(df4$Income.Group == "Lower middle income" ,df4$quantile)
unique(df2$Income.Group)
print(table)

# quantile(df2$Ranking,na.rm=T)


