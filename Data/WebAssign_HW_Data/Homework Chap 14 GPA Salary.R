################################################################################
#### Homework 14, GPA Salary                                                ####
################################################################################

# Choose the block of code that matches the dataset identified in your problem.
# Paste it all into a script window and run it to perform the regression.


## gpasalary_r1
gpasalary_r1<- read.csv("https://tinyurl.com/mr284674")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r1)   # Name of the dataset
library(olsrr)
source("https://tinyurl.com/4wjwzz4v")
ols_regress_mod(Salary_model)


## gpasalary_r2
gpasalary_r2<- read.csv("https://tinyurl.com/bddapb39")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r2)   # Name of the dataset
library(olsrr)
source("https://tinyurl.com/4wjwzz4v")
ols_regress_mod(Salary_model)



## gpasalary_r3
gpasalary_r3<- read.csv("https://tinyurl.com/3wn5tnyn")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r3)   # Name of the dataset
library(olsrr)
source("https://tinyurl.com/4wjwzz4v")
ols_regress_mod(Salary_model)



## gpasalary_r4
gpasalary_r4<- read.csv("https://tinyurl.com/y4fh4dbs")
Salary_model <- lm(Salary ~ GPA,          # Linear regression formula
                   data = gpasalary_r4)   # Name of the dataset
library(olsrr)
source("https://tinyurl.com/4wjwzz4v")
ols_regress_mod(Salary_model)
