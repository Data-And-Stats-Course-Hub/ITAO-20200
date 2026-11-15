################################################################################
#### Multiple Regression Analysis                                           ####
#### ITAO 20200: Statistical Inference in Business                          ####
####                                                                        ####
#### Code sheet to go with the Multiple Regression guide. Run the lines in  ####
#### order from top to bottom.                                              ####
####                                                                        ####
#### Example: predicting the asking price of a house (Price) from its       ####
#### square footage (SqrFoot), age (Age), and number of bedrooms (Bedrooms).####
################################################################################


#===============================================================================
# One-time setup: the olsrr package
#===============================================================================
# The regression output below needs the olsrr package. It is ALREADY installed
# on the classroom computers, so you do not need to do anything there.
#
# On your OWN computer, run the install line ONCE. Remove the # at the start of
# the line, run it, then put the # back (a package only needs to be installed
# once per machine, but it must be loaded with library() every session).

# install.packages("olsrr")


#===============================================================================
# Importing the data set
#===============================================================================
Housing <- read.csv("https://mendoza-stats.s3.amazonaws.com/housingprices.csv")
head(Housing, n = 10)   # first 10 rows
tail(Housing, n = 10)   # last 10 rows


#===============================================================================
# Some Basic Descriptive Statistics (base R, no packages needed)
#===============================================================================
# Housing has only numeric columns, so we can describe the whole data set.
# For a data set with text columns, list the numeric ones instead, e.g.
# Housing[, c("Price", "SqrFoot", "Age", "Bedrooms")].
sapply(Housing,                              # the variables we want to describe
       function(x) c(n = length(x),          # sample size
                     mean = mean(x),         # sample mean
                     sd = sd(x),             # sample standard deviation
                     min = min(x),           # minimum
                     max = max(x)))          # maximum


#===============================================================================
# Correlation Matrix and Tests for Correlation
#===============================================================================
# cor_matrix() is a course function written in base R. It prints the
# correlation matrix, the sample size, and the p-values for H0: rho = 0 for
# EVERY pair of variables. Correlations among the predictors (SqrFoot, Age,
# Bedrooms) are the intercorrelations; high values signal multicollinearity.
#
# IMPORTANT: the source() line loads the function from the course website and
# MUST be run BEFORE the cor_matrix() line (an internet connection is required).
# If you skip it, R will say: could not find function "cor_matrix".

source("https://data-and-stats-course-hub.github.io/ITAO-20200/R-Guides-and-Codes/cor_matrix.R")

cor_matrix(Housing[, c("Price", "SqrFoot", "Age", "Bedrooms")])  # variable names in quotes


#===============================================================================
# Multiple Regression Model
#===============================================================================
# Fit the model and save it in an object. The dependent variable goes to the
# LEFT of the tilde (~); the independent variables go to the RIGHT, joined by
# plus signs. data = Housing tells R where to find the variables.
MultiRegHousing.model <- lm(Price ~ SqrFoot + Age + Bedrooms, data = Housing)

# ols_regress_mod() is the course version of olsrr's ols_regress(). It corrects
# the MSE and RMSE in the Model Summary so they match the ANOVA table.
#
# IMPORTANT: BOTH the library() line AND the source() line MUST be run BEFORE
# the ols_regress_mod() line, in this order:
#   1. library(olsrr)        loads the olsrr package (install it first if needed;
#                            see the setup section at the top of this sheet)
#   2. source(...)           loads ols_regress_mod() from the course website
#   3. ols_regress_mod(...)  prints the Model Summary, ANOVA table (omnibus F),
#                            and Parameter Estimates (one t test per predictor)

library(olsrr)

source("https://data-and-stats-course-hub.github.io/ITAO-20200/R-Guides-and-Codes/ols_regress_mod.R")

ols_regress_mod(MultiRegHousing.model) # Use the name of your saved model as your input


#===============================================================================
# Collinearity Diagnostics: Tolerance and VIF
#===============================================================================
# ols_vif_tol() is in the olsrr package, so library(olsrr) above must already
# have been run. Tolerance = 1 - R-squared from regressing that predictor on
# the other predictors; VIF = 1 / Tolerance.
ols_vif_tol(MultiRegHousing.model)


#===============================================================================
# Optional: a picture of the correlation matrix
#===============================================================================
# This needs the corrplot package, which is NOT required for the course. If you
# want to try it on your own computer, remove the # from the install line, run
# it once, then put the # back.

# install.packages("corrplot")
# library(corrplot)
# corrplot.mixed(cor(Housing))
