############# Before you start, run lines 1-10 of code. #############

## Read in the data. 
cardio <- read.csv("https://www.crc.nd.edu/~jwaddell/ITAO20200/Data/CardioFitness.csv",
                   stringsAsFactors = TRUE)

cardio$education <- factor(cardio$education, levels=c("High School Deg", 
                          "Some College","College Degree", "Master's Degree", 
                          "PhD"))

############################################################

########## Frequency Tables ##########

## Find frequencies for the following variables in the cardio data set:
## cardio$gender, cardio$education, cardio$marital_status, cardio$usage
## Put a marginal total on your tables.

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Creating Frequency Tables.

## Recall that R is case sensitive. Note that all letters are lowercase. 
## Put your code in the empty space below.





########## Relative Frequency Tables ##########

## Find relative frequencies for the following variables in the cardio data set:
## cardio$gender, cardio$education, cardio$marital_status, cardio$usage

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Relative Frequencies.

## Recall that R is case sensitive. Note that all letters are lowercase. 
## Put your code in the empty space below.





########## Cumulative Relative Frequencies for cardio$education ##########

## Find cumulative relative frequencies for the cardio$education variable.

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Cumulative Frequencies.

## Recall that R is case sensitive. Note that all letters are lowercase. 
## Put your code in the empty space below.





########## Crosstabulation Tables ##########

## Create the following crosstabulation tables. Put in a command that
## will display marginal sums on each of your tables.

## cardio$gender (rows) and cardio$education (columns);
## cardio$gender (rows) and cardio$usage (columns);
## cardio$marital_status (rows) and cardio$usage (columns)

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Crosstabulation Tables.

## Recall that R is case sensitive. All letters are lowercase.
## Put your codes in the empty space below.





########## Descriptive Quantitative Statistics ##########

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the sections called Measures of Central Tendency or
## Measures of Dispersion. 


## Find the mean for cardio$fitness
## Put your code in the empty space below.




## Find the median for cardio$fitness
## Put your code in the empty space below.




## Find the standard deviation for cardio$fitness
## Put your code in the empty space below.





########## Layered Means Tables ##########

## Create the following layered means tables:
## cardio$fitness averages according to levels of cardio$gender
## cardio$fitness averages according to levels of cardio$education;
## cardio$fitness averages according to levels of cardio$usage

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Descriptive Statistics for Specific Groups.

## Recall that R is case sensitive. All letters are lowercase.
## Put your codes in the empty space below.





## You have written all the code needed to answer the questions in ICA 1.

## OPTIONAL, BUT HIGHLY RECOMMENDED: Compile a Report.

## If you would like to compile a report that marries together your code with
## the output it generates, follow these instructions. 

## 1. Under the File menu, select "Compile Report."

## 2. Choose the HTML output format for this assignment.

## 3. R may ask you to install packages; if so, click on "yes" and let it install
## the needed packages.

## 4. The report will be created after the package installation and will be 
## automatically saved in the same working directory as your code file (which,
## if you followed instructions at the beginning, should be in your Project
## folder on Google Drive).