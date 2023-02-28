# Go to the folder where you have stored the MD repo before running the script
dir <- getwd()
db <- read.csv(paste0(dir,"/data/raw_data/census-income.data"),header=F, sep=",", strip.white = TRUE) # take out trailing whitespaces
mean(is.na(db)) * 100
num_question_marks <- sum(db == "?", na.rm = TRUE)
total_cells = ncol(db) * nrow(db)

# grepl returns whether that value is found or not
col_missing <- colSums(sapply(db, function(x) grepl("\\?", x)))
col_missing

col_percents <- colSums(sapply(db, function(x) grepl("\\?", x)))/ nrow(db) * 100
col_percents

average_missing <- (sum(col_percents, na.rm = TRUE) / length(col_percents)) 
average_missing

summary(db)
# Get all the unique values for each column
unique_values <- lapply(df, unique)
unique_values <- lapply(db, function(x) length(unique(x)))

# Need to use one-hot encoding first

cor_mat<- cor(db)
corrplot(cor_mat, method="circle")
colnames(db) <- c("age", "class of worker", "detailed industry recode", "detailed occupation recode", "education", "wage per hour", "enroll in edu inst last wk", "marital stat", "major industry code", "major occupation code", "race", "hispanic origin", "sex", "member of a labor union", "reason for unemployment", "full or part time employment stat", "capital gains", "capital losses", "dividends from stocks", "tax filer stat", "region of previous residence", "state of previous residence", "detailed household and family stat", "detailed household summary in household", "instance weight", "migration code-change in msa", "migration code-change in reg", "migration code-move within reg", "live in this house 1 year ago", "migration prev res in sunbelt", "num persons worked for employer", "family members under 18", "country of birth father", "country of birth mother", "country of birth self", "citizenship", "own business or self employed", "fill inc questionnaire for veteran's admin", "veterans benefits", "weeks worked in year", "year", "income")
