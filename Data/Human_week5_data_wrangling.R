library(dplyr)
library(stringr)

human <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", sep = ",", header = TRUE)
dim(human)
str(human)
#There are 19 varibles and 195 observations. Data composes of Human Development Index (HDI) related variables. Including different countries and and their developement levels and ranks.
# The data combines several indicators from most countries in the world

#"Country" = Country name

# Health and knowledge

#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate

# Empowerment

#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force

#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M

str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#mutating GNI to numeric

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human <- filter(human, complete.cases(human))

glimpse(human)

#Removing regions
tail(human,10)
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]
dim(human)

rownames(human) <- human$Country

#Define the row names of the data by the country names and remove the country name column from the data
human_ <- select(human, -Country)

glimpse(human_)

write.csv(human_, "C:/LocalData/gale/R/IODS-project2/data/human_.csv")
