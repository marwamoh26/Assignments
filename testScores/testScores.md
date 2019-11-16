reading test scores
================
Marwa Mohamed
11/13/2019

## overview

The Programme for International Student Assessment (PISA) is a test
given every three years to 15-year-old students from around the world to
evaluate their performance in mathematics, reading, and science. This
test provides a quantitative way to compare the performance of students
from different parts of the world. In this homework assignment, we will
predict the reading scores of students from the United States of America
on the 2009 PISA exam.

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

### 0: Load the data in RStudio

``` r
pisa_train = read_csv("data/pisa2009train.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   raceeth = col_character()
    ## )

    ## See spec(...) for full column specifications.

``` r
str(pisa_train)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 3663 obs. of  24 variables:
    ##  $ grade                : num  11 11 9 10 10 10 10 10 9 10 ...
    ##  $ male                 : num  1 1 1 0 1 1 0 0 0 1 ...
    ##  $ raceeth              : chr  NA "White" "White" "Black" ...
    ##  $ preschool            : num  NA 0 1 1 1 1 0 1 1 1 ...
    ##  $ expectBachelors      : num  0 0 1 1 0 1 1 1 0 1 ...
    ##  $ motherHS             : num  NA 1 1 0 1 NA 1 1 1 1 ...
    ##  $ motherBachelors      : num  NA 1 1 0 0 NA 0 0 NA 1 ...
    ##  $ motherWork           : num  1 1 1 1 1 1 1 0 1 1 ...
    ##  $ fatherHS             : num  NA 1 1 1 1 1 NA 1 0 0 ...
    ##  $ fatherBachelors      : num  NA 0 NA 0 0 0 NA 0 NA 0 ...
    ##  $ fatherWork           : num  1 1 1 1 0 1 NA 1 1 1 ...
    ##  $ selfBornUS           : num  1 1 1 1 1 1 0 1 1 1 ...
    ##  $ motherBornUS         : num  0 1 1 1 1 1 1 1 1 1 ...
    ##  $ fatherBornUS         : num  0 1 1 1 0 1 NA 1 1 1 ...
    ##  $ englishAtHome        : num  0 1 1 1 1 1 1 1 1 1 ...
    ##  $ computerForSchoolwork: num  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ read30MinsADay       : num  0 1 0 1 1 0 0 1 0 0 ...
    ##  $ minutesPerWeekEnglish: num  225 450 250 200 250 300 250 300 378 294 ...
    ##  $ studentsInEnglish    : num  NA 25 28 23 35 20 28 30 20 24 ...
    ##  $ schoolHasLibrary     : num  1 1 1 1 1 1 1 1 0 1 ...
    ##  $ publicSchool         : num  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ urban                : num  1 0 0 1 1 0 1 0 1 0 ...
    ##  $ schoolSize           : num  673 1173 1233 2640 1095 ...
    ##  $ readingScore         : num  476 575 555 458 614 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   grade = col_double(),
    ##   ..   male = col_double(),
    ##   ..   raceeth = col_character(),
    ##   ..   preschool = col_double(),
    ##   ..   expectBachelors = col_double(),
    ##   ..   motherHS = col_double(),
    ##   ..   motherBachelors = col_double(),
    ##   ..   motherWork = col_double(),
    ##   ..   fatherHS = col_double(),
    ##   ..   fatherBachelors = col_double(),
    ##   ..   fatherWork = col_double(),
    ##   ..   selfBornUS = col_double(),
    ##   ..   motherBornUS = col_double(),
    ##   ..   fatherBornUS = col_double(),
    ##   ..   englishAtHome = col_double(),
    ##   ..   computerForSchoolwork = col_double(),
    ##   ..   read30MinsADay = col_double(),
    ##   ..   minutesPerWeekEnglish = col_double(),
    ##   ..   studentsInEnglish = col_double(),
    ##   ..   schoolHasLibrary = col_double(),
    ##   ..   publicSchool = col_double(),
    ##   ..   urban = col_double(),
    ##   ..   schoolSize = col_double(),
    ##   ..   readingScore = col_double()
    ##   .. )

