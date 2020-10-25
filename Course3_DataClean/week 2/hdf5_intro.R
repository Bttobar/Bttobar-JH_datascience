
# HDF5 otro formato para guardar los datos.

# Caracteristicas: para guardar large data sets + alta variedad de tipos 
# groups => group header (name + attrib)
#        => group symbol (lista de objetos)
# datasets => header (name + metadata como datatype ...) + arreglo de la data.
# www.hdfgroup.org


if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
BiocManager::install(version = "3.11")

BiocManager::install("rhdf5")

library(rhdf5) # diferencia con require ? con el library cargamos load el paquete. 
created = h5createFile("example.h5") # con esto creamos un set del tipo hdf5    
created = h5createGroup("example.h5","tech") # se crean las diferentes categorias o grupos (rows)
created = h5createGroup("example.h5","ml")
created = h5createGroup("example.h5","ml/industry ia") # subgrupos.
h5ls("example.h5") # leemos el arreglo.

A = matrix(1:10,nr = 5, nc= 2)
h5write(A,"example.h5","tech/A")
B = array(seq(0.1,2.0,0.1),dim = c(5,2,2)) #  2 matrices de 5 filas por 2 columnas 
attr(B,"scale") <- "liter"
h5write(B,"example.h5","ml/industry ia/B")
h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out = 5))
#c("ab","cde","fghi","a","s"), stringAsFactors = FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

readA = h5read("example.h5","tech/A")
readB = h5read("example.h5","ml/industry ia/B")
readdf = h5read("example.h5","df")

readA; readB; readdf

h5write(c(12,13,14),"example.h5","tech/A",index=list(1:3,1))
h5read("example.h5","tech/A")

