library(dplyr)
setwd("/Users/tommasopatriti/Desktop/UNI UPC/DM/Project/MD")
dir <- getwd()
dd <- readRDS(paste0(dir,"/data/Preprocessed_data_rds.rds"))


names(dd)
dim(dd)
summary(dd)

attach(dd)


dcon <- select_if(dd, is.numeric)
dim(dcon)


library(cluster)


actives<-c(2:28)
dissimMatrix <- daisy(dd[,actives], metric = "gower", stand=TRUE)

distMatrix<-dissimMatrix^2

h1 <- hclust(distMatrix,method="ward.D2")  

plot(h1)

k<-2

c2 <- cutree(h1,k)


table(c2)



# LETS SEE THE PARTITION VISUALLY

c1<-c2

pairs(dcon[,1:8], col=c1)

plot(age, instance.weight, col=c1)


