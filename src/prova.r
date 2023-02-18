# Go to the folder where you have stored the MD repo before running the script
dir <- getwd()
db <- read.table(paste0(dir,"/data/census-income.data"),header=F, sep=",")
mean(is.na(db)) * 100