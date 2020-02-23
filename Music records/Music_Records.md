Music\_Records
================
Marwa Mohamed
2/18/2020

## R Markdown

The music industry has a well-developed market with a global annual
revenue around $15 billion. The recording industry is highly competitive
and is dominated by three big production companies which make up nearly
82% of the total annual album sales.

Artists are at the core of the music industry and record labels provide
them with the necessary resources to sell their music on a large scale.
A record label incurs numerous costs (studio recording, marketing,
distribution, and touring) in exchange for a percentage of the profits
from album sales, singles and concert tickets.

Unfortunately, the success of an artist’s release is highly uncertain: a
single may be extremely popular, resulting in widespread radio play and
digital downloads, while another single may turn out quite unpopular,
and therefore unprofitable.

Knowing the competitive nature of the recording industry, record labels
face the fundamental decision problem of which musical releases to
support to maximize their financial success.

How can we use analytics to predict the popularity of a song? In this
assignment, we challenge ourselves to predict whether a song will reach
a spot in the Top 10 of the Billboard Hot 100 Chart.

Taking an analytics approach, we aim to use information about a song’s
properties to predict its popularity. The dataset songs (CSV) consists
of all songs which made it to the Top 10 of the Billboard Hot 100 Chart
from 1990-2010 plus a sample of additional songs that didn’t make the
Top 10.

### 0: Load the data in RStudio

