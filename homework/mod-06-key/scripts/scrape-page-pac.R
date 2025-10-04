# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here)
library(httr)
library(robotstxt)
library(scales)
library(readr)

# STEP #1 function: scrape_pac() ---------------------------------------------------------

## NOTE: you might want to try doing each section in Step 1 outside of... 
## the function to make sure it works on one URL...
## and then convert it to a function when you know each section works...

url <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/2024"

scrape_pac <- function(url) {
  
  # READ THE PAGE
  page <- GET(url, user_agent('data scraper ([[your email]])')) %>% read_html() ## <<< do not change this line of code

  # EXTRACT THE TABLE (calling it "pac")
  pac <-  page %>%
   html_nodes(".component-wrap") %>% # find the right CSS selector! if you absolutely cannot find it I rather you reach out via Slack and I will give it to you so you don't get stuck
   html_table(header=TRUE) %>% # HINT: set this to TRUE or FALSE?
   pluck(2)
  
  ## for "EXTRACT THE TABLE" above, i did all the hard work for you. using...
  ## SelectorGadget i found the css selector where the table is stored... 
  ## and read it in.
  ## and then i used a new function called "pluck" because the table was...
  ## stored in a list at the 2nd element and this plucked it out...
  ## but all you need to worry about is that at this point we have the table...
  ## stored as a dataframe "pac" that we can start doing things with... 
  
 # RENAME VARIABLES
 pac <- pac %>%
   # rename columns 
   rename(
     name = "PAC Name (Affiliate)",
     country_parent = "Country of Origin/Parent Company",
     total = "Total",
     dems = "Dems",
     repubs = "Repubs"
   )

  # ADD YEAR
 pac <- pac %>%
   # extract last 4 characters of the URL and save as year
   mutate(year = str_sub(url, 85, 88))

 # RETURN DATAFRAME
 pac

}

## STEP #2 test function ----------------------------------------------------------------

url_2022 <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/2022" # what's the URL for the 2022 data table?
pac_2022 <- scrape_pac(url_2022) 

url_2020 <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/2020" # for 2020?
pac_2020 <- scrape_pac(url_2020)

url_2000 <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/2000" # for 2000?
pac_2000 <- scrape_pac(url_2000)

## STEP #3 list of urls -----------------------------------------------------------------

# FIRST PART OF URL
root <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/"

# SECOND PART OF URL (election years as a sequence, skipping odd years: start at 2000 and go to 2022 by every other year)
year <- seq(from = 2000, to = 2022, by = 2)

# CONSTRUCT URLS (by pasting first and second parts together)
urls <- paste0(root, year)

## STEP #4 map the scrape_pac function over list of urls --------------------------------
pac_all <- map_dfr(urls, scrape_pac)

## STEP #5 write data -------------------------------------------------------------------

write_csv(pac_all, file = here("data/pac-all.csv"))


