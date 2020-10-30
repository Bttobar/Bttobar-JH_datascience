#  2: Grouping and Chaining with dplyr

library(swirl)
library(dplyr)


cran <- tbl_df(mydf)
rm("mydf")
# groupby()
by_package <- group_by(cran,package)
by_ros <- groupby(cran,r_os)

summarize(by_package,mean(size)) # retorna varios valores,  segun los packages 
summarize(cran,mean(size)) # retorna solo 1 valor, junta todos los packages. 

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
# length(unique(x)) == n_distinct => give the total number of unique downloads for each package
# also for (n_distinct(country)) give the number of unique countries that dowload the package.
# the mean(size) => mean size for each package. 
# n() gives the current group size => count the total number of rows for each package.
# 
# Naturally, we'd like to know which packages were most popular on the day these data were collected (July 8, 2014). Let's
# start by isolating the top 1% of packages, based on the total number of downloads as measured by the 'count' column.
# 
# We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages based on total
# downloads. In statistics, this is called the 0.99, or 99%, sample quantile. Use quantile(pack_sum$count, probs = 0.99) to
# determine this number.
q99 = quantile(pack_sum$count,probs = 0.99) # el 99% de los packages ha sido descargado hasta 680 veces
q100 = quantile(pack_sum$count,probs = 1)
q100-q99

top_counts <- filter(pack_sum,count > 679)
View(top_counts) # para ver toda la tabla
top_counts_sorted <- arrange(top_counts,desc(count))
View(top_counts_sorted)

quantile(pack_sum$unique,probs=0.99)
top_unique <- filter(pack_sum,unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique,desc(unique))
View(top_unique_sorted)


cran %>%
        select(ip_id, country, package, size) %>%
        mutate()
cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        # Your call to arrange() goes here
        arrange(desc(size_mb))