``` r
songs = read_csv("data/songs.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   songtitle = col_character(),
    ##   artistname = col_character(),
    ##   songID = col_character(),
    ##   artistID = col_character()
    ## )

    ## See spec(...) for full column specifications.

``` r
#dataset structure
str(songs)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 7574 obs. of  39 variables:
    ##  $ year                    : num  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
    ##  $ songtitle               : chr  "This Is the House That Doubt Built" "Sticks & Bricks" "All I Want" "It's Complicated" ...
    ##  $ artistname              : chr  "A Day to Remember" "A Day to Remember" "A Day to Remember" "A Day to Remember" ...
    ##  $ songID                  : chr  "SOBGGAB12C5664F054" "SOPAQHU1315CD47F31" "SOOIZOU1376E7C6386" "SODRYWD1315CD49DBE" ...
    ##  $ artistID                : chr  "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" ...
    ##  $ timesignature           : num  3 4 4 4 4 4 4 4 4 4 ...
    ##  $ timesignature_confidence: num  0.853 1 1 1 0.788 1 0.968 0.861 0.622 0.938 ...
    ##  $ loudness                : num  -4.26 -4.05 -3.57 -3.81 -4.71 ...
    ##  $ tempo                   : num  91.5 140 160.5 97.5 140.1 ...
    ##  $ tempo_confidence        : num  0.953 0.921 0.489 0.794 0.286 0.347 0.273 0.83 0.018 0.929 ...
    ##  $ key                     : num  11 10 2 1 6 4 10 5 9 11 ...
    ##  $ key_confidence          : num  0.453 0.469 0.209 0.632 0.483 0.627 0.715 0.423 0.751 0.602 ...
    ##  $ energy                  : num  0.967 0.985 0.99 0.939 0.988 ...
    ##  $ pitch                   : num  0.024 0.025 0.026 0.013 0.063 0.038 0.026 0.033 0.027 0.004 ...
    ##  $ timbre_0_min            : num  0.002 0 0.003 0 0 ...
    ##  $ timbre_0_max            : num  57.3 57.4 57.4 57.8 56.9 ...
    ##  $ timbre_1_min            : num  -6.5 -37.4 -17.2 -32.1 -223.9 ...
    ##  $ timbre_1_max            : num  171 171 171 221 171 ...
    ##  $ timbre_2_min            : num  -81.7 -149.6 -72.9 -138.6 -147.2 ...
    ##  $ timbre_2_max            : num  95.1 180.3 157.9 173.4 166 ...
    ##  $ timbre_3_min            : num  -285 -380.1 -204 -73.5 -128.1 ...
    ##  $ timbre_3_max            : num  259 384 251 373 389 ...
    ##  $ timbre_4_min            : num  -40.4 -48.7 -66 -55.6 -43.9 ...
    ##  $ timbre_4_max            : num  73.6 100.4 152.1 119.2 99.3 ...
    ##  $ timbre_5_min            : num  -104.7 -87.3 -98.7 -77.5 -96.1 ...
    ##  $ timbre_5_max            : num  183.1 42.8 141.4 141.2 38.3 ...
    ##  $ timbre_6_min            : num  -88.8 -86.9 -88.9 -70.8 -110.8 ...
    ##  $ timbre_6_max            : num  73.5 75.5 66.5 64.5 72.4 ...
    ##  $ timbre_7_min            : num  -71.1 -65.8 -67.4 -63.7 -55.9 ...
    ##  $ timbre_7_max            : num  82.5 106.9 80.6 96.7 110.3 ...
    ##  $ timbre_8_min            : num  -52 -61.3 -59.8 -78.7 -56.5 ...
    ##  $ timbre_8_max            : num  39.1 35.4 46 41.1 37.6 ...
    ##  $ timbre_9_min            : num  -35.4 -81.9 -46.3 -49.2 -48.6 ...
    ##  $ timbre_9_max            : num  71.6 74.6 59.9 95.4 67.6 ...
    ##  $ timbre_10_min           : num  -126.4 -103.8 -108.3 -102.7 -52.8 ...
    ##  $ timbre_10_max           : num  18.7 121.9 33.3 46.4 22.9 ...
    ##  $ timbre_11_min           : num  -44.8 -38.9 -43.7 -59.4 -50.4 ...
    ##  $ timbre_11_max           : num  26 22.5 25.7 37.1 32.8 ...
    ##  $ Top10                   : num  0 0 0 0 0 0 0 0 0 1 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   year = col_double(),
    ##   ..   songtitle = col_character(),
    ##   ..   artistname = col_character(),
    ##   ..   songID = col_character(),
    ##   ..   artistID = col_character(),
    ##   ..   timesignature = col_double(),
    ##   ..   timesignature_confidence = col_double(),
    ##   ..   loudness = col_double(),
    ##   ..   tempo = col_double(),
    ##   ..   tempo_confidence = col_double(),
    ##   ..   key = col_double(),
    ##   ..   key_confidence = col_double(),
    ##   ..   energy = col_double(),
    ##   ..   pitch = col_double(),
    ##   ..   timbre_0_min = col_double(),
    ##   ..   timbre_0_max = col_double(),
    ##   ..   timbre_1_min = col_double(),
    ##   ..   timbre_1_max = col_double(),
    ##   ..   timbre_2_min = col_double(),
    ##   ..   timbre_2_max = col_double(),
    ##   ..   timbre_3_min = col_double(),
    ##   ..   timbre_3_max = col_double(),
    ##   ..   timbre_4_min = col_double(),
    ##   ..   timbre_4_max = col_double(),
    ##   ..   timbre_5_min = col_double(),
    ##   ..   timbre_5_max = col_double(),
    ##   ..   timbre_6_min = col_double(),
    ##   ..   timbre_6_max = col_double(),
    ##   ..   timbre_7_min = col_double(),
    ##   ..   timbre_7_max = col_double(),
    ##   ..   timbre_8_min = col_double(),
    ##   ..   timbre_8_max = col_double(),
    ##   ..   timbre_9_min = col_double(),
    ##   ..   timbre_9_max = col_double(),
    ##   ..   timbre_10_min = col_double(),
    ##   ..   timbre_10_max = col_double(),
    ##   ..   timbre_11_min = col_double(),
    ##   ..   timbre_11_max = col_double(),
    ##   ..   Top10 = col_double()
    ##   .. )

### Understanding the Data

How many songs does the dataset include for which the artist name is
“Michael Jackson”?

``` r
count(songs, artistname == "Michael Jackson")
```

    ## # A tibble: 2 x 2
    ##   `artistname == "Michael Jackson"`     n
    ##   <lgl>                             <int>
    ## 1 FALSE                              7556
    ## 2 TRUE                                 18

### divide data

