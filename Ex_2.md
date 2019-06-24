Data Wrangling Exercise 2: Dealing with missing values
================
Mohammed Ali; Marwa Mohamed
6/2/2019

## Overview

In this exercise, you’ll work with one of the most popular starter data
sets in data science, the **Titanic** data set. This is a data set that
records various attributes of passengers on the **Titanic**, including
who survived and who didn’t. Read the description of [the data
set](https://www.kaggle.com/c/titanic/data) on the Kaggle website.

## Exercise

Using `R`, you’ll be handling missing values in this data set, and
creating a new data set. Specifically, these are the tasks you need to
do:

### 0: Load the data in RStudio

Save the data set `titanic3.xls` as a CSV file called
`titanic_original.csv` and load it in RStudio into a data
frame.

``` r
titanic <- read_csv("data/titanic_original.csv", col_types = "iiffniifnfffif")

# Inspect data structure
glimpse(titanic)
```

    ## Observations: 1,310
    ## Variables: 14
    ## $ pclass    <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    ## $ survived  <int> 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1...
    ## $ name      <fct> "Allen, Miss. Elisabeth Walton", "Allison, Master. H...
    ## $ sex       <fct> female, male, female, male, female, male, female, ma...
    ## $ age       <dbl> 29.0000, 0.9167, 2.0000, 30.0000, 25.0000, 48.0000, ...
    ## $ sibsp     <int> 0, 1, 1, 1, 1, 0, 1, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0...
    ## $ parch     <int> 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1...
    ## $ ticket    <fct> 24160, 113781, 113781, 113781, 113781, 19952, 13502,...
    ## $ fare      <dbl> 211.3375, 151.5500, 151.5500, 151.5500, 151.5500, 26...
    ## $ cabin     <fct> B5, C22 C26, C22 C26, C22 C26, C22 C26, E12, D7, A36...
    ## $ embarked  <fct> S, S, S, S, S, S, S, S, S, C, C, C, C, S, S, S, C, C...
    ## $ boat      <fct> 2, 11, NA, NA, NA, 3, 10, NA, D, NA, NA, 4, 9, 6, B,...
    ## $ body      <int> NA, NA, NA, 135, NA, NA, NA, NA, NA, 22, 124, NA, NA...
    ## $ home.dest <fct> "St Louis, MO", "Montreal, PQ / Chesterville, ON", "...

``` r
# Inspect first 5 rows in loaded data
head(titanic)
```

    ## # A tibble: 6 x 14
    ##   pclass survived name  sex      age sibsp parch ticket  fare cabin
    ##    <int>    <int> <fct> <fct>  <dbl> <int> <int> <fct>  <dbl> <fct>
    ## 1      1        1 Alle~ fema~ 29         0     0 24160  211.  B5   
    ## 2      1        1 Alli~ male   0.917     1     2 113781 152.  C22 ~
    ## 3      1        0 Alli~ fema~  2         1     2 113781 152.  C22 ~
    ## 4      1        0 Alli~ male  30         1     2 113781 152.  C22 ~
    ## 5      1        0 Alli~ fema~ 25         1     2 113781 152.  C22 ~
    ## 6      1        1 Ande~ male  48         0     0 19952   26.6 E12  
    ## # ... with 4 more variables: embarked <fct>, boat <fct>, body <int>,
    ## #   home.dest <fct>

### 1: Port of embarkation

The `embarked` column has some missing values, which are known to
correspond to passengers who actually embarked at Southampton. Find the
missing values and replace them with S. (Caution: Sometimes a missing
value might be read into R as a blank or empty string.)

``` r
# what is the status before processing
table(is.na(titanic$embarked))
```

    ## 
    ## FALSE  TRUE 
    ##  1307     3

``` r
# change missing values to s
titanic$embarked[is.na(titanic$embarked)] <- "S"

# after some cleaning
table(is.na(titanic$embarked))
```

    ## 
    ## FALSE 
    ##  1310

### 2: Age

You’ll notice that a lot of the values in the `Age` column are either
missing or illogic. While there are many ways to fill these missing
values, using the *mean* or *median* of the rest of the values is quite
common in such cases.

Calculate the mean of the Age column and use that value to populate the
missing values

Think about other ways you could have populated the missing values in
the age column. Why would you pick any of those over the mean (or not)?

``` r
# age before cleaning
table(titanic$age)
```

    ## 
    ## 0.1667 0.3333 0.4167 0.6667   0.75 0.8333 0.9167      1      2      3 
    ##      1      1      1      1      3      3      2     10     12      7 
    ##      4      5      6      7      8      9     10     11   11.5     12 
    ##     10      5      6      4      6     10      4      4      1      3 
    ##     13     14   14.5     15     16     17     18   18.5     19     20 
    ##      5      8      2      6     19     20     39      3     29     23 
    ##   20.5     21     22   22.5     23   23.5     24   24.5     25     26 
    ##      1     41     43      1     26      1     47      1     34     30 
    ##   26.5     27     28   28.5     29     30   30.5     31     32   32.5 
    ##      1     30     32      3     30     40      2     23     24      4 
    ##     33     34   34.5     35     36   36.5     37     38   38.5     39 
    ##     21     16      2     23     31      2      9     14      1     20 
    ##     40   40.5     41     42     43     44     45   45.5     46     47 
    ##     18      3     11     18      9     10     21      2      6     14 
    ##     48     49     50     51     52     53     54     55   55.5     56 
    ##     14      9     15      8      6      4     10      8      1      4 
    ##     57     58     59     60   60.5     61     62     63     64     65 
    ##      5      6      3      7      1      5      5      4      5      3 
    ##     66     67     70   70.5     71     74     76     80 
    ##      1      1      2      1      2      1      1      1

``` r
# round age to integers
titanic$age <- round(titanic$age)
# replace missing values with mean
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)
# After cleaning
summary(titanic$age)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00   22.00   29.87   29.87   35.00   80.00

``` r
####

# add age_fac column
titanic <- titanic %>% 
  mutate(age_fac = case_when(age <= 12 ~ "child",
            age >= 13 & age <= 18 ~ "teenage",
            age >= 19 & age <= 30 ~ "youth",
            age >= 31 & age <= 50 ~ "senior",
            age >= 51 ~ "elder"))
```

    ## mutate: new variable 'age_fac' with 5 unique values and 0% NA

``` r
# add levels to new column
levels(titanic$age_fac) <- c("child", "teenage", "youth", "senior", "elder")
# Inspect data structure
glimpse(titanic)
```

    ## Observations: 1,310
    ## Variables: 15
    ## $ pclass    <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    ## $ survived  <int> 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1...
    ## $ name      <fct> "Allen, Miss. Elisabeth Walton", "Allison, Master. H...
    ## $ sex       <fct> female, male, female, male, female, male, female, ma...
    ## $ age       <dbl> 29.00000, 1.00000, 2.00000, 30.00000, 25.00000, 48.0...
    ## $ sibsp     <int> 0, 1, 1, 1, 1, 0, 1, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0...
    ## $ parch     <int> 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1...
    ## $ ticket    <fct> 24160, 113781, 113781, 113781, 113781, 19952, 13502,...
    ## $ fare      <dbl> 211.3375, 151.5500, 151.5500, 151.5500, 151.5500, 26...
    ## $ cabin     <fct> B5, C22 C26, C22 C26, C22 C26, C22 C26, E12, D7, A36...
    ## $ embarked  <fct> S, S, S, S, S, S, S, S, S, C, C, C, C, S, S, S, C, C...
    ## $ boat      <fct> 2, 11, NA, NA, NA, 3, 10, NA, D, NA, NA, 4, 9, 6, B,...
    ## $ body      <int> NA, NA, NA, 135, NA, NA, NA, NA, NA, 22, 124, NA, NA...
    ## $ home.dest <fct> "St Louis, MO", "Montreal, PQ / Chesterville, ON", "...
    ## $ age_fac   <chr> "youth", "child", "child", "youth", "youth", "senior...

### 3: Lifeboat

You’re interested in looking at the distribution of passengers in
different `lifeboats`, but as we know, many passengers did not make it
to a boat :-( This means that there are a lot of missing values in the
`boat` column. Fill these empty slots with a dummy value e.g. the string
*‘None’* or *‘NA’*

``` r
# boat life before cleaning
table(is.na(titanic$boat))
```

    ## 
    ## FALSE  TRUE 
    ##   486   824

``` r
# add none as factor to boat
levels(titanic$boat) <- c(levels(titanic$boat), 'None')
# replace missing boat life with NA
titanic$boat[is.na(titanic$boat)] <- 'None'
# After cleaning
table((titanic$boat))
```

    ## 
    ##       2      11       3      10       D       4       9       6       B 
    ##      13      25      26      29      20      31      25      20       9 
    ##       8       A       5       7       C      14     5 9      13       1 
    ##      23      11      27      23      38      33       1      39       5 
    ##      15     5 7    8 10      12      16 13 15 B     C D   15 16   13 15 
    ##      37       2       1      19      23       1       2       1       2 
    ##    None 
    ##     824

### 4: Cabin

You notice that many passengers don’t have a cabin number associated
with them.

  - Does it make sense to fill missing cabin numbers with a value?

  - What does a missing value here mean?

You have a hunch that the fact that the cabin number is missing might be
a useful indicator of survival. Create a new column `has_cabin_number`
which has *1* if there is a cabin number, and *0* otherwise.

``` r
# Add new column with 0 values for missing cabin number and 1 otherwise
titanic$has_cabin_number <- ifelse(!(is.na(titanic$cabin)), 1, 0)
# Inspect data structure
glimpse(titanic)
```

    ## Observations: 1,310
    ## Variables: 16
    ## $ pclass           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    ## $ survived         <int> 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, ...
    ## $ name             <fct> "Allen, Miss. Elisabeth Walton", "Allison, Ma...
    ## $ sex              <fct> female, male, female, male, female, male, fem...
    ## $ age              <dbl> 29.00000, 1.00000, 2.00000, 30.00000, 25.0000...
    ## $ sibsp            <int> 0, 1, 1, 1, 1, 0, 1, 0, 2, 0, 1, 1, 0, 0, 0, ...
    ## $ parch            <int> 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    ## $ ticket           <fct> 24160, 113781, 113781, 113781, 113781, 19952,...
    ## $ fare             <dbl> 211.3375, 151.5500, 151.5500, 151.5500, 151.5...
    ## $ cabin            <fct> B5, C22 C26, C22 C26, C22 C26, C22 C26, E12, ...
    ## $ embarked         <fct> S, S, S, S, S, S, S, S, S, C, C, C, C, S, S, ...
    ## $ boat             <fct> 2, 11, None, None, None, 3, 10, None, D, None...
    ## $ body             <int> NA, NA, NA, 135, NA, NA, NA, NA, NA, 22, 124,...
    ## $ home.dest        <fct> "St Louis, MO", "Montreal, PQ / Chesterville,...
    ## $ age_fac          <chr> "youth", "child", "child", "youth", "youth", ...
    ## $ has_cabin_number <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, ...
