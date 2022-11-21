#Johannes, 21.11.2022, Alcohol consumption dataset(by Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez)

#libaries
library(dplyr)
library(tidyverse)


#reading data and exploring the structure

setwd("C:/LocalData/gale/R/IODS-project2/Data")

mat <- read.table("C:/LocalData/gale/R/IODS-project2/Data/student-mat.csv", sep=";", header=TRUE)
por <- read.table("C:/LocalData/gale/R/IODS-project2/Data/student-por.csv", sep=";", header=TRUE)

dim(mat)
dim(por)

str(mat)
str(por)

#mat has 395rows and 33 columns and por 649 rows and 33 columns. Both datasets have some numeral and not numeral rows, with similar measures.


#now joining the two datasets according to intsructions

free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))

#joining


#exploring structure and dimensions
str(math_por)
dim(math_por)

#joining seems to have worked, data having 370 rows and 39 columns


#now getting rid of duplicates

alc <- select(math_por, all_of(join_cols))


for(col_name in free_cols) {

  two_cols <- select(math_por, starts_with(col_name))

  first_col <- select(two_cols, 1)[[1]]
  

  if(is.numeric(first_col)) {
  
    alc[col_name] <- round(rowMeans(two_cols))
  } else { 
    alc[col_name] <- first_col
  }
}

glimpse(alc)
#Now data has 370 rows and 33 columns

#Taking the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data and creating a new column high_use' for students with alc_use is greater than 2
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)
#everything seems to be in order

write_csv(math_por,"C:/LocalData/gale/R/IODS-project2/Data/math-por.csv", append = TRUE, col_names = FALSE)


