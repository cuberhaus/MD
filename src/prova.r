# Go to the folder where you have stored the MD repo before running the script
dir <- getwd()
db <- read.csv(paste0(dir,"/data/census-income.data"),header=F, sep=",", strip.white = TRUE) # take out trailing whitespaces
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
