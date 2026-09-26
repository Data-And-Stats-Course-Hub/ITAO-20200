#################################################################
# Single Sample t Test
# ITAO 20200: Foundations of Statistics
# J. S. Akosa, F. Bilson Darku, J. Waddell, & M. O'Callaghan
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

# The "alternative" argument controls which test you're running:
#   alternative = "less"      -> lower-tailed test   (Ha: mu < 70)
#   alternative = "greater"   -> upper-tailed test    (Ha: mu > 70)
#   alternative = "two.sided" -> two-tailed test      (Ha: mu != 70)
