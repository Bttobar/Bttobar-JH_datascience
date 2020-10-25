# Leer data desde la web => WebScraping

#Webscraping: programatically extracting data from the HTML code.

con = url("https://www.portalinmobiliario.com/venta/casa/concon-valparaiso?gclid=Cj0KCQjw8rT8BRCbARIsALWiOvQD1z1pVU_FI7EChd8c793VZIAlCOXv12HvO5dEKhE2S5xM27WCU4QaAjzrEALw_wcB")
htmlCode = readLines(con,n=10)
close(con)
htmlCode # entrega un gran string con las etiquetas html, dificil de manejar 

library(XML)
#library(RCurl) para poder extraer data de portal con https, ademas del http

url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html=readLines(url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"))
doc <- htmlTreeParse(html,useInternalNodes = T) #useinternal es para extraer toda la estructura

xpathSApply(doc,"//title",xmlValue)

library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=T)
xpathSApply(parsedHtml,"//a",xmlValue) #para encontrar las partes del texto con la etiqueta referida

#para paginas con contraseña

pg0 = GET("http://httpbin.org/basic-auth/user/passwd") # nos va a mandar un error de autentificacion, status 402

pg1 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
names(pg1)

# usar handle, para manejar facilmente la data extraida.
google = handle("http://google.com")
pg1 = GET(handle = google,path="/")
pg2 = GET(handle = google,path = "search")


# QUIZ PART => How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html

#intento 1
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html = readLines(url)
html
doc <- htmlTreeParse(html,useInternalNodes = T)
xpathSApply(doc,"//title",xmlValue)

#intento 2
library(httr)
htm2 <- GET(url)
htm2
cotent2 = content(htm2,aS="text")
cotent2
parsedhtml = htmlParse(cotent2,asText = T)
parsedhtml

# Solucion => intento 3 : de esta forma podemos recorrer caracter por caracter con el corte []
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con,n=100)
close(con)
htmlCode

print(nchar(htmlCode[c(10,20,30,100)]))

# ejercicio: leer .for data que esta desordenada => fixed width file

doc <- read.fwf(file = "getdata_wksst8110.for",skip = 4, widths =c(10, 9,4,9,4,9,4,9,4))
head(doc)

# segunda forma de leer

doc1 <- readLines("getdata_wksst8110.for")
doc1 <- doc1[-(1:4)]
doc1

mydata <- data.frame(date = substr(doc1,1,9),
                     v1 = substr(doc1,15,19),
                     v1a = substr(doc1,21,23),
                     v2 = substr(doc1,29,32),
                     v2a = substr(doc1,34,37)
        )
sum(as.double(mydata$v2)) # verificar que no es integer ! con integer los valores se aproximan! 
mydata$v2a

# OTRA FORMA 
# df <- read.fwf(
#         file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
#         widths=c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4),
#         skip=4
# )




