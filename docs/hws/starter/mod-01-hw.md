HW 01 - Parks and Recreation
================
Insert your name here
Insert date here

## Load packages and data

``` r
library(tidyverse)
library(bdsdata)
```

This is a R Markdown document!

## Exercises

### Exercise 1

There are \_\_\_ unique charachters from the show in the dataset.

### Exercise 2

Remove this text, and add your answer for Exercise 2 here.

### Exercise 3

Remove this text, and add your answer for Exercise 3 here.

``` r
parks_rec %>%
  count(character, sort = TRUE)
```

    ##    character   n
    ## 1     Leslie 119
    ## 2        Ron  64
    ## 3        Tom  55
    ## 4        Ben  54
    ## 5       Andy  51
    ## 6      Chris  38
    ## 7        Ann  36
    ## 8      April  35
    ## 9      Donna   9
    ## 10     Jerry   8

### Exercise 4

``` r
# remove this comment and add the code for Exercise 4 here
```

### Exercise 5

Remove this text, and add your answer for Exercise 5 here.

### Exercise 6

Remove this text, and add your answer for Exercise 6 here.
