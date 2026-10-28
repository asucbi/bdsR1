# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(robotstxt)

# check permission --------------------------------------------------------

paths_allowed("https://www.politifact.com/", warn=FALSE)

# set url ----------------------------------------------------------------------

first_url <- "https://www.politifact.com/factchecks/list/?ruling=pants-fire"

# read first page --------------------------------------------------------------

page <- read_html(first_url)

# Exercise 1: scrape statements ----------------------------------------------------------------

statements <- page %>%
  html_nodes("___") %>%
  ___

# Exercise 2: scrape links ---------------------------------------------------------------

links <- page %>%
  html_nodes("___") %>%   
  html_attr("href")

# Exercise 3: scrape sources ---------------------------------------------------------------

sources <- page %>%
  html_nodes("___") %>%
  ___

# Exercise 4: scrape descriptions ----------------------------------------------------------

descriptions <- page %>%
  html_nodes("___") %>%
  ___

# Exercise 5: put together in a data frame -------------------------------------------------

first_twenty <- tibble(
  source = ___,
  statement = ___,
  description = ___,
  link = ___
)

# Exercise 6: scrape next twenty fact-checks ------------------------------------------------

second_url <- "___"

## repeat code from exercises 1 through 5 to create "second_twenty," for example:

page <- read_html(second_url)

... 

second_twenty <- tibble(
  ...
)