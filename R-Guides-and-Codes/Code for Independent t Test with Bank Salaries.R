#################################################################
# Independent t Test: Bank Salaries
# ITAO 20200: Foundations of Statistics
# J. S. Akosa, F. Bilson Darku, J. Waddell
#################################################################


# ---- Data Entry -----------------------------------------------

# Read in the data set and call it bank
bank <- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/BankSalaries.csv")
head(bank, n = 5) # First 5 observations

# Transform the grouping variable, Gender, into a factor
# (0 = Male, 1 = Female)
bank$Gender <- factor(bank$Gender, levels = c(0, 1),
                      labels = c("Male", "Female"))

# Check the data after the transformation
head(bank, n = 5) # First 5 observations


# ---- Summary Statistics ---------------------------------------

by(bank$Salary, bank$Gender, mean)    # Dependent var, Independent var, statistic
by(bank$Salary, bank$Gender, sd)      # Dependent var, Independent var, statistic
by(bank$Salary, bank$Gender, length)  # Dependent var, Independent var, statistic


# ---- More Advanced Code for Summary Statistics ----------------

by(bank$Salary, bank$Gender, function(x) {
  c(n      = length(x),
    mean   = round(mean(x), 2),
    sd     = round(sd(x), 2),
    median = round(median(x), 2),
    min    = min(x),
    max    = max(x),
    se     = round(sd(x) / sqrt(length(x)), 2))
})


# ---- Test for Homogeneity (Equality) of Variance --------------

# install.packages("car")   # run once if car is not installed
library(car)
leveneTest(y = bank$Salary,        # dependent variable
           group = bank$Gender,    # independent variable
           center = mean)          # for Levene's test


# ---- Output 1: Unequal Variances Assumed ----------------------

# Independent t test for analyzing the differences between Salary of Male
# and Female employees when unequal variances are assumed
t.test(bank$Salary ~ bank$Gender,    # variables tested (depen. ~ indep.)
       alternative = "two.sided",    # specify the type of alternative hypothesis
       mu = 0,                       # identifies the null value
       conf.level = 0.95,            # confidence level = 1 - alpha
       var.equal = FALSE)            # FALSE = assumes unequal variances


# ---- Output 2: Equal Variances Assumed ------------------------

# Independent t test for analyzing the differences between Salary of Male
# and Female employees when equal variances are assumed
t.test(bank$Salary ~ bank$Gender,    # variables tested (depen. ~ indep.)
       alternative = "two.sided",    # specify the type of alternative hypothesis
       mu = 0,                       # the null (or test) value
       conf.level = 0.95,            # confidence level = 1 - alpha
       var.equal = TRUE)             # TRUE = assumes equal variances


# The "alternative" argument controls which test you're running:
#   alternative = "less"      -> lower-tailed test    (Ha: mu < 0)
#   alternative = "greater"   -> upper-tailed test    (Ha: mu > 0)
#   alternative = "two.sided" -> two-tailed test      (Ha: mu != 0)
