
# Data:
# The purpose of the web site is to provide data and
# information about the quality of care at over 4,000 Medicare-certied hospitals in the U.S. This dataset es-
# sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
# whether hospitals should be ned for not providing high quality care to patients

# Dataset 1: Contains information about 30-day mortality and readmission rates
# for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character",sep = ",", dec = ".")
# Dataset 2: Contains info about each hospital
hospital_data = read.csv("hospital-data.csv")

# Info avout the variables on the files at Hospital_Revised_Flatfiles.pdf
# Number 19 (\Outcome of Care Measures.csv") and Number 11 (\Hospital Data.csv")
# Como mostrar la relacion entre zip code cercanos y hearthattack.

# hearth attack / hearth dailure / pneumonia
best <- function(state, outcome){
        
} 


