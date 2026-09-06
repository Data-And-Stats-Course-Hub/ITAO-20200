################################################################################
#### Homework 14, NFL Passing                                               ####
################################################################################

# Paste all the code below into a script window and run it to perform the regression. 

nflpassing_r<- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/nflpassing_r.csv")

Passing_model <- lm(Win ~ Yds,            # Linear regression formula
                   data = nflpassing_r)   # Name of the dataset

library(olsrr)
source("https://github.com/Data-And-Stats-Course-Hub/ITAO-20200/raw/refs/heads/main/Data/WebAssign_HW_Data/ols_regress_mod.R")

ols_regress_mod(Passing_model)
