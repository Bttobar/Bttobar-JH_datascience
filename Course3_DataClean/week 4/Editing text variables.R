# Editing text variables 
if(!file.exists("./data")){dir.create("./data")}
fileUrl<- "https://raw.githubusercontent.com/Bttobar/courses/master/03_GettingData/04_01_editingTextVariables/data/cameras.csv"
download.file(fileUrl,destfile = "./data/cameras.csv",method = "curl")

cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))

splitNames = strsplit(names(cameraData),"\\.") # es para separar los nombres con puntos en medio
splitNames[[5]]

myList <- list(letters=c("A","b","c"), numbers =1:3, matrix(1:25,ncol = 5))
head(myList)

myList[1]
myList$letters
myList[[1]]

splitNames[[6]][1]
firstElement<- function(x){
        x[1]
}
sapply(splitNames,firstElement) # sapply => X[[i]]

reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

head(reviews,2)
head(solutions,2)

names(reviews)
names(solutions)


sub("_","",names(reviews),)
sub("_","",names(solutions),)

textName <- "this_is_a_test"
sub("_","",textName)
gsub("_","",textName)

grep("Alameda",cameraData$intersection) # searching for specifics values 
table(grepl("Alameda",cameraData$intersection)) 
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]


grep("Alameda",cameraData$intersection, value = TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))


library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Lake")

paste0("Jeffrey","Leek")
str_trim("Jeff    ")


# Metcharacters

# ^i this start
# morning$ finish
# [Bb][Uu][SS][Hh] => bush or BuSH OR BUSH All version of the word Bush 
# ^[Ii] am => i am or I am 
# ^[0-9][a-zA-Z] => numero del 1 al 9 seguido de cualquier letra
# [^?.]$ => end of line cualquiera que termine diferente que ? o . 
# "." => refer to any character => 9.11 => 9/11 OR 9_11 ...
# flood|fire => flood or fire math in any phrase
# flood|earthquake|fire|..
# ^[Gg]ood|^[Bb]ad => al comienzo de la linea good or Good or Bad or bad => bad no esta al comienzo 
# ^([Gg]ood|^[Bb]ad) 
# [Gg]eorge( [Ww]\.)? [Bb]ush "\." = .   busca por george bush or george w. bush 
# (.*) => cuaqueir parentesis 
# [0-9] + (.*)[0-9]+ => al menos 1 numero luego cualquier cantidad de palabras y luego otro numero-
# [Bb]ush( +[^]++){1,5} debate => entre 1 a 5 palabras entre bush y debate 
# m,n al menos m pero max n 
# m => exactly m matches 
# m, => al menos m matches 
# +([a-zA-Z]+)+\1+ => ESPACIO + PALABRA + ESAPACIO + REPETICION 
# ^s(.*)s => encuentra la cadena que parte con s y termina con s ( la mas larga)
# ^s(.*?)s?
