``` r
pisa_test = read_csv("data/pisa2009test.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   raceeth = col_character()
    ## )
    ## See spec(...) for full column specifications.

``` r
summary(pisa_test)
```

    ##      grade            male          raceeth            preschool     
    ##  Min.   : 9.00   Min.   :0.0000   Length:1570        Min.   :0.0000  
    ##  1st Qu.:10.00   1st Qu.:0.0000   Class :character   1st Qu.:0.0000  
    ##  Median :10.00   Median :1.0000   Mode  :character   Median :1.0000  
    ##  Mean   :10.09   Mean   :0.5191                      Mean   :0.7108  
    ##  3rd Qu.:10.00   3rd Qu.:1.0000                      3rd Qu.:1.0000  
    ##  Max.   :12.00   Max.   :1.0000                      Max.   :1.0000  
    ##                                                      NA's   :21      
    ##  expectBachelors     motherHS      motherBachelors    motherWork   
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.000  
    ##  1st Qu.:1.0000   1st Qu.:1.0000   1st Qu.:0.0000   1st Qu.:0.000  
    ##  Median :1.0000   Median :1.0000   Median :0.0000   Median :1.000  
    ##  Mean   :0.7673   Mean   :0.8682   Mean   :0.3307   Mean   :0.719  
    ##  3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.000  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.000  
    ##  NA's   :23       NA's   :45       NA's   :188      NA's   :36     
    ##     fatherHS      fatherBachelors    fatherWork       selfBornUS    
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
    ##  1st Qu.:1.0000   1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:1.0000  
    ##  Median :1.0000   Median :0.0000   Median :1.0000   Median :1.0000  
    ##  Mean   :0.8484   Mean   :0.3253   Mean   :0.8435   Mean   :0.9127  
    ##  3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
    ##  NA's   :125      NA's   :288      NA's   :113      NA's   :24      
    ##   motherBornUS    fatherBornUS    englishAtHome    computerForSchoolwork
    ##  Min.   :0.000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000       
    ##  1st Qu.:1.000   1st Qu.:1.0000   1st Qu.:1.0000   1st Qu.:1.0000       
    ##  Median :1.000   Median :1.0000   Median :1.0000   Median :1.0000       
    ##  Mean   :0.766   Mean   :0.7659   Mean   :0.8652   Mean   :0.8981       
    ##  3rd Qu.:1.000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000       
    ##  Max.   :1.000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000       
    ##  NA's   :23      NA's   :58       NA's   :27       NA's   :30           
    ##  read30MinsADay   minutesPerWeekEnglish studentsInEnglish schoolHasLibrary
    ##  Min.   :0.0000   Min.   :   0.0        Min.   : 1.0      Min.   :0.0000  
    ##  1st Qu.:0.0000   1st Qu.: 225.0        1st Qu.:20.0      1st Qu.:1.0000  
    ##  Median :0.0000   Median : 250.0        Median :25.0      Median :1.0000  
    ##  Mean   :0.2828   Mean   : 264.6        Mean   :24.7      Mean   :0.9623  
    ##  3rd Qu.:1.0000   3rd Qu.: 300.0        3rd Qu.:30.0      3rd Qu.:1.0000  
    ##  Max.   :1.0000   Max.   :2025.0        Max.   :90.0      Max.   :1.0000  
    ##  NA's   :21       NA's   :103           NA's   :114       NA's   :58      
    ##   publicSchool        urban         schoolSize    readingScore  
    ##  Min.   :0.0000   Min.   :0.000   Min.   : 100   Min.   :156.4  
    ##  1st Qu.:1.0000   1st Qu.:0.000   1st Qu.: 762   1st Qu.:430.5  
    ##  Median :1.0000   Median :0.000   Median :1273   Median :499.5  
    ##  Mean   :0.9344   Mean   :0.379   Mean   :1386   Mean   :496.8  
    ##  3rd Qu.:1.0000   3rd Qu.:1.000   3rd Qu.:1900   3rd Qu.:562.7  
    ##  Max.   :1.0000   Max.   :1.000   Max.   :6694   Max.   :772.5  
    ##                                   NA's   :69

## Summarizing the dataset

``` r
#the average reading test score of males
male_average = pisa_train$readingScore %>% 
  tapply(pisa_train$male == 1, mean)
(male_average)
```

    ##    FALSE     TRUE 
    ## 512.9406 483.5325

## Missing data

``` r
#get columns with missing data
colnames(pisa_train)[colSums(is.na(pisa_train)) > 0]
```

    ##  [1] "raceeth"               "preschool"            
    ##  [3] "expectBachelors"       "motherHS"             
    ##  [5] "motherBachelors"       "motherWork"           
    ##  [7] "fatherHS"              "fatherBachelors"      
    ##  [9] "fatherWork"            "selfBornUS"           
    ## [11] "motherBornUS"          "fatherBornUS"         
    ## [13] "englishAtHome"         "computerForSchoolwork"
    ## [15] "read30MinsADay"        "minutesPerWeekEnglish"
    ## [17] "studentsInEnglish"     "schoolHasLibrary"     
    ## [19] "schoolSize"

## Removing missing values

``` r
pisa_train = na.omit(pisa_train)

pisa_test = na.omit(pisa_test)
```

## Building linear model

``` r
#convert character to factor
pisa_train$raceeth <- as.factor(pisa_train$raceeth)
pisa_test$raceeth <- as.factor(pisa_test$raceeth)

