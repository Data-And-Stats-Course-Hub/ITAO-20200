################################################################################
#### Correlation and Simple Linear Regression                               ####
#### ITAO 20200: Statistical Inference in Business                          ####
####                                                                        ####
#### Code sheet to go with the "R: Correlation and Simple Linear            ####
#### Regression" guide. Run the lines in order from top to bottom.          ####
####                                                                        ####
#### Example: predicting the asking price of a house (Price) from the       ####
#### number of bedrooms in that house (Bedrooms).                           ####
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
head(Housing, n = 5)   # first 5 rows
tail(Housing, n = 5)   # last 5 rows


#===============================================================================
# Some Basic Descriptive Statistics (base R, no packages needed)
#===============================================================================
sapply(Housing[, c("Price", "Bedrooms")],   # the variables we want to describe
       function(x) c(n = length(x),         # sample size
                     mean = mean(x),        # sample mean
                     sd = sd(x),            # sample standard deviation
                     min = min(x),          # minimum
                     max = max(x)))         # maximum


#===============================================================================
# Scatter plot of Asking Price on Number of Bedrooms
#===============================================================================
plot(x = Housing$Bedrooms,                         # our x variable
     y = Housing$Price,                            # the y variable
     xlab = "Number of Bedrooms",                  # label the x-axis
     ylab = "Asking Price",                        # label the y-axis
     main = "Asking Price and Number of Bedrooms") # scatter diagram title


#===============================================================================
# Correlation and Test for Correlation
#===============================================================================
# cor_matrix() is a course function written in base R. It prints the
# correlation matrix, the sample size, and the p-values for H0: rho = 0.
#
# IMPORTANT: the source() line loads the function from the course website and
# MUST be run BEFORE the cor_matrix() line (an internet connection is required).
# If you skip it, R will say: could not find function "cor_matrix".

source("https://data-and-stats-course-hub.github.io/ITAO-20200/R-Guides-and-Codes/cor_matrix.R")

cor_matrix(Housing[, c("Price", "Bedrooms")])   # a table of x and y observations


#===============================================================================
# Simple Linear Regression
#===============================================================================

# Fit the regression model and save it in an object
Housing_model <- lm(Price ~ Bedrooms, # Linear regression formula: y ~ x
                    data = Housing)   # Name of the dataset

# ols_regress_mod() is the course version of olsrr's ols_regress(). 
#
# IMPORTANT: BOTH the library() line AND the source() line MUST be run BEFORE
# the ols_regress_mod() line, in this order:
#   1. library(olsrr)        loads the olsrr package (install it first if needed;
#                            see the setup section at the top of this sheet)
#   2. source(...)           loads ols_regress_mod() from the course website
#   3. ols_regress_mod(...)  prints the Model Summary, ANOVA table, and
#                            Parameter Estimates for your saved model

library(olsrr)

source("https://data-and-stats-course-hub.github.io/ITAO-20200/R-Guides-and-Codes/ols_regress_mod.R")

ols_regress_mod(Housing_model) # Use the name of your saved model as your input


#===============================================================================
# Practice on Your Own: Price predicted from SqrFoot
#===============================================================================
# Repeat the steps above with SqrFoot as the x variable. The source() lines do
# not need to be run again in the same R session.
#
# plot(x = Housing$SqrFoot, y = Housing$Price,
#      xlab = "Square Footage", ylab = "Asking Price",
#      main = "Asking Price and Square Footage")
#
# cor_matrix(Housing[, c("Price", "SqrFoot")])
#
# SqrFoot_model <- lm(Price ~ SqrFoot, data = Housing)
# ols_regress_mod(SqrFoot_model)
