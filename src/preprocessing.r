# Preprocessing
dir <- getwd()
db <- read.csv(paste0(dir,"/census-income.txt"),header=F, sep=",", strip.white = TRUE) # take out trailing whitespaces

colnames(db) <- c("age", "class of worker", "detailed industry recode", "detailed occupation recode", "education", "wage per hour", "enroll in edu inst last wk", "marital stat", "major industry code", "major occupation code", "race", "hispanic origin", "sex", "member of a labor union", "reason for unemployment", "full or part time employment stat", "capital gains", "capital losses", "dividends from stocks", "tax filer stat", "region of previous residence", "state of previous residence", "detailed household and family stat", "detailed household summary in household", "instance weight", "migration code-change in msa", "migration code-change in reg", "migration code-move within reg", "live in this house 1 year ago", "migration prev res in sunbelt", "num persons worked for employer", "family members under 18", "country of birth father", "country of birth mother", "country of birth self", "citizenship", "own business or self employed", "fill inc questionnaire for veteran's admin", "veterans benefits", "weeks worked in year", "year", "income")

library(dplyr)
categorical_data <- select_if(db, is.character)
colnames(categorical_data)
# Declaring Factors

sapply(categorical_data, class)

#NO EJECUTAR, orden de las columnas
WorkerClass <- factor("class of worker")2
Education <- factor("education")5
EnrollInEdu <- factor("enroll in edu inst last wk")7
MaritalStat <- factor("marital stat")8
IndustryCode <- factor("major industry code")9
OccupationCode <- factor("major occupation code")10
Race <- factor("race")11
HispanicOrigin <- factor("hispanic origin")12
Sex <- factor("sex")13
MemeberLabor <- factor("member of a labor union")14
ReasonUnemployment <- factor("reason for unemployment")15
TypeEmployment <- factor("full or part time employment stat")16
TaxStat <- factor("tax filer stat")20
ResidenceRegion <- factor("region of previous residence")21
PreviousResidence <- factor("state of previous residence")22
FamilyStat <- factor("detailed household and family stat")23
DetailedHouseholdSummary <- factor("detailed household summary in household")24
MSA <- factor("migration code-change in msa")26
MSAREG <- factor("migration code-change in reg")27
MCMWithinREG <- factor("migration code-move within reg")28
LiveinHouse <- factor("live in this house 1 year ago")29
PrevMigration <- factor("migration prev res in sunbelt")30
FamilyMembersUnder18 <- factor("family members under 18")32
FatherBirthCountry<- factor("country of birth father")33
MotherBirthCountry <- factor("country of birth mother")34
BirthCountry <- factor("country of birth self")35
Citizenship <- factor("citizenship")36
VeteranQuestionnaire <- factor("fill inc questionnaire for veteran's admin")38
Income <- factor("income")42

#Array de las columnas a factor 2,5,7,8,9,10,11,12
binaryVars <- c(13,14,15,16,20,21,22,23,24,26,27,28,29,30,32,33,34,35,36,38,42)

#Pasa los valores nulos NA
for(coll in binaryVars){
  for(row in 1:199523){
    if(db[row, coll] == "Not in universe" || db[row, coll] == "Not in universe or children" || db[row, coll] == "?") db[row, coll] <- "NA"
  }
}

#Recorre las columnas señaladas en binaryVars y le hace factor
for(col in binaryVars){
  newCol <- as.character(db[,col])
  newCol <- factor(newCol)
  db[,col] <- newCol
}

#Para comprobar el factor
db[,2]