#Set the reference level of the factor to white
pisa_train$raceeth = relevel(pisa_train$raceeth, 'White')
pisa_test$raceeth = relevel(pisa_test$raceeth, "White")

#linear model
lmScore = lm(readingScore ~ ., data = pisa_train)
summary(lmScore)
```

    ## 
    ## Call:
    ## lm(formula = readingScore ~ ., data = pisa_train)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -247.44  -48.86    1.86   49.77  217.18 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                   143.766333  33.841226
    ## grade                                          29.542707   2.937399
    ## male                                          -14.521653   3.155926
    ## raceethAmerican Indian/Alaska Native          -67.277327  16.786935
    ## raceethAsian                                   -4.110325   9.220071
    ## raceethBlack                                  -67.012347   5.460883
    ## raceethHispanic                               -38.975486   5.177743
    ## raceethMore than one race                     -16.922522   8.496268
    ## raceethNative Hawaiian/Other Pacific Islander  -5.101601  17.005696
    ## preschool                                      -4.463670   3.486055
    ## expectBachelors                                55.267080   4.293893
    ## motherHS                                        6.058774   6.091423
    ## motherBachelors                                12.638068   3.861457
    ## motherWork                                     -2.809101   3.521827
    ## fatherHS                                        4.018214   5.579269
    ## fatherBachelors                                16.929755   3.995253
    ## fatherWork                                      5.842798   4.395978
    ## selfBornUS                                     -3.806278   7.323718
    ## motherBornUS                                   -8.798153   6.587621
    ## fatherBornUS                                    4.306994   6.263875
    ## englishAtHome                                   8.035685   6.859492
    ## computerForSchoolwork                          22.500232   5.702562
    ## read30MinsADay                                 34.871924   3.408447
    ## minutesPerWeekEnglish                           0.012788   0.010712
    ## studentsInEnglish                              -0.286631   0.227819
    ## schoolHasLibrary                               12.215085   9.264884
    ## publicSchool                                  -16.857475   6.725614
    ## urban                                          -0.110132   3.962724
    ## schoolSize                                      0.006540   0.002197
    ##                                               t value Pr(>|t|)    
    ## (Intercept)                                     4.248 2.24e-05 ***
    ## grade                                          10.057  < 2e-16 ***
    ## male                                           -4.601 4.42e-06 ***
    ## raceethAmerican Indian/Alaska Native           -4.008 6.32e-05 ***
    ## raceethAsian                                   -0.446  0.65578    
    ## raceethBlack                                  -12.271  < 2e-16 ***
    ## raceethHispanic                                -7.528 7.29e-14 ***
    ## raceethMore than one race                      -1.992  0.04651 *  
    ## raceethNative Hawaiian/Other Pacific Islander  -0.300  0.76421    
    ## preschool                                      -1.280  0.20052    
    ## expectBachelors                                12.871  < 2e-16 ***
    ## motherHS                                        0.995  0.32001    
    ## motherBachelors                                 3.273  0.00108 ** 
    ## motherWork                                     -0.798  0.42517    
    ## fatherHS                                        0.720  0.47147    
    ## fatherBachelors                                 4.237 2.35e-05 ***
    ## fatherWork                                      1.329  0.18393    
    ## selfBornUS                                     -0.520  0.60331    
    ## motherBornUS                                   -1.336  0.18182    
    ## fatherBornUS                                    0.688  0.49178    
    ## englishAtHome                                   1.171  0.24153    
    ## computerForSchoolwork                           3.946 8.19e-05 ***
    ## read30MinsADay                                 10.231  < 2e-16 ***
    ## minutesPerWeekEnglish                           1.194  0.23264    
    ## studentsInEnglish                              -1.258  0.20846    
    ## schoolHasLibrary                                1.318  0.18749    
    ## publicSchool                                   -2.506  0.01226 *  
    ## urban                                          -0.028  0.97783    
    ## schoolSize                                      2.977  0.00294 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 73.81 on 2385 degrees of freedom
    ## Multiple R-squared:  0.3251, Adjusted R-squared:  0.3172 
    ## F-statistic: 41.04 on 28 and 2385 DF,  p-value: < 2.2e-16

## Calculate RMSE

``` r
SSE = sum(lmScore$residuals^2)
RMSE = sqrt(SSE/nrow(pisa_train))
```

## predict reading score

``` r
predTest = predict(lmScore, newdata = pisa_test)
summary(predTest)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   353.2   482.0   524.0   516.7   555.7   637.7

``` r
#calculate predication error
SSE = sum((pisa_test$readingScore - predTest)^2)
RMSE = sqrt(SSE/nrow(pisa_test))
baseline = mean(pisa_train$readingScore)
SST = sum((pisa_test$readingScore - baseline)^2)
(R2 = 1 - SSE / SST)
```

    ## [1] 0.2614944
