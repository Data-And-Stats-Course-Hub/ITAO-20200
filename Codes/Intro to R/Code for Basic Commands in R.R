#########################
## Basic Commands in R ##
#########################

x <- c(14, 5, 12, 11, 10, 23, 18, 27)
x
sum(x)
mean(x)
median(x)
sort(x)
sort(x, decreasing = TRUE)
quantile(x, probs = c(0.25, 0.75, 0.90))
min(x)
max(x)
range(x)
var(x)
sd(x)
summary(x)


#####################################################
## Two Variables and Bivariate Statistics Commands ##
#####################################################

y <- c(55, 75, 34, 66, 56, 90, 61, 49)
x # Values for x.
y # Values for y. 
x + y
x * (y + 2)
sum(y - x)^2 

cor(x, y)
cov(x, y)


############################################
## Creating and Working with a Data Frame ##
############################################

students <- c("Jen", "Francis", "Mary", "Josie")
gender <- c("F", "M", "F", "F")
age <- c(45, 28, 40, 26)
marital_stat <- c("Married", "Married", "Married", "Not Married")

classlist <- data.frame(students, gender, age, marital_stat)

names(classlist) # provides the variable names in the data frame
head(classlist)

classlist$age # lists all student ages
classlist[1, 3] # finds the value of cell (1,3) (first row, third column)
classlist[2, ] # lists the second row; blank space after comma indicates all columns
classlist[ , c(1,3)] # blank space before comma indicates rows should be used; then it retrieves first and third column values 
dim(classlist) # gives the data frame's dimensions (4 rows, 4 columns)

table(gender, marital_stat)

classlist[classlist$gender == "F" & classlist$age < 30, ]

classlist[classlist$gender == "M" | classlist$age > 30, ]

