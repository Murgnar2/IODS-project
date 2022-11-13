#Johannes, 13.11.2022, week2 data wrangling 



data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

str(data)
dim(data)
#data seems to have 183rows and 60columns

data$attitude <- data$Attitude / 10

library(dplyr)
library(tidyverse)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
attitude_questions <- c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")

 
deep_columns <- select(data, one_of(deep_questions))

data$deep <- rowMeans(deep_columns)


surface_columns <- select(data, one_of(surface_questions))

data$surf <- rowMeans(surface_columns)


strategic_columns <- select(data, one_of(strategic_questions))

data$stra <- rowMeans(strategic_columns)

attitude_columns <- select(data, one_of(attitude_questions))

data$attitude <- rowMeans(attitude_columns)


keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")


learning2014 <- select(data, one_of(keep_columns))

learning2014 <- filter(learning2014, Points > "0")

str(learning2014)


setwd("C:/LocalData/gale/R/IODS-project2")

write.csv(learning2014, "C:/LocalData/gale/R/IODS-project2/data/learning2014.csv", row.names = FALSE)

data2 <- read_csv("C:/LocalData/gale/R/IODS-project2/data/learning2014.csv")

str(data2)
head(data2)
