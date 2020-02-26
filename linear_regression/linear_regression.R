#  Introduction
## ══════════════

#   • Learning objectives:
##     • Learn the R formula interface
##     • Specify factor contrasts to test specific hypotheses
##     • Perform model comparisons
##     • Run and interpret variety of regression models in R

# load needed packages and install them if they do not exist
easypackages::packages("tidyverse", prompt = F)

## Set working directory
## ─────────────────────────

##   It is often helpful to start your R session by setting your working
##   directory so you don't have to type the full path names to your data
##   and other files

# set the working directory
# setwd("~/Desktop/Rstatistics")
# setwd("C:/Users/dataclass/Desktop/Rstatistics")

##   You might also start by listing the files in your working directory

getwd() # where am I?
list.files("dataSets") # files in the dataSets folder

## Load the states data
## ────────────────────────

# read the states data
states.data <- readRDS("linear_regression/dataSets/states.rds")
str(states.data)
# get labels ?????????????????????????????????????????
# There is feature called attributes in R, it is like properties for dataframe
# beside the columns like length, names, etc...
# You can consider it as a metadate for the dataframe and here he is using
# two of these meta data and make of them a seprate dataframe.
#You can find more info about that here:
# http://uc-r.github.io/dataframes_attributes
states.info <-
  data.frame(attributes(states.data)[c("names", "var.labels")])
str(states.info)
#look at last few labels
tail(states.info, 8)

## Linear regression
## ═══════════════════

## Examine the data before fitting models
## ──────────────────────────────────────────

##   Start by examining the data to check for problems.

# summary of expense and csat columns, all rows
sts.ex.sat <- subset(states.data, select = c("expense", "csat"))
summary(sts.ex.sat)
# correlation between expense and csat
cor(sts.ex.sat)

## Plot the data before fitting models
## ───────────────────────────────────────

##   Plot the data to look for multivariate outliers, non-linear
##   relationships etc.

# scatter plot of expense vs csat
plot(sts.ex.sat)

## Linear regression example
## ─────────────────────────────

##   • Linear regression models can be fit with the `lm()' function
##   • For example, we can use `lm' to predict SAT scores based on
##     per-pupal expenditures:

# Fit our regression model
sat.mod <- lm(csat ~ expense, # regression formula
              data = states.data) # data set
# Summarize and print the results
summary(sat.mod) # show regression coefficients table

## Why is the association between expense and SAT scores /negative/?
## ─────────────────────────────────────────────────────────────────────

##   Many people find it surprising that the per-capita expenditure on
##   students is negatively related to SAT scores. The beauty of multiple
##   regression is that we can try to pull these apart. What would the
##   association between expense and SAT scores be if there were no
##   difference among the states in the percentage of students taking the
##   SAT?

summary(lm(csat ~ expense + percent, data = states.data))

## The lm class and methods
## ────────────────────────────

##   OK, we fit our model. Now what?
##   • Examine the model object:                             ???????????????????
## Examining model object here is just exploring what fields/attributes
## inside it for later uasage
class(sat.mod)
names(sat.mod)
methods(class = class(sat.mod))[1:9]

##   • Use function methods to get more information about the fit
### what is 2.5% values and 97.5% values ????????????
## If you remember in the statistics course, these are the limits of the famous
## bell shape and it shows here how much condifent we are within those limits
## (hypothesis test).
## a quick refresher and more information here:
## ?confint (r help) and here:
## https://www.econometrics-with-r.org/5-3-rwxiabv.html
## https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/hypothesis-testing/
confint(sat.mod)
# hist(residuals(sat.mod))

## Linear Regression Assumptions
## ─────────────────────────────────

##   • Ordinary least squares regression relies on several assumptions,
##     including that the residuals are normally distributed and
##     homoscedastic, the errors are independent and the relationships are
##     linear.

##   • Investigate these assumptions visually by plotting your model: ????????????????????????????????

