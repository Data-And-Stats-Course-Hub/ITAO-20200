################################################################################
#### Homework 10, Math Test Scores Problem                                  ####
################################################################################

## Copy and paste the lines into an R Script window to read the data into RStudio.  

math <- read.csv("https://github.com/Data-And-Stats-Course-Hub/ITAO-20200/raw/refs/heads/main/Data/WebAssign_HW_Data/MathTestScores.csv")
math$location <- as.factor(math$location)