``` r
SongsTrain = filter(songs, year <= 2009)
str(SongsTrain)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 7201 obs. of  39 variables:
    ##  $ year                    : num  2009 2009 2009 2009 2009 ...
    ##  $ songtitle               : chr  "The Awkward Goodbye" "Rubik's Cube" "Superhuman Touch" "The Getaway" ...
    ##  $ artistname              : chr  "Athlete" "Athlete" "Athlete" "Athlete" ...
    ##  $ songID                  : chr  "SOUALGK12AB017FC37" "SOGPIQC12AB0182B15" "SOBNYZN13774E81F76" "SOHFEOA1366EE931DD" ...
    ##  $ artistID                : chr  "ARDW3YJ1187FB4CCE5" "ARDW3YJ1187FB4CCE5" "ARDW3YJ1187FB4CCE5" "ARDW3YJ1187FB4CCE5" ...
    ##  $ timesignature           : num  3 3 4 4 4 4 4 4 4 4 ...
    ##  $ timesignature_confidence: num  0.732 0.906 0.987 0.822 0.983 1 0.821 0.997 0.816 1 ...
    ##  $ loudness                : num  -6.32 -9.54 -4.84 -5.27 -6.23 ...
    ##  $ tempo                   : num  89.6 117.7 119 71.5 77.5 ...
    ##  $ tempo_confidence        : num  0.652 0.542 0.838 0.613 0.74 0.821 0.912 0.609 0.786 0.27 ...
    ##  $ key                     : num  1 0 6 4 8 9 6 9 0 9 ...
    ##  $ key_confidence          : num  0.773 0.722 0.106 0.781 0.552 0.218 0.275 0.333 0.634 0.578 ...
    ##  $ energy                  : num  0.599 0.363 0.76 0.755 0.524 ...
    ##  $ pitch                   : num  0.004 0.006 0.003 0.014 0.008 0.012 0.002 0.003 0.001 0.006 ...
    ##  $ timbre_0_min            : num  0 0.739 0 0 0 ...
    ##  $ timbre_0_max            : num  57.8 57.1 57.8 58.3 57.6 ...
    ##  $ timbre_1_min            : num  -62.3 -220.2 -189.7 -113.9 -160.6 ...
    ##  $ timbre_1_max            : num  286 241 187 171 217 ...
    ##  $ timbre_2_min            : num  -81.8 -96.8 -139.1 -71.6 -79.5 ...
    ##  $ timbre_2_max            : num  211 215 135 195 114 ...
    ##  $ timbre_3_min            : num  -217 -202 -116 -276 -184 ...
    ##  $ timbre_3_max            : num  203.2 124.2 94.7 146.3 108.7 ...
    ##  $ timbre_4_min            : num  -55.9 -52.4 -55.6 -59.4 -31.9 ...
    ##  $ timbre_4_max            : num  97.6 131.9 79.3 121.7 169.7 ...
    ##  $ timbre_5_min            : num  -62.5 -73.9 -73.5 -71.1 -73 ...
    ##  $ timbre_5_max            : num  82.2 73.6 41 39.6 233.9 ...
    ##  $ timbre_6_min            : num  -82.1 -63.5 -41.5 -77.8 -76 ...
    ##  $ timbre_6_max            : num  59.2 70.1 62.8 94.5 58 ...
    ##  $ timbre_7_min            : num  -109.4 -90.1 -69.3 -69.1 -78.8 ...
    ##  $ timbre_7_max            : num  71 112.9 90.4 93.4 100.8 ...
    ##  $ timbre_8_min            : num  -71.8 -64.5 -52.5 -55.8 -61.4 ...
    ##  $ timbre_8_max            : num  58.4 58.1 40.7 79 50.3 ...
    ##  $ timbre_9_min            : num  -53.8 -76.9 -50.4 -51.5 -63 ...
    ##  $ timbre_9_max            : num  88.6 74.4 58.8 70.5 96.8 ...
    ##  $ timbre_10_min           : num  -89.8 -88.2 -78.2 -74.9 -90.4 ...
    ##  $ timbre_10_max           : num  38 42.2 35.3 30.8 60.5 ...
    ##  $ timbre_11_min           : num  -52.1 -66.8 -54.2 -51.4 -52.1 ...
    ##  $ timbre_11_max           : num  52.8 40.7 46.5 27.8 48.1 ...
    ##  $ Top10                   : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   year = col_double(),
    ##   ..   songtitle = col_character(),
    ##   ..   artistname = col_character(),
    ##   ..   songID = col_character(),
    ##   ..   artistID = col_character(),
    ##   ..   timesignature = col_double(),
    ##   ..   timesignature_confidence = col_double(),
    ##   ..   loudness = col_double(),
    ##   ..   tempo = col_double(),
    ##   ..   tempo_confidence = col_double(),
    ##   ..   key = col_double(),
    ##   ..   key_confidence = col_double(),
    ##   ..   energy = col_double(),
    ##   ..   pitch = col_double(),
    ##   ..   timbre_0_min = col_double(),
    ##   ..   timbre_0_max = col_double(),
    ##   ..   timbre_1_min = col_double(),
    ##   ..   timbre_1_max = col_double(),
    ##   ..   timbre_2_min = col_double(),
    ##   ..   timbre_2_max = col_double(),
    ##   ..   timbre_3_min = col_double(),
    ##   ..   timbre_3_max = col_double(),
    ##   ..   timbre_4_min = col_double(),
    ##   ..   timbre_4_max = col_double(),
    ##   ..   timbre_5_min = col_double(),
    ##   ..   timbre_5_max = col_double(),
    ##   ..   timbre_6_min = col_double(),
    ##   ..   timbre_6_max = col_double(),
    ##   ..   timbre_7_min = col_double(),
    ##   ..   timbre_7_max = col_double(),
    ##   ..   timbre_8_min = col_double(),
    ##   ..   timbre_8_max = col_double(),
    ##   ..   timbre_9_min = col_double(),
    ##   ..   timbre_9_max = col_double(),
    ##   ..   timbre_10_min = col_double(),
    ##   ..   timbre_10_max = col_double(),
    ##   ..   timbre_11_min = col_double(),
    ##   ..   timbre_11_max = col_double(),
    ##   ..   Top10 = col_double()
    ##   .. )

``` r
SongsTest = filter(songs, year == 2010)
str(SongsTest)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 373 obs. of  39 variables:
    ##  $ year                    : num  2010 2010 2010 2010 2010 2010 2010 2010 2010 2010 ...
    ##  $ songtitle               : chr  "This Is the House That Doubt Built" "Sticks & Bricks" "All I Want" "It's Complicated" ...
    ##  $ artistname              : chr  "A Day to Remember" "A Day to Remember" "A Day to Remember" "A Day to Remember" ...
    ##  $ songID                  : chr  "SOBGGAB12C5664F054" "SOPAQHU1315CD47F31" "SOOIZOU1376E7C6386" "SODRYWD1315CD49DBE" ...
    ##  $ artistID                : chr  "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" "AROBSHL1187B9AFB01" ...
    ##  $ timesignature           : num  3 4 4 4 4 4 4 4 4 4 ...
    ##  $ timesignature_confidence: num  0.853 1 1 1 0.788 1 0.968 0.861 0.622 0.938 ...
    ##  $ loudness                : num  -4.26 -4.05 -3.57 -3.81 -4.71 ...
    ##  $ tempo                   : num  91.5 140 160.5 97.5 140.1 ...
    ##  $ tempo_confidence        : num  0.953 0.921 0.489 0.794 0.286 0.347 0.273 0.83 0.018 0.929 ...
    ##  $ key                     : num  11 10 2 1 6 4 10 5 9 11 ...
    ##  $ key_confidence          : num  0.453 0.469 0.209 0.632 0.483 0.627 0.715 0.423 0.751 0.602 ...
    ##  $ energy                  : num  0.967 0.985 0.99 0.939 0.988 ...
    ##  $ pitch                   : num  0.024 0.025 0.026 0.013 0.063 0.038 0.026 0.033 0.027 0.004 ...
    ##  $ timbre_0_min            : num  0.002 0 0.003 0 0 ...
    ##  $ timbre_0_max            : num  57.3 57.4 57.4 57.8 56.9 ...
    ##  $ timbre_1_min            : num  -6.5 -37.4 -17.2 -32.1 -223.9 ...
    ##  $ timbre_1_max            : num  171 171 171 221 171 ...
    ##  $ timbre_2_min            : num  -81.7 -149.6 -72.9 -138.6 -147.2 ...
    ##  $ timbre_2_max            : num  95.1 180.3 157.9 173.4 166 ...
    ##  $ timbre_3_min            : num  -285 -380.1 -204 -73.5 -128.1 ...
    ##  $ timbre_3_max            : num  259 384 251 373 389 ...
    ##  $ timbre_4_min            : num  -40.4 -48.7 -66 -55.6 -43.9 ...
    ##  $ timbre_4_max            : num  73.6 100.4 152.1 119.2 99.3 ...
    ##  $ timbre_5_min            : num  -104.7 -87.3 -98.7 -77.5 -96.1 ...
    ##  $ timbre_5_max            : num  183.1 42.8 141.4 141.2 38.3 ...
    ##  $ timbre_6_min            : num  -88.8 -86.9 -88.9 -70.8 -110.8 ...
    ##  $ timbre_6_max            : num  73.5 75.5 66.5 64.5 72.4 ...
    ##  $ timbre_7_min            : num  -71.1 -65.8 -67.4 -63.7 -55.9 ...
    ##  $ timbre_7_max            : num  82.5 106.9 80.6 96.7 110.3 ...
    ##  $ timbre_8_min            : num  -52 -61.3 -59.8 -78.7 -56.5 ...
    ##  $ timbre_8_max            : num  39.1 35.4 46 41.1 37.6 ...
    ##  $ timbre_9_min            : num  -35.4 -81.9 -46.3 -49.2 -48.6 ...
    ##  $ timbre_9_max            : num  71.6 74.6 59.9 95.4 67.6 ...
    ##  $ timbre_10_min           : num  -126.4 -103.8 -108.3 -102.7 -52.8 ...
    ##  $ timbre_10_max           : num  18.7 121.9 33.3 46.4 22.9 ...
    ##  $ timbre_11_min           : num  -44.8 -38.9 -43.7 -59.4 -50.4 ...
    ##  $ timbre_11_max           : num  26 22.5 25.7 37.1 32.8 ...
    ##  $ Top10                   : num  0 0 0 0 0 0 0 0 0 1 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   year = col_double(),
    ##   ..   songtitle = col_character(),
    ##   ..   artistname = col_character(),
    ##   ..   songID = col_character(),
    ##   ..   artistID = col_character(),
    ##   ..   timesignature = col_double(),
    ##   ..   timesignature_confidence = col_double(),
    ##   ..   loudness = col_double(),
    ##   ..   tempo = col_double(),
    ##   ..   tempo_confidence = col_double(),
    ##   ..   key = col_double(),
    ##   ..   key_confidence = col_double(),
    ##   ..   energy = col_double(),
    ##   ..   pitch = col_double(),
    ##   ..   timbre_0_min = col_double(),
    ##   ..   timbre_0_max = col_double(),
    ##   ..   timbre_1_min = col_double(),
    ##   ..   timbre_1_max = col_double(),
    ##   ..   timbre_2_min = col_double(),
    ##   ..   timbre_2_max = col_double(),
    ##   ..   timbre_3_min = col_double(),
    ##   ..   timbre_3_max = col_double(),
    ##   ..   timbre_4_min = col_double(),
    ##   ..   timbre_4_max = col_double(),
    ##   ..   timbre_5_min = col_double(),
    ##   ..   timbre_5_max = col_double(),
    ##   ..   timbre_6_min = col_double(),
    ##   ..   timbre_6_max = col_double(),
    ##   ..   timbre_7_min = col_double(),
    ##   ..   timbre_7_max = col_double(),
    ##   ..   timbre_8_min = col_double(),
    ##   ..   timbre_8_max = col_double(),
    ##   ..   timbre_9_min = col_double(),
    ##   ..   timbre_9_max = col_double(),
    ##   ..   timbre_10_min = col_double(),
    ##   ..   timbre_10_max = col_double(),
    ##   ..   timbre_11_min = col_double(),
    ##   ..   timbre_11_max = col_double(),
    ##   ..   Top10 = col_double()
    ##   .. )

