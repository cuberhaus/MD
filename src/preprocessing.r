library(dplyr)
# Go to the MD project folder before running the script
dir <- getwd()

# Import the sampling data
db <- read.csv(paste0(dir,"/data/10000data.csv"), header=T, sep=",", strip.white = TRUE) # take out trailing whitespaces

# transformacion missing values to NA
db[db == "Not in universe"] <- NA
db[db == "Not in universe or children"] <- NA
db[db == "?"] <- NA
db[db == "Not in universe under 1 year old"] <- NA

# Compute % of missing data for each column
colMeans(is.na(db)) * 100
# Get the columns that have more than 50% missing data
missingColNames <- db[, sapply(db, function(x) sum(is.na(x)))/nrow(db)*100 > 50] %>% colnames 

# Compute % of missing data for each row
rowMeans(is.na(db)) * 100

# Get the rows that have more than 50% missing data
missingRowNames <-  db[apply(db, 1, function(x) sum(is.na(x)))/ncol(db)*100 > 50, ] %>% rownames 

# Delete rows that does not provide any important information 
db$year <- NULL      # columna que no aporta ninguna informacion

# Delete the columns and rows that have more than 50% of missing data
db <- db[, !(colnames(db) %in% missingColNames)]
db <- db[!(rownames(db) %in% missingRowNames), ]

# Names of the columns for all the categorical variables
categoricalVars <- c("education", "marital.stat", "race", "hispanic.origin", 
                     "sex", "full.or.part.time.employment.stat", "tax.filer.stat", "detailed.household.and.family.stat", 
                     "detailed.household.summary.in.household", "country.of.birth.father", "country.of.birth.mother", "country.of.birth.self", 
                     "citizenship", "income")

# Convert all the categorical variables to factors
db[categoricalVars] <- lapply(db[categoricalVars], factor)
levels(db[, "income"]) <- c("Less than 50000", "Greater than 50000")

# Get the columns names that they still have missing data
missingColNames <- db[, sapply(db, function(x) sum(is.na(x)))/nrow(db)*100 > 0] %>% colnames

# Get the columns that have missing data and are categorical variables
categoricalMissing <- db[, colnames(db) %in% missingColNames] %>% select(where(is.factor)) %>% names

# Get the columns that have missing data and are numerical variables
numericalMissing <- db[, colnames(db) %in% missingColNames] %>% select(where(is.numeric)) %>% names

# Imputation Numerical Variables
# We don't have any ....

# Imputation Categorical Variables



