# Merging data = unir data 

if(!file.exists("./data")){
        dir.create("./data")
}

download.file("https://raw.githubusercontent.com/Bttobar/courses/master/03_GettingData/03_05_mergingData/data/reviews.csv",
              destfile = "./data/reviews.csv",method="curl")
download.file("https://raw.githubusercontent.com/Bttobar/courses/master/03_GettingData/03_05_mergingData/data/solutions.csv",
              destfile = "./data/solutions.csv",method="curl")

reviews = read.csv("./data/reviews.csv"); solutions = read.csv("./data/solutions.csv")
head(reviews,2)

names(reviews)
names(solutions)

mergedData <- merge(reviews,solutions,by.x="solution_id",by.y="id",all = T)
head(mergedData)

intersect(names(solutions),names(reviews)) # default merge all common column names
mergedData2 = merge(reviews,solutions,all=T) 
# es para que en el caso que haya datos que no sean iguales en el merge, igual se anoten como NA.
head(mergedData2)

library(plyr)
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList) # merge all the diff database on the basis of the common variables, in this case the id.







