climate\_change
================
Marwa Mohamed
11/13/2019

## overview

There have been many studies documenting that the average global
temperature has been increasing over the last century. The consequences
of a continued rise in global temperature will be dire. Rising sea
levels and an increased frequency of extreme weather events will affect
billions of people.

In this problem, we will attempt to study the relationship between
average global temperature and several other factors.

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

### 0: Load the data in RStudio

``` r
climate = read_csv("data/climate_change.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Year = col_double(),
    ##   Month = col_double(),
    ##   MEI = col_double(),
    ##   CO2 = col_double(),
    ##   CH4 = col_double(),
    ##   N2O = col_double(),
    ##   `CFC-11` = col_double(),
    ##   `CFC-12` = col_double(),
    ##   TSI = col_double(),
    ##   Aerosols = col_double(),
    ##   Temp = col_double()
    ## )

``` r
str(climate)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 308 obs. of  11 variables:
    ##  $ Year    : num  1983 1983 1983 1983 1983 ...
    ##  $ Month   : num  5 6 7 8 9 10 11 12 1 2 ...
    ##  $ MEI     : num  2.556 2.167 1.741 1.13 0.428 ...
    ##  $ CO2     : num  346 346 344 342 340 ...
    ##  $ CH4     : num  1639 1634 1633 1631 1648 ...
    ##  $ N2O     : num  304 304 304 304 304 ...
    ##  $ CFC-11  : num  191 192 193 194 194 ...
    ##  $ CFC-12  : num  350 352 354 356 357 ...
    ##  $ TSI     : num  1366 1366 1366 1366 1366 ...
    ##  $ Aerosols: num  0.0863 0.0794 0.0731 0.0673 0.0619 0.0569 0.0524 0.0486 0.0451 0.0416 ...
    ##  $ Temp    : num  0.109 0.118 0.137 0.176 0.149 0.093 0.232 0.078 0.089 0.013 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   Year = col_double(),
    ##   ..   Month = col_double(),
    ##   ..   MEI = col_double(),
    ##   ..   CO2 = col_double(),
    ##   ..   CH4 = col_double(),
    ##   ..   N2O = col_double(),
    ##   ..   `CFC-11` = col_double(),
    ##   ..   `CFC-12` = col_double(),
    ##   ..   TSI = col_double(),
    ##   ..   Aerosols = col_double(),
    ##   ..   Temp = col_double()
    ##   .. )

\#\#divide
    data

    ##       Year          Month             MEI               CO2       
    ##  Min.   :1983   Min.   : 1.000   Min.   :-1.5860   Min.   :340.2  
    ##  1st Qu.:1989   1st Qu.: 4.000   1st Qu.:-0.3230   1st Qu.:352.3  
    ##  Median :1995   Median : 7.000   Median : 0.3085   Median :359.9  
    ##  Mean   :1995   Mean   : 6.556   Mean   : 0.3419   Mean   :361.4  
    ##  3rd Qu.:2001   3rd Qu.:10.000   3rd Qu.: 0.8980   3rd Qu.:370.6  
    ##  Max.   :2006   Max.   :12.000   Max.   : 3.0010   Max.   :385.0  
    ##       CH4            N2O            CFC_11          CFC_12     
    ##  Min.   :1630   Min.   :303.7   Min.   :191.3   Min.   :350.1  
    ##  1st Qu.:1716   1st Qu.:307.7   1st Qu.:249.6   1st Qu.:462.5  
    ##  Median :1759   Median :310.8   Median :260.4   Median :522.1  
    ##  Mean   :1746   Mean   :311.7   Mean   :252.5   Mean   :494.2  
    ##  3rd Qu.:1782   3rd Qu.:316.1   3rd Qu.:267.4   3rd Qu.:541.0  
    ##  Max.   :1808   Max.   :320.5   Max.   :271.5   Max.   :543.8  
    ##       TSI          Aerosols            Temp        
    ##  Min.   :1365   Min.   :0.00160   Min.   :-0.2820  
    ##  1st Qu.:1366   1st Qu.:0.00270   1st Qu.: 0.1180  
    ##  Median :1366   Median :0.00620   Median : 0.2325  
    ##  Mean   :1366   Mean   :0.01772   Mean   : 0.2478  
    ##  3rd Qu.:1366   3rd Qu.:0.01400   3rd Qu.: 0.4065  
    ##  Max.   :1367   Max.   :0.14940   Max.   : 0.7390

## Build a linear regression model

build a linear regression model to predict the dependent variable Temp,
using MEI, CO2, CH4, N2O, CFC.11, CFC.12, TSI, and Aerosols as
independent variables (Year and Month should NOT be used in the
model).

