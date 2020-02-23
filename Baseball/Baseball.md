Baseball
================
Marwa Mohamed
2/23/2020

## R Markdown

Investigate how well we can predict the World Series winner at the
beginning of the playoffs.

## Load data

``` r
baseballTeams = read_csv("data/baseball.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Team = col_character(),
    ##   League = col_character(),
    ##   Year = col_double(),
    ##   RS = col_double(),
    ##   RA = col_double(),
    ##   W = col_double(),
    ##   OBP = col_double(),
    ##   SLG = col_double(),
    ##   BA = col_double(),
    ##   Playoffs = col_double(),
    ##   RankSeason = col_double(),
    ##   RankPlayoffs = col_double(),
    ##   G = col_double(),
    ##   OOBP = col_double(),
    ##   OSLG = col_double()
    ## )

``` r
#dataset structure
str(baseballTeams)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 1232 obs. of  15 variables:
    ##  $ Team        : chr  "ARI" "ATL" "BAL" "BOS" ...
    ##  $ League      : chr  "NL" "NL" "AL" "AL" ...
    ##  $ Year        : num  2012 2012 2012 2012 2012 ...
    ##  $ RS          : num  734 700 712 734 613 748 669 667 758 726 ...
    ##  $ RA          : num  688 600 705 806 759 676 588 845 890 670 ...
    ##  $ W           : num  81 94 93 69 61 85 97 68 64 88 ...
    ##  $ OBP         : num  0.328 0.32 0.311 0.315 0.302 0.318 0.315 0.324 0.33 0.335 ...
    ##  $ SLG         : num  0.418 0.389 0.417 0.415 0.378 0.422 0.411 0.381 0.436 0.422 ...
    ##  $ BA          : num  0.259 0.247 0.247 0.26 0.24 0.255 0.251 0.251 0.274 0.268 ...
    ##  $ Playoffs    : num  0 1 1 0 0 0 1 0 0 1 ...
    ##  $ RankSeason  : num  NA 4 5 NA NA NA 2 NA NA 6 ...
    ##  $ RankPlayoffs: num  NA 5 4 NA NA NA 4 NA NA 2 ...
    ##  $ G           : num  162 162 162 162 162 162 162 162 162 162 ...
    ##  $ OOBP        : num  0.317 0.306 0.315 0.331 0.335 0.319 0.305 0.336 0.357 0.314 ...
    ##  $ OSLG        : num  0.415 0.378 0.403 0.428 0.424 0.405 0.39 0.43 0.47 0.402 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   Team = col_character(),
    ##   ..   League = col_character(),
    ##   ..   Year = col_double(),
    ##   ..   RS = col_double(),
    ##   ..   RA = col_double(),
    ##   ..   W = col_double(),
    ##   ..   OBP = col_double(),
    ##   ..   SLG = col_double(),
    ##   ..   BA = col_double(),
    ##   ..   Playoffs = col_double(),
    ##   ..   RankSeason = col_double(),
    ##   ..   RankPlayoffs = col_double(),
    ##   ..   G = col_double(),
    ##   ..   OOBP = col_double(),
    ##   ..   OSLG = col_double()
    ##   .. )

``` r
#identify the total number of years included in this dataset.
table(baseballTeams$Year)
```

    ## 
    ## 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1973 1974 1975 1976 1977 
    ##   20   20   20   20   20   20   20   24   24   24   24   24   24   24   26 
    ## 1978 1979 1980 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 
    ##   26   26   26   26   26   26   26   26   26   26   26   26   26   26   28 
    ## 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 
    ##   28   28   30   30   30   30   30   30   30   30   30   30   30   30   30 
    ## 2011 2012 
    ##   30   30

## Playoffs teams

