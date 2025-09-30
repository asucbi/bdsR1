# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(glue)

# Exercise 8: list of urls to be scraped ---------------------------------------------------

prefix <- "https://www.politifact.com/factchecks/list/?page="
suffix <- "&ruling=pants-fire"

numbers <- seq(from = 0, to = 20, by = 1)
urls <- glue("{prefix}{numbers}{suffix}")

# Exercise 9: map over all urls and output a data frame ------------------------------------

fact_checks_lie <- map_dfr(urls, scrape_page)

# write out data frame ---------------------------------------------------------

write_csv(fact_checks_lie, file = "data/fact_checks_lie.csv")

