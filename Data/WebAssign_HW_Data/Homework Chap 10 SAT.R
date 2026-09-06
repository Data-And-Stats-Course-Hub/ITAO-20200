################################################################################
#### Homework 10, SAT Scores Problem                                        ####
################################################################################

## Copy and paste the lines into an R Script window to read the data into RStudio.  

sat <- read.csv("https://github.com/Data-And-Stats-Course-Hub/ITAO-20200/raw/refs/heads/main/Data/WebAssign_HW_Data/SAT.csv")
sat$group <- as.factor(sat$group)
