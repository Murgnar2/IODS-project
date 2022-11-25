library(readr)
library(dplyr)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


str(hd)
dim(hd)

str(gii)
dim(gii)

summary(gii)
summary(hd)


colnames(hd)
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life.Exp"
colnames(hd)[5] <- "Edu.Exp"
colnames(hd)[7] <- "GNI"


colnames(gii)
colnames(gii)[3] <- "gii"
colnames(gii)[4] <- "Mat.Mor"
colnames(gii)[5] <- "Ado.birth"
colnames(gii)[6] <- "Parli.F"
colnames(gii)[7] <- "Edu2.F"
colnames(gii)[8] <- "Edu2.M"
colnames(gii)[9] <- "Labo.F"
colnames(gii)[10] <- "Labo.M"

gii_new <- gii %>% mutate(edu2 = Edu2.F+Edu2.M)

gii2 <- gii_new %>% mutate(Lab = Labo.F+Labo.M)

human <- inner_join(gii2, hd, by = "Country")


write.csv(human, "C:/LocalData/gale/R/IODS-project2/data/human.csv", row.names = FALSE)