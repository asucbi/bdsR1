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
  html_nodes(".pf-statement-quote-pants-fire") %>%
  html_text2()

# Exercise 2: scrape links ---------------------------------------------------------------

links <- page %>%
  html_nodes(".pf-statement-quote-pants-fire") %>%   
  html_attr("href") 

# Exercise 3: scrape sources ---------------------------------------------------------------

sources <- page %>%
  html_nodes(".pf-statement-person") %>%
  html_text2()

# Exercise 4: scrape descriptions ----------------------------------------------------------

descriptions <- page %>%
  html_nodes(".pf-statement-date") %>%
  html_text2()

# Exercise 5: put together in a data frame -------------------------------------------------

first_twenty <- tibble(
  source = sources,
  statement = statements,
  description = descriptions,
  link = links
)

# Exercise 6: scrape next twenty fact-checks ------------------------------------------------

second_url <- "https://www.politifact.com/factchecks/list/?page=2&ruling=pants-fire"

## repeat code from exercises 1 through 5 to create "second_twenty," for example:

page <- read_html(second_url)

statements <- page %>%
  html_nodes(".pf-statement-quote-pants-fire") %>%
  html_text2()

links <- page %>%
  html_nodes(".pf-statement-quote-pants-fire") %>%   
  html_attr("href") 

sources <- page %>%
  html_nodes(".pf-statement-person") %>%
  html_text2()

descriptions <- page %>%
  html_nodes(".pf-statement-date") %>%
  html_text2()

second_twenty <- tibble(
  source = sources,
  statement = statements,
  description = descriptions,
  link = links
) 

