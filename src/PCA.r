# Go to the MD project folder before running the script
dir <- getwd()
# Import preprocessed data
db <- read.csv(paste0(dir,"/data/new_imputed_data.csv"),header=T, sep=",", strip.white = TRUE) # take out trailing whitespaces
# Check if there are any missing values, there should not be because they have been imputed, or removed
sum(is.na(db))

objects()
attributes(dd)

attach(dd)
names(dd)

#is R understanding well my factor variables?
sapply(dd,class)

numeriques<-which(sapply(dd,is.numeric))
numeriques

dcon<-dd[,numeriques]
sapply(dcon,class)

# Load the dplyr package
#install.packages("dplyr")
library(dplyr)

# Select only the categorical variables
numerical_data <- select_if(db, is.numeric)
categorical_data <- select_if(db, is.character)

# Perform PCA on the data
pca <- prcomp(numerical_data, scale. = TRUE)

# View the results
summary(pca)

#write.table(data, file = "data/processed_data/one_hot_db.csv", sep = ",", row.names = FALSE)

install.packages("corrplot")

# Load the corrplot package
library(corrplot)
# View the correlation matrix only of the numerical values
cor_mat<- cor(numerical_data)
# Set the upper triangle elements to NA
cor_mat[upper.tri(cor_mat)] <- NA

corrplot(cor_mat, method="circle")