``` r
# a data frame limited to teams that made the playoffs 
baseball = subset(baseballTeams, Playoffs == 1)
#dataset structure
str(baseball)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    244 obs. of  15 variables:
    ##  $ Team        : chr  "ATL" "BAL" "CIN" "DET" ...
    ##  $ League      : chr  "NL" "AL" "NL" "AL" ...
    ##  $ Year        : num  2012 2012 2012 2012 2012 ...
    ##  $ RS          : num  700 712 669 726 804 713 718 765 808 731 ...
    ##  $ RA          : num  600 705 588 670 668 614 649 648 707 594 ...
    ##  $ W           : num  94 93 97 88 95 94 94 88 93 98 ...
    ##  $ OBP         : num  0.32 0.311 0.315 0.335 0.337 0.31 0.327 0.338 0.334 0.322 ...
    ##  $ SLG         : num  0.389 0.417 0.411 0.422 0.453 0.404 0.397 0.421 0.446 0.428 ...
    ##  $ BA          : num  0.247 0.247 0.251 0.268 0.265 0.238 0.269 0.271 0.273 0.261 ...
    ##  $ Playoffs    : num  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ RankSeason  : num  4 5 2 6 3 4 4 6 5 1 ...
    ##  $ RankPlayoffs: num  5 4 4 2 3 4 1 3 5 4 ...
    ##  $ G           : num  162 162 162 162 162 162 162 162 162 162 ...
    ##  $ OOBP        : num  0.306 0.315 0.305 0.314 0.311 0.306 0.313 0.313 0.309 0.303 ...
    ##  $ OSLG        : num  0.378 0.403 0.39 0.402 0.419 0.378 0.393 0.387 0.408 0.373 ...

``` r
#the number of teams making the playoffs in some season
PlayoffTable = table(baseball$Year)
PlayoffTable
```

    ## 
    ## 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1973 1974 1975 1976 1977 
    ##    2    2    2    2    2    2    2    4    4    4    4    4    4    4    4 
    ## 1978 1979 1980 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 
    ##    4    4    4    4    4    4    4    4    4    4    4    4    4    4    4 
    ## 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 
    ##    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
    ## 2011 2012 
    ##    8   10

``` r
#to get the names of the PlayoffTable vector
str(names(PlayoffTable))
```

    ##  chr [1:47] "1962" "1963" "1964" "1965" "1966" "1967" "1968" "1969" ...

``` r
#returns the number of playoff teams in 1990 and 2001
PlayoffTable[c("1990", "2001")]
```

    ## 
    ## 1990 2001 
    ##    4    8

``` r
#Store the number of teams in the playoffs for each team/year pair in the dataset
baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)]
str(baseball$NumCompetitors)
```

    ##  'table' int [1:244(1d)] 10 10 10 10 10 10 10 10 10 10 ...

``` r
#the number of playoff team/year pairs are there in dataset from years where 8 teams were invited to the playoffs
baseball %>% 
  filter(NumCompetitors == 8) %>% 
  nrow()
```

    ## [1] 128

## Bivariate Models for Predicting World Series Winner

``` r
# whether a team won the World Series in the indicated year  (1 won, 0 otherwise)
baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
#the number of teams that did NOT win the World Series
baseball %>% 
  filter(WorldSeries == 0) %>% 
  nrow()
