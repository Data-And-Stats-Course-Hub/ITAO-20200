################################################################################
#### Homework 10, Math Test Scores Problem                                  ####
################################################################################

## Copy and paste the lines into an R Script window to read the data into RStudio.  

math <- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/MathTestScores.csv")
math$location <- as.factor(math$location)