# Go to the folder where you have stored the MD repo before running the script
dir <- getwd()
db <- read.csv(paste0(dir,"/data/census-income.data"),header=F, sep=",", strip.white = TRUE) # take out trailing whitespaces
mean(is.na(db)) * 100
num_question_marks <- sum(db == "?", na.rm = TRUE)
total_cells = ncol(db) * nrow(db)
