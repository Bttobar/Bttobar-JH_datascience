# Merging data 

if(!file.exists("./data")){
        dir.create("./data")
}

download.file("https://raw.githubusercontent.com/Bttobar/courses/master/03_GettingData/03_05_mergingData/data/reviews.csv",
              destfile = "./data/reviews.csv",method="curl")
download.file("https://raw.githubusercontent.com/Bttobar/courses/master/03_GettingData/03_05_mergingData/data/solutions.csv",
              destfile = "./data/solutions.csv",method="curl")

reviews = read.csv("./data/reviews.csv"); reviews = read.csv("./data/solutions.csv")
head(reviews,2)