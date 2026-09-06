################################################################################
#### Homework 14, GPA Salary                                                ####
################################################################################

# Choose the block of code that matches the dataset identified in your problem.
# Paste it all into a script window and run it to perform the regression.


## gpasalary_r1
gpasalary_r1<- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/gpasalary_r1.csv")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r1)   # Name of the dataset
library(olsrr)
source("https://www.crc.nd.edu/~jakosa/ITAO_20200/R_Guides/ols_regress_mod.R")
ols_regress_mod(Salary_model)


## gpasalary_r2
gpasalary_r2<- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/gpasalary_r2.csv")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r2)   # Name of the dataset
library(olsrr)
source("https://www.crc.nd.edu/~jakosa/ITAO_20200/R_Guides/ols_regress_mod.R")
ols_regress_mod(Salary_model)



## gpasalary_r3
gpasalary_r3<- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/gpasalary_r3.csv")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r3)   # Name of the dataset
library(olsrr)
source("https://www.crc.nd.edu/~jakosa/ITAO_20200/R_Guides/ols_regress_mod.R")
ols_regress_mod(Salary_model)



## gpasalary_r4
gpasalary_r4<- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/gpasalary_r4.csv")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r4)   # Name of the dataset
library(olsrr)
source("https://www.crc.nd.edu/~jakosa/ITAO_20200/R_Guides/ols_regress_mod.R")
ols_regress_mod(Salary_model)
