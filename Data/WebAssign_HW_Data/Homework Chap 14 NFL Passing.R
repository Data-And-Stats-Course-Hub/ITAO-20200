################################################################################
#### Homework 14, NFL Passing                                               ####
################################################################################

# Paste all the code below into a script window and run it to perform the regression. 

nflpassing_r<- read.csv("https://tinyurl.com/9xjtrknw")

Passing_model <- lm(Win ~ Yds,            # Linear regression formula
                   data = nflpassing_r)   # Name of the dataset

library(olsrr)
source("https://tinyurl.com/4wjwzz4v")

ols_regress_mod(Passing_model)