par(mar = c(4, 4, 2, 2), mfrow = c(1, 2)) #optional
####don't understand the p;ot result ?????????????
## As you are a normal human, it is a normal questions :D.
## These plots are analysis tools to check if your model is right or there is
## something wrong. A detailed explanation about these plots is here:
## http://www.contrib.andrew.cmu.edu/~achoulde/94842/homework/regression_diagnostics.html
## https://data.library.virginia.edu/diagnostic-plots/
## https://www.theanalysisfactor.com/linear-models-r-diagnosing-regression-model/
## http://www.sthda.com/english/wiki/qq-plots-quantile-quantile-plots-r-base-graphs
## https://data.library.virginia.edu/understanding-q-q-plots/
## https://www.dummies.com/programming/r/how-to-use-quantile-plots-to-check-data-normality-in-r/
## https://online.stat.psu.edu/stat462/node/117/
## https://medium.com/data-distilled/residual-plots-part-1-residuals-vs-fitted-plot-f069849616b1
## https://stats.stackexchange.com/questions/76226/interpreting-the-residuals-vs-fitted-values-plot-for-verifying-the-assumptions
## http://docs.statwing.com/interpreting-residual-plots-to-improve-your-regression/
##
plot(sat.mod, which = c(1, 2)) # "which" argument optional

## Comparing models
## ────────────────────

##   Do congressional voting patterns predict SAT scores over and above
##   expense? Fit two models and compare them:

# fit another model, adding house and senate as predictors
sat.voting.mod <-  lm(csat ~ expense + house + senate,
                      data = na.omit(states.data))
sat.mod <- update(sat.mod, data = na.omit(states.data))
# compare using the anova() function
# don't understand the output ????????????????????????????????????????????????
## ANOVA or Analysis of Variance, is a very effiecient way to compare between
## two models. It is a statistical method and an important topic to understand.
## Kindly check:
## https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/hypothesis-testing/anova/
## https://www.spss-tutorials.com/anova-what-is-it/
## https://statistics.laerd.com/statistical-guides/one-way-anova-statistical-guide.php
## https://www.guru99.com/r-anova-tutorial.html
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
## https://www.statmethods.net/stats/anova.html
## http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf
anova(sat.mod, sat.voting.mod)
coef(summary(sat.voting.mod))

## Exercise: least squares regression
## ────────────────────────────────────────

##   Use the /states.rds/ data set. Fit a model predicting energy consumed
##   per capita (energy) from the percentage of residents living in
##   metropolitan areas (metro). Be sure to
##   1. Examine/plot the data before fitting the model
plot(states.data$energy, states.data$metro)
##   2. Print and interpret the model `summary'
energyModel <- lm(energy ~ metro, data = states.data)
summary(energyModel)
##   3. `plot' the model to look for deviations from modeling assumptions  ??????????????????????????????
## Refer to above answer :)
plot(energyModel)
##   Select one or more additional predictors to add to your model and
##   repeat steps 1-3. Is this model significantly better than the model
##   with /metro/ as the only predictor?
##   1. Examine/plot the data before fitting the model
plot(states.data$energy, states.data$green)
##   2. Print and interpret the model `summary'
#  why when removing insignificant vars R-squared decrease????????????????????????????????
## Removing any variable from the model will affect it somehow and it is both
## statistical and business decision
## A detailed answer is here:
## https://stats.stackexchange.com/questions/413606/when-to-remove-insignificant-variables
## https://www.theanalysisfactor.com/insignificant-effects-in-model/
## https://www.quora.com/In-laymans-terms-why-is-dropping-insignificant-predictors-from-a-regression-model-a-bad-idea
## https://www.statalist.org/forums/forum/general-stata-discussion/general/1489842-removing-insignificant-variables
energyModel2 <-
  lm(energy ~ metro + green + toxic, data = states.data)
summary(energyModel2)
##   3. `plot' the model to look for deviations from modeling assumptions
plot(energyModel2)

## Interactions and factors
## ══════════════════════════

## Modeling interactions
## ─────────────────────────

