
# Data:
# The purpose of the web site is to provide data and
# information about the quality of care at over 4,000 Medicare-certied hospitals in the U.S. This dataset es-
# sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
# whether hospitals should be ned for not providing high quality care to patients

# Dataset 1: Contains information about 30-day mortality and readmission rates
# for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
outcome_csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character",sep = ",", dec = ".")
# colClasses => sirve para entregar todos los valores como characters y asi optimizar recursos 
# recordar transformar al tipo que corresponda para tratar los datos. 
# > outcome[,11]<- as.numeric(outcome[,11]) se transforma a numero para luego poder hacer un histograma.

# Dataset 2: Contains info about each hospital
hospital_data = read.csv("hospital-data.csv")

# Info about the variables on the files at Hospital_Revised_Flatfiles.pdf
# Number 19 (\Outcome of Care Measures.csv") and Number 11 (\Hospital Data.csv")
# Como mostrar la relacion entre zip code cercanos y hearthattack.

outcome[,11]<-as.numeric(outcome[,11])
print("Ejercio 1: Graficar histograma de Mortalidad por ataque cardiaco en 30 dias de los hospitales estadounidenses")
hist(outcome[,11],xlab = "Cantidad de muertes",ylab = "US Hospitals"
     , main = "Mortalidad por Ataque Cardicos en 30 Dias")


# 2) 
# best hospital == lowest 30 day mortality for the specified outcome. 
# type of outcome = hearth attack / hearth dailure / pneumonia
# hospitales sin datos deben ser excluidos sobre el conjunto de hospitales de los que se rankea. 
# handling ties == hosp names should be sorted alphabetical order and the first hospital should be chosen 

print("Ejercicio 2: Finding the best hospital")

outcome_data <- function(data, outcome, state){
        set = 0
        i = 0
        if(outcome == "heart attack")
        {
                i <- 11
        }
        if(outcome == "heart failure")
        {
                i <- 17
        }
        if(outcome == "pneumonia")
        {
                i<- 23
    
        }
        if(i == 0){
          stop("invalid outcome. Choose: hearth attack, heart failure or pneumonia")
        }
        if(sum(data$State == state)>1){
            set <- data[data$State == state,c(1:10, i)]
        }else{
          print("invalid state")
          set <- NULL
        }
        #print(names(set))
        return(set)
        #return(list(set = set,indice = i, name = names(data[i])))
}


best <- function(state, outcome){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character",sep = ",", dec = ".")
        
        # Se extraen aquellos registros que pertenecen al estado state
        #print(head(data))
        data <- outcome_data(data,outcome,state) #set con state == state y se adiciona la columna que necesitamos 
  
        data[,11] <- as.numeric(data[,11])
        data <- data[!is.na(data[,11]),]
        # print(is.numeric(outcome_data$set))
        
        max <- Inf
        repetidos<- c()
        #print(1:ncol(data))
        for(i in 1:nrow(data)){
                
                evaluado <- data[i,11] ##no corresponde al state que estoy buscando
                #print("evaluado:")
                #print(evaluado)
                if(evaluado <  max){
                        max <- evaluado
                        repetidos <- data$Hospital.Name[i]
                }
                else{
                        if(evaluado == max)
                        {
                                repetidos <- c(data$Hospital.Name[i],repetidos)
                        }
                }
                #print("max: ")
                #print(max)
        }
        if(repetidos > 0){
                sort(repetidos,decreasing = FALSE)
        }
       
        return(repetidos)
} 
## corregir la funcion limpieza, falta agregar otros valores como NOT AVAIBLE o " " , ADEMAS DE LOS NULOS. 

print("Ejercicio 3: Ranking hospitals by outcome in a state ")

eval_num <- function(num,data){
  if(typeof(num)=="character"){
    
    if(num == "worst")
    {
      num <- nrow(data)
    }
    if(num == "best")
    {
      num <- 1 
    }
  }
  return(num)
}  

rankhospital <- function(state, outcome,num="best")
{
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character",sep = ",", dec = ".")
  #print(paste("este es el state que entra a rankhospital: ",state))
  data <- outcome_data(data,outcome, state)
  #print("evaluado")
  
  if(is.null(data))
  {
    print(paste("es nulo: ",state))
    return(NaN)
  }
  data[,11] <- as.numeric(data[,11])
  data <- data[!is.na(data[,11]),]
  
  num <- eval_num(num,data)

  data <- data[order(data[,11],data[,2]),]
  #print(data[,c(2,11)])
  return(data$Hospital.Name[num])
  
}
  
print("Ejercicio 4: Ranking hospitals in all states ")

rankall <- function(outcome, num = 1)
{     
  #data <- read.csv("outcome-of-care-measures.csv", colClasses = "character",sep = ",", dec = ".")
  
  estados <- as.vector(unique(data['State']))
  df <- data.frame(Hospital = character(), State=character())
  for (estado in estados[,1]){
    #print(estado)
    #print('sigiente')
    #print(paste("Esto es una prueba: ",rankhospital(estado,outcome,num)))
    hospital_rankeado <-  rankhospital(estado,outcome,num)
    if(is.na(hospital_rankeado)){ next}
    #print(paste("primer estado:",estado,hospital_rankeado,"siguiente estado"))
    newrow <- data.frame(hospital_rankeado,estado,row.names = estado)
    #print(newrow)
    names(newrow)<- names(df)
    df <- rbind(df,newrow)
    #print(df)
  }
  df <- df[order(df$State),]
  return(df)  
}


#for (i in 1:nrow(df)) {
#  print(df[i, "column1"])
  # do more things with the data frame...
#} column1_list = df[["column1"]]
#estados <- unique(data['State'])
#for(i in 1:nrow(estados)){
#  print("hola")
#  print(estados[i,])
#}

#RECORRER LISTAS !
#estados <- as.vector(unique(data['State']))
#for(estado in estados[,1]){
#  print(estado)
#  print("termino")}

# revisar profiler que es cuanto tiempo se encuentra en una funcion

