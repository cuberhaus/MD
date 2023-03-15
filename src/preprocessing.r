library(dplyr)
# Go to the MD project folder before running the script
dir <- getwd()

# Import the sampling data
db <- read.csv(paste0(dir,"/data/20000data.csv"), header=T, sep=",", strip.white = TRUE) # take out trailing whitespaces

# Transform missing values to NA
db[db == "Not in universe"] <- NA
db[db == "Not in universe or children"] <- NA
db[db == "?"] <- NA
db[db == "Not in universe under 1 year old"] <- NA

# Transform those variable that contains 0, the 0 means not in the universe, to NA 
db$veterans.benefits[db$veterans.benefits == 0] <- NA
db$own.business.or.self.employed[db$own.business.or.self.employed == 0] <- NA
db$detailed.occupation.recode[db$detailed.occupation.recode == 0] <- NA
db$detailed.industry.recode[db$detailed.industry.recode == 0] <- NA

# Transform detalied industry and occupation recodes to names
db <- db %>%
  mutate(detailed.industry.recode = recode(detailed.industry.recode,
     `1` = "Agriculture Service", `2` = "Other Agriculture", `3` = "Mining", `4` = "Construction", `5` = "Lumber and wood products, except furniture", `6` = "Furniture and fixtures", `7` = "Stone clay, glass, and concrete product", `8` = "Primary metals", `9` = "Fabricated metal", `10` = "Not specified metal industries", 
     `11` = "Machinery, except electrical", `12` = "Electrical machinery, equipment, and supplies", `13` = "Motor vehicles and equipment", `14` = "Aircraft and parts", `15` = "Other transportation equipment", `16` = "Professional and photographic equipment, and watches", `17` = "Toys, amusements, and sporting goods", 
     `18` = "Miscellaneous and not specified manufacturing industries", `19` = "Food and kindred products", `20` = "Tobacco manufactures", `21` = "Textile mill products", `22` = "Apparel and other finished textile products", `23` = "Paper and allied products", `24` = "Printing, publishing and allied industries", `25` = "Chemicals and allied products", `26` = "Petroleum and coal products", 
     `27` = "Rubber and miscellaneous plastics products", `28` = "Leather and leather products", `29` = "Transportation", `30` = "Communications", `31` = "Utilities and Sanitay Services", `32` = "Wolesale Trade", `33` = "Retail Trade", `34` = "Banking and Other Finance", `35` = "Insurance and Real Estate", `36` = "Private Household Services", `37` = "Business Services", `38` = "Repair Services", 
     `39` = "Personal Services, Except Private Household", `40` = "Entertainment and Recreation Services", `41` = "Hospitals", `42` = "Health Services, Except Hospitals", `43` = "Educational Services", `44` = "Social Services", `45` = "Other Professional Services", `46` = "Forestry and Fisheries", `47` = "Justice, Public Order and Safety", `48` = "Administration of Human Resource Programs", 
     `49` = "National Security and Internal Affairs", `50` = "Other Public Administration", `51` = "Armed Forces last job, currently unemployed"
  ))

