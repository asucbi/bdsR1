# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# set url ----------------------------------------------------------------------

first_url <- "https://www.politifact.com/factchecks/list/?ruling=pants-fire"

# read first page --------------------------------------------------------------

page <- read_html(first_url)

# scrape statements ----------------------------------------------------------------

statements <- page %>%
  html_nodes(".m-statement__quote") %>%
  ___()

# scrape links -----------------------------------------------------------------

links <- page %>%
  html_nodes(".m-statement__quote") %>%
  html_element("a") %>%
  html_attr("href") %>%
  str_c("___", .)

# scrape sources ---------------------------------------------------------------

sources <- page %>%
  html_nodes(".m-statement__name") %>%
  ___

# scrape descriptions ----------------------------------------------------------

descriptions <- page %>%
  html_nodes("___") %>%
  ___

# put together in a data frame -------------------------------------------------

first_thirty <- tibble(
  source = ___,
  statement = ___,
  description = ___,
  link = ___
)

# scrape next thirty fact-checks ------------------------------------------------

second_url <- "___"

page <- read_html(second_url)
...

second_thirty <- tibble(
  ...
)