Data Wrangling Exercise 1: Basic Data Manipulation
================
Mohammed Ali; Marwa Mohamed
6/2/2019

## Overview

In this exercise, you’ll work with a toy data set showing product
purchases from an electronics store. While the data set is small and
simple, it still illustrates many of the challenges you have to address
in real-world data wrangling\! The data set and exercise are inspired by
this [blog
post](http://d3-media.blogspot.nl/2013/11/how-to-refine-your-data.html).

## Getting started

The data is in an Excel file here called `refine.xlsx`. Right away,
you’ll notice that the data set has a few issues:

  - There are four brands: *Philips*, *Akzo*, *Van Houten* and
    *Unilever*. However, there are many different spellings and
    capitalizations of those names\!

  - The product code and number are combined in one column, separated by
    a hyphen.

## Exercise

Using `R`, clean this data set to make it easier to visualize and
analyze. Specifically, these are the tasks you need to do:

### 0: Load the data in RStudio

Save the data set as a CSV file called `refine_original.csv` and load it
in RStudio into a data frame.

``` r
# Use readr methods in your read/write operations
refine <- read_csv("data/refine_original.csv", col_types = "fccfff")

# Inspect data structure
glimpse(refine)
```

    ## Observations: 25
    ## Variables: 6
    ## $ company                 <fct> Phillips, phillips, philips, phllips, ...
    ## $ `Product code / number` <chr> "p-5", "p-43", "x-3", "x-34", "x-12", ...
    ## $ address                 <chr> "Groningensingel 147", "Groningensinge...
    ## $ city                    <fct> arnhem, arnhem, arnhem, arnhem, arnhem...
    ## $ country                 <fct> the netherlands, the netherlands, the ...
    ## $ name                    <fct> dhr p. jansen, dhr p. hansen, dhr j. G...

``` r
# Inspect first 5 rows in loaded data
head(refine)
```

    ## # A tibble: 6 x 6
    ##   company  `Product code / num~ address        city  country     name      
    ##   <fct>    <chr>                <chr>          <fct> <fct>       <fct>     
    ## 1 Phillips p-5                  Groningensing~ arnh~ the nether~ dhr p. ja~
    ## 2 phillips p-43                 Groningensing~ arnh~ the nether~ dhr p. ha~
    ## 3 philips  x-3                  Groningensing~ arnh~ the nether~ dhr j. Ga~
    ## 4 phllips  x-34                 Groningensing~ arnh~ the nether~ dhr p. ma~
    ## 5 phillps  x-12                 Groningensing~ arnh~ the nether~ dhr p. fr~
    ## 6 phillipS p-23                 Groningensing~ arnh~ the nether~ dhr p. fr~

### 1: Clean up brand names

Clean up the `company` column so all of the misspellings of the brand
names are standardized. For example, you can transform the values in the
column to be: *philips, akzo, van houten* and *unileve*r (all
lowercase).

``` r
# what is the status before processing
table(refine$company)
```

    ## 
    ##   Phillips   phillips    philips    phllips    phillps   phillipS 
    ##          1          2          1          1          1          1 
    ##       akzo       Akzo       AKZO       akz0      ak zo    fillips 
    ##          3          1          1          1          1          1 
    ##     phlips Van Houten van Houten van houten    unilver   unilever 
    ##          1          2          1          2          1          2 
    ##   Unilever 
    ##          1

``` r
#Search for Approximate String Matching then replace the found ids with correct string
idx <-
  agrep(
    pattern = "philips",
    x = refine$company,
    ignore.case = TRUE,
    value =   FALSE,
    max.distance = 3
  )
refine$company[idx] <- "philips"

idx <-
  agrep(
    pattern = "akzo",
    x = refine$company,
    ignore.case = TRUE,
    value = FALSE,
    max.distance = 2
  )
refine$company[idx] <- "akzo"

idx <-
  agrep(
    pattern = "van houten",
    x = refine$company,
    ignore.case = TRUE,
    value = FALSE,
    max.distance = 3
  )
refine$company[idx] <- "van houten"

idx <-
  agrep(
    pattern = "unilever",
    x = refine$company,
    ignore.case = TRUE,
    value = FALSE,
    max.distance = 3
  )
refine$company[idx] <- "unilever"

# what is the status now?
table(refine$company)
```

    ## 
    ##   Phillips   phillips    philips    phllips    phillps   phillipS 
    ##          0          0          9          0          0          0 
    ##       akzo       Akzo       AKZO       akz0      ak zo    fillips 
    ##          7          0          0          0          0          0 
    ##     phlips Van Houten van Houten van houten    unilver   unilever 
    ##          0          0          0          5          0          4 
    ##   Unilever 
    ##          0

``` r
#drop unused levels
refine$company <- droplevels(refine$company)

# after some cleaning
table(refine$company)
```

    ## 
    ##    philips       akzo van houten   unilever 
    ##          9          7          5          4

### 2: Separate product code and number

Separate the product code and product number into separate columns
i.e. add two new columns called `product_code` and `product_number`,
containing the product code and number
respectively

``` r
refine <- refine %>% separate(`Product code / number`, c("product_code", "product_number"), sep = "-")
glimpse(refine)
```

    ## Observations: 25
    ## Variables: 7
    ## $ company        <fct> philips, philips, philips, philips, philips, ph...
    ## $ product_code   <chr> "p", "p", "x", "x", "x", "p", "v", "v", "x", "p...
    ## $ product_number <chr> "5", "43", "3", "34", "12", "23", "43", "12", "...
    ## $ address        <chr> "Groningensingel 147", "Groningensingel 148", "...
    ## $ city           <fct> arnhem, arnhem, arnhem, arnhem, arnhem, arnhem,...
    ## $ country        <fct> the netherlands, the netherlands, the netherlan...
    ## $ name           <fct> dhr p. jansen, dhr p. hansen, dhr j. Gansen, dh...

### 3: Add product categories

You learn that the product codes actually represent the following
product categories:

  - `p` = **Smartphone**

  - `v` = **TV**

  - `x` = **Laptop**

  - `q` = **Tablet**

In order to make the data more readable, add a column with the product
category for each
record.

``` r
# x1 <- refine %>% filter(product_code == 'p') %>%  mutate(product_category = "Smartphone")
# x2 <- refine %>% filter(product_code == 'v') %>%  mutate(product_category = "TV" )
# x3 <- refine %>% filter(product_code == 'x') %>%  mutate(product_category = "Laptop")
# x4 <- refine %>% filter(product_code == 'q') %>%  mutate(product_category = "Tablet" )
#refine <- rbind(x1, x2, x3, x4)

# refine$product_category <- ifelse(refine$product_code == 'p',
#"Smartphone", ifelse(refine$product_code == 'v', "TV", 
#if_else(refine$product_code == 'x', "Laptop", "Tablet")))

# even better ;)
refine <- refine %>% 
  mutate(product_category = case_when(product_code == "p" ~ "Smartphone",
                                      product_code == "v" ~ "TV",
                                      product_code == "x" ~ "Laptop",
                                      product_code == "q" ~ "Tablet"),
         product_category = factor(product_category, levels = c("Smartphone", "TV", "Laptop", "Tablet")))
```

    ## mutate: new variable 'product_category' with 4 unique values and 0% NA

``` r
glimpse(refine)
```

    ## Observations: 25
    ## Variables: 8
    ## $ company          <fct> philips, philips, philips, philips, philips, ...
    ## $ product_code     <chr> "p", "p", "x", "x", "x", "p", "v", "v", "x", ...
    ## $ product_number   <chr> "5", "43", "3", "34", "12", "23", "43", "12",...
    ## $ address          <chr> "Groningensingel 147", "Groningensingel 148",...
    ## $ city             <fct> arnhem, arnhem, arnhem, arnhem, arnhem, arnhe...
    ## $ country          <fct> the netherlands, the netherlands, the netherl...
    ## $ name             <fct> dhr p. jansen, dhr p. hansen, dhr j. Gansen, ...
    ## $ product_category <fct> Smartphone, Smartphone, Laptop, Laptop, Lapto...

### 4: Add full address for geocoding

You’d like to view the customer information on a map. In order to do
that, the addresses need to be in a form that can be easily geocoded.
Create a new column `full_address` that concatenates the three address
fields (`address`, `city`, `country`), separated by
*commas*.

``` r
refine <- refine %>% unite("full_address", address, city, country, sep = ",")
head(refine$full_address)
```

    ## [1] "Groningensingel 147,arnhem,the netherlands"
    ## [2] "Groningensingel 148,arnhem,the netherlands"
    ## [3] "Groningensingel 149,arnhem,the netherlands"
    ## [4] "Groningensingel 150,arnhem,the netherlands"
    ## [5] "Groningensingel 151,arnhem,the netherlands"
    ## [6] "Groningensingel 152,arnhem,the netherlands"

### 5: Create dummy variables for company and product category

Both the company name and product category are categorical variables
i.e. they take only a fixed set of values. In order to use them in
further analysis you need to create dummy variables. Create dummy binary
variables for each of them with the prefix `company_` and `product_`
i.e.,

  - Add four binary (1 or 0) columns for company: company\_philips,
    company\_akzo, company\_van\_houten and company\_unilever.

  - Add four binary (1 or 0) columns for product category:
    product\_smartphone, product\_tv, product\_laptop and
    product\_tablet.

<!-- end list -->

``` r
#names(refine)[6] <- "product"
# use rename to avoid confusion
refine <- refine %>%
  rename(category = product_category)

refine <-
  refine %>% dummy_cols(select_columns  = c("company", "category"))

glimpse(refine)
```

    ## Observations: 25
    ## Variables: 14
    ## $ company              <fct> philips, philips, philips, philips, phili...
    ## $ product_code         <chr> "p", "p", "x", "x", "x", "p", "v", "v", "...
    ## $ product_number       <chr> "5", "43", "3", "34", "12", "23", "43", "...
    ## $ full_address         <chr> "Groningensingel 147,arnhem,the netherlan...
    ## $ name                 <fct> dhr p. jansen, dhr p. hansen, dhr j. Gans...
    ## $ category             <fct> Smartphone, Smartphone, Laptop, Laptop, L...
    ## $ company_philips      <int> 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,...
    ## $ company_akzo         <int> 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0,...
    ## $ `company_van houten` <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## $ company_unilever     <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## $ category_Smartphone  <int> 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,...
    ## $ category_Laptop      <int> 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,...
    ## $ category_TV          <int> 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,...
    ## $ category_Tablet      <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0,...
