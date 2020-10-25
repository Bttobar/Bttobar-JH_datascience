
# Reading from API'S

install.packages("httr")
library(httr)
install.packages("httpuv")
install.packages("rtools")
library(httpuv)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp = oauth_app("github",key="3213bd8b8a658c00987f",
                  secret = "f4cc49ea9507d40d6ffcf7f1e9ccfb416bc047ff")


# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp,cache = FALSE)
github_token

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken) #json data
req
stop_for_status(req)
content(req)


# QUIZ PART

req_quiz <- GET("https://api.github.com/users/jtleek/repos", gtoken)

data <- content(req_quiz)

install.packages("tidyverse")
library(tidyverse)

fecha_quiz <- function(data){
        for (i in seq_along(data)) {
                fecha <<- 0 
                
               if (data[[i]]$name == "datasharing"){
                        fecha <- data[[i]]$created_at
                        break
                       }
                
        }
        return(fecha)
        
}
        

