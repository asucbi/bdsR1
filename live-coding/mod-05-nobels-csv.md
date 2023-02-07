Nobel winners
================
Nicholas Duran

``` r
library(tidyverse)
```

Let’s first load the data:

``` r
nobel <- ___(___)
```

Then let’s split the data into two:
<!-- **Hint:** Use the `%in%` operator when `filter()`ing. -->

``` r
# stem laureates
___ <- nobel %>%
  filter(___)

# non-steam laureates
___ <- nobel %>%
  filter(___)
```

And finally write out the data:

``` r
# add code for writing out the two data frames here
```

<!-- NOTES TO SELF: -->
<!-- Could, at this point, talk about fct_relevel and how these changes do not save to .csv and require you to save to .rsd-->
<!-- Could also demonstrate when NAs work their way in and what to do in terms of column specification-->
