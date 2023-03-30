# Go to the MD project folder before running the script
dir <- getwd()
# Import raw data
db <- read.csv(paste0(dir,"/data/raw_data/census-income.data"),header=F, sep=",", strip.white = TRUE) # take out trailing whitespaces

# # Apply random sampling 
# while(nrow(db) > 10000) {
#   ID = as.integer(runif(1, min = 0, max = nrow(db)-1))
#   newdb <- db[-c(ID), ]
# }

library(dplyr)

# Apply random sampling using the slice_sample function from dplyr package
newdb <- db %>% slice_sample(n = 20000)

# Name of each feature
col_names <- variable_names <- c("age", "class of worker", "detailed industry recode", "detailed occupation recode", 
                                 "education", "wage per hour", "enroll in edu inst last wk", "marital stat", 
                                 "major industry code", "major occupation code", "race", "hispanic origin", 
                                 "sex", "member of a labor union", "reason for unemployment", "full or part time employment stat", 
                                 "capital gains", "capital losses", "dividends from stocks", "tax filer stat", 
                                 "region of previous residence", "state of previous residence", "detailed household and family stat", 
                                 "detailed household summary in household", "instance weight", "migration code-change in msa", 
                                 "migration code-change in reg", "migration code-move within reg", "live in this house 1 year ago", 
                                 "migration prev res in sunbelt", "num persons worked for employer", "family members under 18", 
                                 "country of birth father", "country of birth mother", "country of birth self", "citizenship", 
                                 "own business or self employed", "fill inc questionnaire for veteran's admin", "veterans benefits", 
                                 "weeks worked in year", "year", "income")

# Assign the column names to the new data frame
colnames(newdb) <- col_names

# Save the 20.000 rows data 
write.table(newdb,"20000data.csv", row.names = TRUE, sep = ",")
