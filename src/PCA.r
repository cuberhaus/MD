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

# Perform an ANOVA test for each numerical variable and each categorical variable
for (col in names(data_dummy)) {
  if (is.numeric(data_dummy[, col])) {
    for (cat in names(data_dummy)[!names(data_dummy) %in% col]) {
      anova_result <- aov(data_dummy[, col] ~ data_dummy[, cat])
      print(paste0("ANOVA for ", col, " and ", cat))
      print(summary(anova_result))
    }
  }
}

# Calculate effect size measures for the ANOVA tests
library(rstatix)
for (col in names(data_dummy)) {
  if (is.numeric(data_dummy[, col])) {
    for (cat in names(data_dummy)[!names(data_dummy) %in% col]) {
      anova_result <- aov(data_dummy[, col] ~ data_dummy[, cat])
      eta_squared <- anova_test(anova_result) %>% 
        get_anova_table() %>% 
        eta_squared()
      print(paste0("Effect size for ", col, " and ", cat))
      print(eta_squared)
    }
  }
}