##   Interactions allow us assess the extent to which the association
##   between one predictor and the outcome depends on a second predictor.
##   For example: Does the association between expense and SAT scores
##   depend on the median income in the state?

#Add the interaction to the model
sat.expense.by.percent <- lm(csat ~ expense * income,
                             data = states.data)
#Show the results
coef(summary(sat.expense.by.percent)) # show regression coefficients table

## Regression with categorical predictors
## ──────────────────────────────────────────

##   Let's try to predict SAT scores from region, a categorical variable.
##   Note that you must make sure R does not think your categorical
##   variable is numeric.

# make sure R knows region is categorical
str(states.data$region)
# what changed in region ???????????????????????????????????????????????
## Oh, alot.  Now we do not consider region a numeric field but a categorical
## field. That means we will do categorical statical analysis which is different
## totally from numerical analysis, see here:
## http://www.sthda.com/english/articles/40-regression-analysis/163-regression-with-categorical-variables-dummy-coding-essentials-in-r/
## https://psu-psychology.github.io/r-bootcamp-2018/talks/anova_categorical.html
## https://www.guru99.com/r-factor-categorical-continuous.html
## https://support.minitab.com/en-us/minitab-express/1/help-and-how-to/modeling-statistics/regression/supporting-topics/basics/what-are-categorical-discrete-and-continuous-variables/
## https://www.researchgate.net/post/Which_statistical_test_will_be_the_most_appropriate_to_find_association_between_a_numerical_variable_and_a_categorical_variable
states.data$region <- factor(states.data$region)
#Add region to the model
sat.region <- lm(csat ~ region,
                 data = states.data)
#Show the results
coef(summary(sat.region)) # show regression coefficients table
anova(sat.region) # show ANOVA table

##   Again, *make sure to tell R which variables are categorical by
##   converting them to factors!*

## Setting factor reference groups and contrasts
## ─────────────────────────────────────────────────

##   In the previous example we use the default contrasts for region. The
##   default in R is treatment contrasts, with the first level as the
##   reference. We can change the reference group or use another coding
##   scheme using the `C' function.????????????????????????????????????????????????????????????????????
### It is just another way of coding, you will find your answer in the links in
### previous question

# print default contrasts???????????????
contrasts(states.data$region)
# change the reference group?????????????????
coef(summary(lm(csat ~ C(region, base = 4),
                data = states.data)))
# change the coding scheme???????????????????
coef(summary(lm(csat ~ C(
  region, contr.helmert
),
data = states.data)))

### ok, it is a compsite thing:
### 1. You can think of it as priority (which is the most important factor level
### to take into consideration)
### 2. Coding schema is just another way of representation/interpretation
### https://rcompanion.org/rcompanion/h_01.html
### https://faculty.nps.edu/sebuttre/home/R/contrasts.html
### https://rstudio-pubs-static.s3.amazonaws.com/65059_586f394d8eb84f84b1baaf56ffb6b47f.html
##   See also `?contrasts', `?contr.treatment', and `?relevel'.

## Exercise: interactions and factors
## ────────────────────────────────────────

##   Use the states data set.

##   1. Add on to the regression equation that you created in exercise 1 by
##      generating an interaction term and testing the interaction.
#for sure my answer is wrong
#energyModel2 <- lm(energy ~ metro + green + toxic, data = states.data)

x <- coef(energyModel2)
y <- x[1] + x[2] * states.data$metro + x[3] * states.data$green +
  x[4] * states.data$toxic +
  x[2] * x[3] * states.data$metro * states.data$green +
  x[2] * x[4] * states.data$metro * states.data$toxic +
  x[3] * x[4] * states.data$green * states.data$toxic +
  x[2] * x[3] * x[4] * states.data$metro * states.data$green * states.data$toxic

##   2. Try adding region to the model. Are there significant differences
##      across the four regions?
# only 3 regions appear ??????????????????
### yeah as they are the most important, I hope the above links will clarify
## that more
energyModel3 <-
  lm(energy ~ metro + green + toxic + region, data = states.data)
summary(energyModel3)