### Creating Prediction Model

exclude some of the variables in dataset from being used as independent
variables

``` r
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")

# To remove these variables from your training and testing sets, type the following commands in your R console:

SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]

SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]
```

build a logistic regression model

``` r
SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
summary(SongsLog1)
```

    ## 
    ## Call:
    ## glm(formula = Top10 ~ ., family = binomial, data = SongsTrain)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.9220  -0.5399  -0.3459  -0.1845   3.0770  
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)               1.470e+01  1.806e+00   8.138 4.03e-16 ***
    ## timesignature             1.264e-01  8.674e-02   1.457 0.145050    
    ## timesignature_confidence  7.450e-01  1.953e-01   3.815 0.000136 ***
    ## loudness                  2.999e-01  2.917e-02  10.282  < 2e-16 ***
    ## tempo                     3.634e-04  1.691e-03   0.215 0.829889    
    ## tempo_confidence          4.732e-01  1.422e-01   3.329 0.000873 ***
    ## key                       1.588e-02  1.039e-02   1.529 0.126349    
    ## key_confidence            3.087e-01  1.412e-01   2.187 0.028760 *  
    ## energy                   -1.502e+00  3.099e-01  -4.847 1.25e-06 ***
    ## pitch                    -4.491e+01  6.835e+00  -6.570 5.02e-11 ***
    ## timbre_0_min              2.316e-02  4.256e-03   5.441 5.29e-08 ***
    ## timbre_0_max             -3.310e-01  2.569e-02 -12.882  < 2e-16 ***
    ## timbre_1_min              5.881e-03  7.798e-04   7.542 4.64e-14 ***
    ## timbre_1_max             -2.449e-04  7.152e-04  -0.342 0.732087    
    ## timbre_2_min             -2.127e-03  1.126e-03  -1.889 0.058843 .  
    ## timbre_2_max              6.586e-04  9.066e-04   0.726 0.467571    
    ## timbre_3_min              6.920e-04  5.985e-04   1.156 0.247583    
    ## timbre_3_max             -2.967e-03  5.815e-04  -5.103 3.34e-07 ***
    ## timbre_4_min              1.040e-02  1.985e-03   5.237 1.63e-07 ***
    ## timbre_4_max              6.110e-03  1.550e-03   3.942 8.10e-05 ***
    ## timbre_5_min             -5.598e-03  1.277e-03  -4.385 1.16e-05 ***
    ## timbre_5_max              7.736e-05  7.935e-04   0.097 0.922337    
    ## timbre_6_min             -1.686e-02  2.264e-03  -7.445 9.66e-14 ***
    ## timbre_6_max              3.668e-03  2.190e-03   1.675 0.093875 .  
    ## timbre_7_min             -4.549e-03  1.781e-03  -2.554 0.010661 *  
    ## timbre_7_max             -3.774e-03  1.832e-03  -2.060 0.039408 *  
    ## timbre_8_min              3.911e-03  2.851e-03   1.372 0.170123    
    ## timbre_8_max              4.011e-03  3.003e-03   1.336 0.181620    
    ## timbre_9_min              1.367e-03  2.998e-03   0.456 0.648356    
    ## timbre_9_max              1.603e-03  2.434e-03   0.659 0.510188    
    ## timbre_10_min             4.126e-03  1.839e-03   2.244 0.024852 *  
    ## timbre_10_max             5.825e-03  1.769e-03   3.292 0.000995 ***
    ## timbre_11_min            -2.625e-02  3.693e-03  -7.108 1.18e-12 ***
    ## timbre_11_max             1.967e-02  3.385e-03   5.811 6.21e-09 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 6017.5  on 7200  degrees of freedom
    ## Residual deviance: 4759.2  on 7167  degrees of freedom
    ## AIC: 4827.2
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
#Conclusion
#20 variables have at least one star next to the p-values, which represents significance at the 5% level.
#The higher our confidence about time signature, key and tempo, the more likely the song is to be in the Top 10
#Mainstream listeners tend to prefer less complex songs
#Mainstream listeners prefer songs with heavy instrumentation
```

### Validating Model

``` r
SongsTestPred = predict(SongsLog1, newdata = SongsTest, type = "response")
#create a confusion matrix with a threshold of 0.45 
table(SongsTest$Top10, SongsTestPred >= 0.45)
```

    ##    
    ##     FALSE TRUE
    ##   0   309    5
    ##   1    44   15

``` r
#accuracy
(309+15)/(309+5+44+15)
```

    ## [1] 0.8686327

``` r
# accuracy of the baseline model be on the test set(an easier model would be to pick the most frequent outcome (a song is not a Top 10 hit) for all songs.) 
table(SongsTest$Top10)
```

    ## 
    ##   0   1 
    ## 314  59

``` r
#accuracy
314/(314+59)
```

    ## [1] 0.8418231

``` r
#True Positive Rate of model on the test set, using a threshold of 0.45
15/(15+44)
```

    ## [1] 0.2542373

``` r
# False Positive Rate of model on the test set, using a threshold of 0.45?
5/(309+5)
```

    ## [1] 0.01592357
