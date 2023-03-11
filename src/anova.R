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