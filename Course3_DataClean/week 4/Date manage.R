#  Working with dates 

d1 = date()
class(d1)

d2 = Sys.Date()
d2
class(d2)

format(d2,"%a %b %d") 
# %a = weekday / A = unbreviated week day / m = month  + b abreviated month B unbr/ y Y 
# d => day number

x <- c("1enero1960","2enero1960"); 
z <-as.Date(x,"%d%b%Y")
z

z[1]-z[2] # difference between dates
as.numeric(z[1]-z[2])

weekdays(d2)

months(d2)

julian(d2)

library(lubridate); ymd("20130108") # year/month/day
mdy("08/04/2013")
dmy("03-04-2013")

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Aukland")

?Sys.timezone

x = dmy(c("1enero2013","1julio2020"))
wday(x[1])
wday(x[1],label=T)

###################Resources##################

# data.gov
# gapminder: human health
# survey data EEUU
# Ifochimps marketplace
# Kaggle
# UCI ML 
# STANFORD LARGE NETWORKD DATA
# KDD NUGGETS
# CMU STABLIB
# ARXIV DATA 
# TWITTER
# FIGSHARE
# RPLOS
# ROPENSCI
# FACEBOOK - GOOGLE MAPS 

library(swirl)




