``` r
temp_model = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC_11 + CFC_12 + TSI + Aerosols, data = climate_train)
summary(temp_model)
```

    ## 
    ## Call:
    ## lm(formula = Temp ~ MEI + CO2 + CH4 + N2O + CFC_11 + CFC_12 + 
    ##     TSI + Aerosols, data = climate_train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.25888 -0.05913 -0.00082  0.05649  0.32433 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -1.246e+02  1.989e+01  -6.265 1.43e-09 ***
    ## MEI          6.421e-02  6.470e-03   9.923  < 2e-16 ***
    ## CO2          6.457e-03  2.285e-03   2.826  0.00505 ** 
    ## CH4          1.240e-04  5.158e-04   0.240  0.81015    
    ## N2O         -1.653e-02  8.565e-03  -1.930  0.05467 .  
    ## CFC_11      -6.631e-03  1.626e-03  -4.078 5.96e-05 ***
    ## CFC_12       3.808e-03  1.014e-03   3.757  0.00021 ***
    ## TSI          9.314e-02  1.475e-02   6.313 1.10e-09 ***
    ## Aerosols    -1.538e+00  2.133e-01  -7.210 5.41e-12 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09171 on 275 degrees of freedom
    ## Multiple R-squared:  0.7509, Adjusted R-squared:  0.7436 
    ## F-statistic: 103.6 on 8 and 275 DF,  p-value: < 2.2e-16

## train data correlation

``` r
cor(climate_train)
```

    ##                 Year         Month           MEI         CO2         CH4
    ## Year      1.00000000 -0.0279419602 -0.0369876842  0.98274939  0.91565945
    ## Month    -0.02794196  1.0000000000  0.0008846905 -0.10673246  0.01856866
    ## MEI      -0.03698768  0.0008846905  1.0000000000 -0.04114717 -0.03341930
    ## CO2       0.98274939 -0.1067324607 -0.0411471651  1.00000000  0.87727963
    ## CH4       0.91565945  0.0185686624 -0.0334193014  0.87727963  1.00000000
    ## N2O       0.99384523  0.0136315303 -0.0508197755  0.97671982  0.89983864
    ## CFC_11    0.56910643 -0.0131112236  0.0690004387  0.51405975  0.77990402
    ## CFC_12    0.89701166  0.0006751102  0.0082855443  0.85268963  0.96361625
    ## TSI       0.17030201 -0.0346061935 -0.1544919227  0.17742893  0.24552844
    ## Aerosols -0.34524670  0.0148895406  0.3402377871 -0.35615480 -0.26780919
    ## Temp      0.78679714 -0.0998567411  0.1724707512  0.78852921  0.70325502
    ##                  N2O      CFC_11        CFC_12         TSI    Aerosols
    ## Year      0.99384523  0.56910643  0.8970116635  0.17030201 -0.34524670
    ## Month     0.01363153 -0.01311122  0.0006751102 -0.03460619  0.01488954
    ## MEI      -0.05081978  0.06900044  0.0082855443 -0.15449192  0.34023779
    ## CO2       0.97671982  0.51405975  0.8526896272  0.17742893 -0.35615480
    ## CH4       0.89983864  0.77990402  0.9636162478  0.24552844 -0.26780919
    ## N2O       1.00000000  0.52247732  0.8679307757  0.19975668 -0.33705457
    ## CFC_11    0.52247732  1.00000000  0.8689851828  0.27204596 -0.04392120
    ## CFC_12    0.86793078  0.86898518  1.0000000000  0.25530281 -0.22513124
    ## TSI       0.19975668  0.27204596  0.2553028138  1.00000000  0.05211651
    ## Aerosols -0.33705457 -0.04392120 -0.2251312440  0.05211651  1.00000000
    ## Temp      0.77863893  0.40771029  0.6875575483  0.24338269 -0.38491375
    ##                 Temp
    ## Year      0.78679714
    ## Month    -0.09985674
    ## MEI       0.17247075
    ## CO2       0.78852921
    ## CH4       0.70325502
    ## N2O       0.77863893
    ## CFC_11    0.40771029
    ## CFC_12    0.68755755
    ## TSI       0.24338269
    ## Aerosols -0.38491375
    ## Temp      1.00000000

## simpler model

Given that the correlations are so high, let us focus on the N2O
variable and build a model with only MEI, TSI, Aerosols and N2O as
independent variables. Remember to use the training set to build the
model.

``` r
temp_model2 = lm(Temp ~ MEI + N2O + TSI + Aerosols, data = climate_train)
summary(temp_model2)
```

    ## 
    ## Call:
    ## lm(formula = Temp ~ MEI + N2O + TSI + Aerosols, data = climate_train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.27916 -0.05975 -0.00595  0.05672  0.34195 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -1.162e+02  2.022e+01  -5.747 2.37e-08 ***
    ## MEI          6.419e-02  6.652e-03   9.649  < 2e-16 ***
    ## N2O          2.532e-02  1.311e-03  19.307  < 2e-16 ***
    ## TSI          7.949e-02  1.487e-02   5.344 1.89e-07 ***
    ## Aerosols    -1.702e+00  2.180e-01  -7.806 1.19e-13 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09547 on 279 degrees of freedom
    ## Multiple R-squared:  0.7261, Adjusted R-squared:  0.7222 
    ## F-statistic: 184.9 on 4 and 279 DF,  p-value: < 2.2e-16
