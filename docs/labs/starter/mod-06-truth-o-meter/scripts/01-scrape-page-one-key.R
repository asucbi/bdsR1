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
  html_nodes(".m-statement__quote") %>%
  html_text2()

# Exercise 2: scrape links -----------------------------------------------------------------

links <- page %>%
  html_nodes(".m-statement__quote") %>%
  html_element("a") %>%
  html_attr("href") %>%
  str_c("https://www.politifact.com", .)

# Exercise 3: scrape sources ---------------------------------------------------------------

sources <- page %>%
  html_nodes(".m-statement__name") %>%
  html_text2()

# Exercise 4: scrape descriptions ----------------------------------------------------------

descriptions <- page %>%
  html_nodes(".m-statement__desc") %>%
  html_text2()

# Exercise 5: put together in a data frame -------------------------------------------------

first_thirty <- tibble(
  source = sources,
  statement = statements,
  description = descriptions,
  link = links
)

# Exercise 6: scrape next thirty fact-checks ------------------------------------------------

second_url <- "https://www.politifact.com/factchecks/list/?page=2&ruling=pants-fire"

## repeat code from exercises 1 through 5 to create "second_thirty," for example:

page <- read_html(second_url)

statements <- page %>%
  html_nodes(".m-statement__quote") %>%
  html_text2()

links <- page %>%
  html_nodes(".m-statement__quote") %>%
  html_element("a") %>%
  html_attr("href") %>%
  str_c("https://www.politifact.com", .)

sources <- page %>%
  html_nodes(".m-statement__name") %>%
  html_text2()

descriptions <- page %>%
  html_nodes(".m-statement__desc") %>%
  html_text2()

second_thirty <- tibble(
  source = sources,
  statement = statements,
  description = descriptions,
  link = links
) 

