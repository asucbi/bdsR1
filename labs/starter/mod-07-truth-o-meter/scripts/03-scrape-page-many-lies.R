# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(glue)

# list of urls to be scraped ---------------------------------------------------

prefix <- "https://www.politifact.com/factchecks/list/?page="
suffix <- "&ruling=pants-fire"

numbers <- seq(from = ___, to = ___, by = ___)
urls <- glue("{___}{___}{___}")

# map over all urls and output a data frame ------------------------------------

___ <- map_dfr(___, ___)

# write out data frame ---------------------------------------------------------

write_csv(fact_checks_lie, file = "data/fact_checks_lie.csv")