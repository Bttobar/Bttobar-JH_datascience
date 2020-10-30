# 
library(swirl)
library(dplyr)
library(tidyr)
# http://vita.had.co.nz/papers/tidy-data.pdf
# | Tidy data is formatted in a standard way that facilitates exploration and analysis and works seamlessly with other tidy
# | data tools. Specifically, tidy data satisfies three conditions:
#         
#         | 1) Each variable forms a column
# 
#         | 2) Each observation forms a row
# 
#         | 3) Each type of observational unit forms a table
# The first problem is when you have column headers that are values, not variable names. I've created a simple dataset
# called 'students' that demonstrates this scenario. Type students to take a look.
# por ejemplo tener como nombre en la tabla : hombre | mujer y los valores representan la cantidad de cada genero.
# hombre y mujer harian referencia a valores y no nombres de variables. (en las columnas van NOMBRES DE VARIABLES)

gather(students,sex,count,-grade)

# | It's important to understand what each argument to gather() means. The data argument, students, gives the name of the
# | original dataset. The key and value arguments -- sex and count, respectively -- give the column names for our tidy
# | dataset. The final argument, -grade, says that we want to gather all columns EXCEPT the grade column (since grade is
# | already a proper column variable.)

res <- gather(students2,sex_class,count,-grade)
separate(res,col = sex_class,into = c("sex","class"))
# 
# | Conveniently, separate() was able to figure out on its own how to separate the sex_class column. Unless you request
# | otherwise with the 'sep' argument, it splits on non-alphanumeric values. In other words, it assumes that the values are
# | separated by something other than a letter or number (in this case, an underscore.)


students2 %>%
        gather(sex_class ,count , -grade) %>%
        separate( sex_class, c("sex", "class")) %>%
        print

students3 %>%
        gather( class, grade, class1:class5 , na.rm = TRUE) %>%
        print

# This script builds on the previous one by appending
# a call to spread(), which will allow us to turn the
# values of the test column, midterm and final, into
# column headers (i.e. variables).

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread( test,grade ) %>%
        print
library(readr)
parse_number("class5")


# | At first glance, there doesn't seem to be much of a problem with students4. All columns are variables and all rows are
# | observations. However, notice that each id, name, and sex is repeated twice, which seems quite redundant. This is a hint
# | that our data contains multiple observational units in a single table.


student_info <- students4 %>%
        select(id, name, sex) %>%
        ### Your code here %>%
        unique()%>%
        print