db <- db %>%
  mutate(detailed.occupation.recode = recode(detailed.occupation.recode,
                                             `1` = "Public Administration", `2` = "Other Executive, Administrators, and Managers", `3` = "Management Related Occupations", `4` = "Engineers", `5` = "Mathematical and Computer Scientists", `6` = "Natural Scientists", `7` = "Health Diagnosis Occupations", `8` = "Health Assessment and Treating Occuaptions", `9` = "Teachers, College and University", 
                                             `10` = "Teachers, Except College and University", `11` = "Lawyers and Judges", `12` = "Other Professional Specialty Occupations", `13` = "Health Technologists and Technicians", `14` = "Engineering and Science Technicians", `15` = "Technicians, Except Health, Engineering, and Science", `16` = "Supervisors and Proprietors, Sales Occupations", 
                                             `17` = "Sales Representatives, Finance, and Business Service", `18` = "Sales Representatives, Commodities, Except Retail", `19` = "Sales Workers, Retail and Personal Services", `20` = "Sales Related Occupations", `21` = "Supervisors - Administrative Support", `22` = "Computer Equipment Operators", `23` = "Secretaries, Stenographers, and Typists", 
                                             `24` = "Financial Records, Processing Occupations", `25` = "Mail and Message Distributing", `26` = "Other Administrative Support Occupations, Including Clerical", `27` = "Private Household Service Occupations", `28` = "Protective Service Occupations", `29` = "Food Service Occupations", `30` = "Health Service Occupations", `31` = "Cleaning and Building Service Occupations",
                                             `32` = "Personal Service Occupations", `33` = "Mechanics and Repairers", `34` = "Construction Trades", `35` = "Other Precision Production Occupations", `36` = "Machine Operators and Tenders, Except Precision", `37` = "Fabricators, Assemblers, Inspectors, and Samplers", 
                                             `38` = "Motor Vehicle Operators", `39` = "Other Transportation Occupations and Material Moving", `40` = "Construction Laborer", `41` = "Freight, Stock and Material Handlers", `42` = "Other Handlers, Equipment Cleaners, and Laborers", `43` = "Farm Operators and Managers", 
                                             `44` = "Farm Workers and Related Occupations", `45` = "Forestry and Fishing Occupations", `46` = "Armed Forces last job, currently unemployed"
  ))

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
categoricalVars <- c("class.of.worker", "detailed.industry.recode", "detailed.occupation.recode", 
                     "education", "marital.stat", "major.industry.code", 
                     "major.occupation.code", "race", "hispanic.origin", 
                     "sex", "full.or.part.time.employment.stat", "tax.filer.stat", 
                     "detailed.household.and.family.stat", "detailed.household.summary.in.household", "country.of.birth.father", 
                     "country.of.birth.mother", "country.of.birth.self", "citizenship", 
                     "veterans.benefits", "income")  

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
# Add level "Not considered"
db$detailed.industry.recode <- factor(db$detailed.industry.recode,  levels=c(levels(db$detailed.industry.recode), 'Not considered'))
# Replace NA
db$detailed.industry.recode[is.na(db$detailed.industry.recode)] <- "Not considered"


# Add level "Not considered"
db$class.of.worker <- factor(db$class.of.worker,  levels=c(levels(db$class.of.worker), 'Not considered'))
# Replace NA
db$class.of.worker[is.na(db$class.of.worker)] <- "Not considered"

# Add level "Not considered"
db$detailed.occupation.recode <- factor(db$detailed.occupation.recode,  levels=c(levels(db$detailed.occupation.recode), 'Not considered'))
# Replace NA
db$detailed.occupation.recode[is.na(db$detailed.occupation.recode)] <- "Not considered"

# Add level "Not considered"
db$major.industry.code <- factor(db$major.industry.code,  levels=c(levels(db$major.industry.code), 'Not considered'))
# Replace NA
db$major.industry.code[is.na(db$major.industry.code)] <- "Not considered"

# Add level "Not considered"
db$major.occupation.code <- factor(db$major.occupation.code,  levels=c(levels(db$major.occupation.code), 'Not considered'))
# Replace NA
db$major.occupation.code[is.na(db$major.occupation.code)] <- "Not considered"


# Add level "UnknownFatherCountry"
db$country.of.birth.father <- factor(db$country.of.birth.father,  levels=c(levels(db$country.of.birth.father), 'UnknownFatherCountry'))
# Replace NA
db$country.of.birth.father[is.na(db$country.of.birth.father)] <- "UnknownFatherCountry"


# Add level "UnknownMotherCountry"
db$country.of.birth.mother <- factor(db$country.of.birth.mother,  levels=c(levels(db$country.of.birth.mother), 'UnknownMotherCountry'))
# Replace NA
db$country.of.birth.mother[is.na(db$country.of.birth.mother)] <- "UnknownMotherCountry"


# Add level "UnknownSelfCountry"
db$country.of.birth.self <- factor(db$country.of.birth.self,  levels=c(levels(db$country.of.birth.self), 'UnknownSelfCountry'))
# Replace NA
db$country.of.birth.self[is.na(db$country.of.birth.self )] <- "UnknownSelfCountry"

# Add level "UnknownVeteranBenefits"
db$veterans.benefits <- factor(db$veterans.benefits,  levels=c(levels(db$veterans.benefits), 'UnknownVeteranBenefits'))
# Replace NA
db$veterans.benefits[is.na(db$veterans.benefits)] <- "UnknownVeteranBenefits"

# Save the preprocessed data  
write.table(db,"Preprocessed_data.csv", row.names = TRUE, sep = ",")

