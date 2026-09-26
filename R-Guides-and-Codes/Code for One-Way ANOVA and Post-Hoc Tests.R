#################################################################
# One-Way ANOVA and Post-Hoc Tests
# ITAO 20200: Foundations of Statistics
# J. S. Akosa, F. Bilson Darku, J. Waddell
#################################################################


# ---- Data Entry -----------------------------------------------

Grades <- read.csv("https://mendoza-stats.s3.amazonaws.com/grades.csv")
head(Grades, n = 3) # First 3 observations
tail(Grades, n = 3) # Last 3 observations


# ---- Transform the Grouping Variable into a Factor ------------

Grades$Teacher <- factor(Grades$Teacher, levels = c(1, 2, 3),
                         labels = c("Dr. NiceGuy", "Dr. Funny", "Dr. Genius"))

# Check the data after the transformation
head(Grades, n = 3) # First 3 observations
tail(Grades, n = 3) # Last 3 observations


# ---- Some Basic Descriptive Statistics ------------------------
# Dependent var, Independent var, statistic
by(Grades$Final, Grades$Teacher, mean)    
by(Grades$Final, Grades$Teacher, sd)      
by(Grades$Final, Grades$Teacher, length)  

# ---- More Advanced Code for Summary Statistics ----------------

by(Grades$Final, Grades$Teacher, function(x) {
  c(n      = length(x),
    mean   = round(mean(x), 2),
    sd     = round(sd(x), 2),
    median = round(median(x), 2),
    min    = min(x),
    max    = max(x),
    se     = round(sd(x) / sqrt(length(x)), 2))
})


# ---- One-Way ANOVA Test ---------------------------------------

# One-way ANOVA for Final scores and Teacher
Grades.ANOVA <- aov(Grades$Final ~ Grades$Teacher) # Save results into an object
summary(Grades.ANOVA) # summary() function displays the results of the analysis


# ---- Post-Hoc: Tukey's HSD ------------------------------------

TukeyHSD(Grades.ANOVA,        # Takes the fitted ANOVA as an argument
         conf.level = 0.95)   # confidence level = 1 - alpha


# ---- Post-Hoc: Unadjusted Fisher's LSD ------------------------

pairwise.t.test(Grades$Final,               # dependent variable
                Grades$Teacher,             # independent variable
                p.adjust.method = "none",   # "none" means unadjusted LSD
                alternative = "two.sided")


# ---- Post-Hoc: Bonferroni Adjusted LSD ------------------------

pairwise.t.test(Grades$Final,                     # dependent variable
                Grades$Teacher,                   # independent variable
                p.adjust.method = "bonferroni",   # Bonferroni adjusted LSD
                alternative = "two.sided")


# ---- Practice on Your Own -------------------------------------

PaintDrying <- read.csv("https://mendoza-stats.s3.amazonaws.com/paintdrying.csv")
