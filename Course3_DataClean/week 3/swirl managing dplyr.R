# swirl course : Manipulating data with dplyr

mydf <- read.csv(path2csv,stringsAsFactors = FALSE)
dim(mydf)
head(mydf)

library(dplyr)
packageVersion("dplyr")

cran <- tbl_df(mydf) #create a dataframe
rm("mydf") #para remover el df
print(cran) # mucho mas informatifo que df solo

# "Introduction to dplyr" vignette written by the package authors, "The dplyr philosophy is to have small
# | functions that each do one thing well." Specifically, dplyr supplies five 'verbs' that cover most fundamental data
# | manipulation tasks: select(), filter(), arrange(), mutate(), and summarize().

# con el select() n tenemos que estar escribiendo data$clase + se muestra por pantalla en el orden en que las pusimos.

select(cran, r_arch:country)
select(cran, country:r_arch)
select(cran, -time)

-5:20
-(5:20)

select(cran, -(X:size))
filter(cran,package=="swirl")
filter(cran, r_version == "3.1.1", country == "US")

filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, country == "US" | country == "IN")
filter(cran, size>100500, r_os == "linux-gnu")


is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))

filter(cran,!is.na(r_version) )

#order rows ==> arrange

cran2 <- select(cran,size:ip_id)
arrange(cran2,ip_id)
arrange(cran2,desc(ip_id))
arrange(cran2, package, ip_id) # si hay multiples rows iguales, el siguiente filtro es ip_id
arrange(cran2,country,desc(r_version),ip_id)

cran3 <- select(cran,ip_id,package,size)

# It's common to create a new variable based on the value of one or more variables already in a dataset. The mutate()
# | function does exactly this.
mutate(cran3,size_mb = size /2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3,correct_size = size + 1000)


summarize(cran, avg_bytes = mean(size))

