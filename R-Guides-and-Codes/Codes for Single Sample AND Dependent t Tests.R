#################################################################
# Single Sample and Dependent (Paired Samples) t Tests
# ITAO 20200: Foundations of Statistics
# J. S. Akosa, F. Bilson Darku, J. Waddell, & M. O'Callaghan
#################################################################

#################################################################
# PART 1: SINGLE SAMPLE t TEST
#################################################################

# ---- Data -----------------------------------------------------

Grades <- read.csv("https://mendoza-stats.s3.amazonaws.com/grades.csv")
head(Grades, n = 5) # First 5 observations in the dataset

# ---- Some Summary Statistics ----------------------------------

summary(Grades$Pretest)
sd(Grades$Pretest)
length(Grades$Pretest)

# ---- One Sample t Test ----------------------------------------

# H0: mu = 70,  Ha: mu != 70
t.test(Grades$Pretest,            # the variable we are testing
       alternative = "two.sided", # the alternative hypothesis
       mu = 70,                   # the null value
       conf.level = 0.95)         # the confidence level = 1 - alpha

#################################################################
# PART 2: DEPENDENT (PAIRED SAMPLES) t TEST
#################################################################

# ---- Data -----------------------------------------------------

Grades <- read.csv("https://mendoza-stats.s3.amazonaws.com/grades.csv")
head(Grades, n = 3) # First 3 observations in the data set

# ---- Some Summary Statistics ----------------------------------

# Individual commands for each variable
summary(Grades$Pretest)
sd(Grades$Pretest)
length(Grades$Pretest)

summary(Grades$Midterm)
sd(Grades$Midterm)
length(Grades$Midterm)

summary(Grades$Final)
sd(Grades$Final)
length(Grades$Final)

# Shortcut: sapply applies a function to all three variables at once
sapply(Grades[, c("Pretest", "Midterm", "Final")], summary)
sapply(Grades[, c("Pretest", "Midterm", "Final")], sd)
sapply(Grades[, c("Pretest", "Midterm", "Final")], length)

# ---- Paired Samples t Test: Pretest and Midterm ---------------

# H0: mu_d = 0,  Ha: mu_d != 0
t.test(Grades$Pretest, Grades$Midterm,  # the variables we are testing
       alternative = "two.sided",       # the alternative hypothesis
       mu = 0,                          # the null (or test) value
       conf.level = 0.95,               # the confidence level = 1 - alpha
       paired = TRUE)                   # this indicates that it's a paired t test

# ---- Paired Samples t Test: Midterm and Final -----------------

t.test(Grades$Midterm, Grades$Final,   # the variables we are testing
       alternative = "two.sided",      # the alternative hypothesis
       mu = 0,                         # the null (or test) value
       conf.level = 0.95,              # the confidence level = 1 - alpha
       paired = TRUE)                  # this indicates that it's a paired t test
