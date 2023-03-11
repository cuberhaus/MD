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