```

    ## [1] 197

Find variables that is a significant predictor of the WorldSeries
variable in a bivariate logistic regression model( build 12 models)

``` r
# year model
modyear = glm(WorldSeries ~ Year, data = baseball, family = binomial)
summary(modyear)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ Year, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0297  -0.6797  -0.5435  -0.4648   2.1504  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept) 72.23602   22.64409    3.19  0.00142 **
    ## Year        -0.03700    0.01138   -3.25  0.00115 **
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 228.35  on 242  degrees of freedom
    ## AIC: 232.35
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# RS model
modRS = glm(WorldSeries ~ RS, data = baseball, family = binomial)
summary(modRS)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ RS, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.8254  -0.6819  -0.6363  -0.5561   2.0308  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)  0.661226   1.636494   0.404    0.686
    ## RS          -0.002681   0.002098  -1.278    0.201
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 237.45  on 242  degrees of freedom
    ## AIC: 241.45
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# RA model
modRA = glm(WorldSeries ~ RA, data = baseball, family = binomial)
summary(modRA)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ RA, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.9749  -0.6883  -0.6118  -0.4746   2.1577  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept)  1.888174   1.483831   1.272   0.2032  
    ## RA          -0.005053   0.002273  -2.223   0.0262 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 233.88  on 242  degrees of freedom
    ## AIC: 237.88
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# W model
modW = glm(WorldSeries ~ W, data = baseball, family = binomial)
summary(modW)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ W, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0623  -0.6777  -0.6117  -0.5367   2.1254  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept) -6.85568    2.87620  -2.384   0.0171 *
    ## W            0.05671    0.02988   1.898   0.0577 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 235.51  on 242  degrees of freedom
    ## AIC: 239.51
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# OBP model
modOBP = glm(WorldSeries ~ OBP, data = baseball, family = binomial)
summary(modOBP)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ OBP, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.8071  -0.6749  -0.6365  -0.5797   1.9753  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)    2.741      3.989   0.687    0.492
    ## OBP          -12.402     11.865  -1.045    0.296
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 238.02  on 242  degrees of freedom
    ## AIC: 242.02
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# SLG model
modSLG = glm(WorldSeries ~ SLG, data = baseball, family = binomial)
summary(modSLG)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ SLG, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.9498  -0.6953  -0.6088  -0.5197   2.1136  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept)    3.200      2.358   1.357   0.1748  
    ## SLG          -11.130      5.689  -1.956   0.0504 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 235.23  on 242  degrees of freedom
    ## AIC: 239.23
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# BA model
modBA = glm(WorldSeries ~ BA, data = baseball, family = binomial)
summary(modBA)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ BA, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.6797  -0.6592  -0.6513  -0.6389   1.8431  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)  -0.6392     3.8988  -0.164    0.870
    ## BA           -2.9765    14.6123  -0.204    0.839
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 239.08  on 242  degrees of freedom
    ## AIC: 243.08
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# RankSeason model
modRankSeason = glm(WorldSeries ~ RankSeason, data = baseball, family = binomial)
summary(modRankSeason)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ RankSeason, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.7805  -0.7131  -0.5918  -0.4882   2.1781  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept)  -0.8256     0.3268  -2.527   0.0115 *
    ## RankSeason   -0.2069     0.1027  -2.016   0.0438 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 234.75  on 242  degrees of freedom
    ## AIC: 238.75
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# OOBP model
modOOBP = glm(WorldSeries ~ OOBP, data = baseball, family = binomial)
summary(modOOBP)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ OOBP, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.5318  -0.5176  -0.5106  -0.5023   2.0697  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)  -0.9306     8.3728  -0.111    0.912
    ## OOBP         -3.2233    26.0587  -0.124    0.902
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 84.926  on 113  degrees of freedom
    ## Residual deviance: 84.910  on 112  degrees of freedom
    ##   (130 observations deleted due to missingness)
    ## AIC: 88.91
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# OSLG model
modOSLG = glm(WorldSeries ~ OSLG, data = baseball, family = binomial)
summary(modOSLG)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ OSLG, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.5610  -0.5209  -0.5088  -0.4902   2.1268  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)
    ## (Intercept) -0.08725    6.07285  -0.014    0.989
    ## OSLG        -4.65992   15.06881  -0.309    0.757
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 84.926  on 113  degrees of freedom
    ## Residual deviance: 84.830  on 112  degrees of freedom
    ##   (130 observations deleted due to missingness)
    ## AIC: 88.83
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# NumCompetitors model
modNumCompetitors = glm(WorldSeries ~ NumCompetitors, data = baseball, family = binomial)
#AIC 230.96
summary(modNumCompetitors)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ NumCompetitors, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.9871  -0.8017  -0.5089  -0.5089   2.2643  
    ## 
    ## Coefficients:
    ##                Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)     0.03868    0.43750   0.088 0.929559    
    ## NumCompetitors -0.25220    0.07422  -3.398 0.000678 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 226.96  on 242  degrees of freedom
    ## AIC: 230.96
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
# League model
modLeague = glm(WorldSeries ~ League, data = baseball, family = binomial)
summary(modLeague)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ League, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.6772  -0.6772  -0.6306  -0.6306   1.8509  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  -1.3558     0.2243  -6.045  1.5e-09 ***
    ## LeagueNL     -0.1583     0.3252  -0.487    0.626    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 238.88  on 242  degrees of freedom
    ## AIC: 242.88
    ## 
    ## Number of Fisher Scoring iterations: 4

## Multivariate Models for Predicting World Series Winner

combine the variables found to be significant in bivariate models. Build
a model using all of the variables that found to be significant in the
bivariate
models

