################################################################################
#### Homework 10, Math Test Scores Problem                                  ####
################################################################################

## Copy and paste the lines into an R Script window to read the data into RStudio.  

math <- read.csv("https://tinyurl.com/zzneb4rf")
math$location <- as.factor(math$location)
