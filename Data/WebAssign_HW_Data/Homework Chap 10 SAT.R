################################################################################
#### Homework 10, SAT Scores Problem                                        ####
################################################################################

## Copy and paste the lines into an R Script window to read the data into RStudio.  

sat <- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/WebAssign_HW_Data/SAT.csv")
sat$group <- as.factor(sat$group)
