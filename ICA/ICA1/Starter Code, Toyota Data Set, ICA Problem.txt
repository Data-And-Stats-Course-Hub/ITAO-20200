########## Before you start, run lines 1-16 of code. ##########

## Read in the data. 
Toyota <- read.csv("https://mendoza-stats.s3.amazonaws.com/toyota.csv",
                   stringsAsFactors = TRUE)


## Perform some data management techniques.
## Transform these variables into factors.
Toyota$Automatic_Lock <- factor(Toyota$Automatic_Lock, 
                                levels=c(0,1), labels=c("No","Yes"))

Toyota$Power_Windows <- factor(Toyota$Power_Windows, 
                               levels=c(0,1), labels=c("No","Yes"))

############################################################

########## Frequencies for Toyota$Color ##########

## Find frequencies for the Toyota$Color variable.
## Recall that R is case sensitive.
## Note that T in Toyota and C in Color are UPPERCASE. 

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Creating Frequency Tables.

## Put your code in the empty space below.





########## Relative Frequencies for Toyota$Color ##########

## Find relative frequencies for the Toyota$Color variable.
## Recall that R is case sensitive.
## Note that T in Toyota and C in Color are UPPERCASE. 

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Relative Frequencies.

## Put your code in the empty space below.





########## Cumulative Relative Frequencies for Toyota$Color ##########

## Find cumulative relative frequencies for the Toyota$Color variable.
## Recall that R is case sensitive.
## Note that T in Toyota and C in Color are UPPERCASE. 

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Relative Frequencies.

## Put your code in the empty space below.





########## Crosstabulation Table ##########

## Create a crosstabulation table for Toyota$Automatic_Lock and
## Toyota$Power_Windows. Put automatic lock information in rows
## and power window information in columns.
## Add marginal sums to your table.

## DO NOT run a 'factor' command on these variables. It was already
## performed in the starter code.

## If you need assistance, go to "Tabular Displays in R"
## and look at the section called Crosstabulation Tables.

## Put your code in the empty space below.





########## Grouped Frequency Distribution ##########

## READ ALL DIRECTIONS IN THIS SECTION BEFORE JUMPING IN!! SERIOUSLY, DO IT.

## Create a grouped frequency distribution for Toyota$AgeinMonths.
## Recall that R is case sensitive.
## Note that T in Toyota, A in Age, and M in Months are UPPERCASE. 


## FIRST, find the minimum value for Toyota$AgeinMonths.




## SECOND, find the maximum value for Toyota$AgeinMonths.




## THIRD, create the grouped frequency distribution.
## (Note: partially written code below starts with a `table` command.)

## Inside `seq`, change the first ? to the minimum value, 
## change the second ? to the maximum value **plus 1**, and  
## leave 10 as the interval width. Then, run the command. 

## If you more need assistance, go to "Tabular Displays in R"
## and look at the section called Grouped Frequency Distributions.

table(cut(Toyota$AgeinMonths, seq(?,?,10), include.lowest = TRUE))


## Repeat the process of changing the values inside the `seq` function, 
## this time to create a cumulative frequency distribution for 
## Toyota$AgeinMonths. **Remember to add 1 to the maximum value!**

cumsum(table(cut(Toyota$AgeinMonths, seq(?,?,10), include.lowest = TRUE)))


########## Descriptive Statistics for Toyota$Miles ##########

## Recall that R is case sensitive.
## Note that T in Toyota and M in Miles are UPPERCASE. 

## Find the mean for Toyota$Miles

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Measures of Central Tendency.

## Put your code in the empty space below.





## Find the median for Toyota$Miles

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Measures of Central Tendency.

## Put your code in the empty space below.





## Find the range for Toyota$Miles

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Measures of Dispersion.

## Put your code in the empty space below.






## Find the standard deviation for Toyota$Miles

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Measures of Dispersion.

## Put your code in the empty space below.






########## Layered Means Table for Toyota$Miles ##########

## READ ALL DIRECTIONS IN THIS SECTION BEFORE JUMPING IN!! YEP, AGAIN.

## Recall that R is case sensitive. Note that the M in Miles,  
## and A in Automatic, and L in Lock are all UPPERCASE.

## Create a layered means table for Toyota$Miles by the categories
## of Toyota$Automatic_Lock.

## If you need assistance, go to "Basic Numerical Descriptive Statistics in R"
## and look at the section called Descriptive Statistics for Specific Groups.
## Find the part that talks about the `by` command.


## NOTE: YOU DO NOT NEED TO RUN THE FACTOR COMMAND ON Toyota$Automatic_Lock.
## It was already run in lines 10-11. 


## Note that Toyota$Miles is your dependent variable, similar to 
## Toyota$AskingPrice from the example in the guide. 

## Toyota$Automatic_Lock is your factor, similar to Toyota$ABS from 
## the example in the guide.

## Put your code in the empty space below.




## You have written all the code needed to answer the questions in ICA 1.

## OPTIONAL: Compile a Report.

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