``` r
mod = glm(WorldSeries ~ Year + RA + RankSeason + NumCompetitors, data = baseball, family = binomial)
summary(mod)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ Year + RA + RankSeason + NumCompetitors, 
    ##     family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0336  -0.7689  -0.5139  -0.4583   2.2195  
    ## 
    ## Coefficients:
    ##                  Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)    12.5874376 53.6474210   0.235    0.814
    ## Year           -0.0061425  0.0274665  -0.224    0.823
    ## RA             -0.0008238  0.0027391  -0.301    0.764
    ## RankSeason     -0.0685046  0.1203459  -0.569    0.569
    ## NumCompetitors -0.1794264  0.1815933  -0.988    0.323
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 226.37  on 239  degrees of freedom
    ## AIC: 236.37
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#correlation of significant vars
cor(baseball[,c(3,5,11,16)])
```

    ##                     Year        RA RankSeason NumCompetitors
    ## Year           1.0000000 0.4762422  0.3852191      0.9139548
    ## RA             0.4762422 1.0000000  0.3991413      0.5136769
    ## RankSeason     0.3852191 0.3991413  1.0000000      0.4247393
    ## NumCompetitors 0.9139548 0.5136769  0.4247393      1.0000000

``` r
#Year/RA model
mod1 = glm(WorldSeries ~ Year + RA, data = baseball, family = binomial)
summary(mod1)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ Year + RA, family = binomial, data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0402  -0.6878  -0.5298  -0.4785   2.1370  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)  
    ## (Intercept) 63.610741  25.654830   2.479   0.0132 *
    ## Year        -0.032084   0.013323  -2.408   0.0160 *
    ## RA          -0.001766   0.002585  -0.683   0.4945  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 227.88  on 241  degrees of freedom
    ## AIC: 233.88
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#Year/RankSeason model
mod2 = glm(WorldSeries ~ Year + RankSeason, data = baseball, family = binomial)
summary(mod2)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ Year + RankSeason, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0560  -0.6957  -0.5379  -0.4528   2.2673  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept) 63.64855   24.37063   2.612  0.00901 **
    ## Year        -0.03254    0.01231  -2.643  0.00822 **
    ## RankSeason  -0.10064    0.11352  -0.887  0.37534   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 227.55  on 241  degrees of freedom
    ## AIC: 233.55
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#Year/NumCompetitors model
mod3 = glm(WorldSeries ~ Year + NumCompetitors, data = baseball, family = binomial)
summary(mod3)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ Year + NumCompetitors, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0050  -0.7823  -0.5115  -0.4970   2.2552  
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)    13.350467  53.481896   0.250    0.803
    ## Year           -0.006802   0.027328  -0.249    0.803
    ## NumCompetitors -0.212610   0.175520  -1.211    0.226
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 226.90  on 241  degrees of freedom
    ## AIC: 232.9
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#RA/RankSeason model
mod4 = glm(WorldSeries ~ RankSeason + RA, data = baseball, family = binomial)
summary(mod4)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ RankSeason + RA, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.9374  -0.6933  -0.5936  -0.4564   2.1979  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)  1.487461   1.506143   0.988    0.323
    ## RankSeason  -0.140824   0.110908  -1.270    0.204
    ## RA          -0.003815   0.002441  -1.563    0.118
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 232.22  on 241  degrees of freedom
    ## AIC: 238.22
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#NumCompetitors/RA model
mod5 = glm(WorldSeries ~ NumCompetitors + RA, data = baseball, family = binomial)
summary(mod5)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ NumCompetitors + RA, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0433  -0.7826  -0.5133  -0.4701   2.2208  
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept)     0.716895   1.528736   0.469  0.63911   
    ## NumCompetitors -0.229385   0.088399  -2.595  0.00946 **
    ## RA             -0.001233   0.002661  -0.463  0.64313   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 226.74  on 241  degrees of freedom
    ## AIC: 232.74
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
#RankSeason/NumCompetitors model
mod6 = glm(WorldSeries ~ RankSeason + NumCompetitors, data = baseball, family = binomial)
summary(mod6)
```

    ## 
    ## Call:
    ## glm(formula = WorldSeries ~ RankSeason + NumCompetitors, family = binomial, 
    ##     data = baseball)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0090  -0.7592  -0.5204  -0.4501   2.2562  
    ## 
    ## Coefficients:
    ##                Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept)     0.12277    0.45737   0.268  0.78837   
    ## RankSeason     -0.07697    0.11711  -0.657  0.51102   
    ## NumCompetitors -0.22784    0.08201  -2.778  0.00546 **
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 239.12  on 243  degrees of freedom
    ## Residual deviance: 226.52  on 241  degrees of freedom
    ## AIC: 232.52
    ## 
    ## Number of Fisher Scoring iterations: 4
