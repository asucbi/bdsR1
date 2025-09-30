# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(glue)


# Exercise 10: generate the list of urls to be scraped ---------------------------------

prefix <- "https://www.politifact.com/factchecks/list/?page="
suffix <- "&ruling=mostly-true"

numbers <- seq(from = 0, to = 20, by = 1)
urls <- glue("{prefix}{numbers}{suffix}")

# use map_dfr() to map over all urls and output a data frame --------------

fact_checks_truth <- map_dfr(urls, scrape_page)

# use write_csv() to write out data frame ---------------------------------

write_csv(fact_checks_truth, file = "data/fact_checks_truth.csv")
