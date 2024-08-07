# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here)

# STEP #1 function: scrape_pac() ---------------------------------------------------------

scrape_pac <- function(url) {
  
  # READ THE PAGE
  page <- ___(url) # HINT: what's the rvest function for reading an html page?
  
  # EXTRACT THE TABLE (calling it "pac")
  pac <-  page %>%
   html_nodes(".component-wrap") %>%
   html_table("td", header=___) %>% # HINT: table has a header so specify it as so
   pluck(2)
  
  ## for "EXTRACT THE TABLE" above, i did all the hard work for you. using...
  ## SelectorGadget i found the css selector where the table is stored (.component-wrap)... 
  ## and read it in. from there, i had to select just the table at node "td"...
  ## and then i used a new function called "pluck" because the table was...
  ## stored in a list at the 2nd element and this plucked it out...
  ## but all you need to worry about is that at this point we have the table...
  ## stored as a dataframe "pac" that we can start doing things with... 
  
 # RENAME VARIABLES
 pac <- pac %>%
   # rename columns 
   rename(
     name = ___ ,
     country_parent = ___,
     total = ___,
     dems = ___,
     repubs = ___
   )

  # ADD YEAR
 pac <- pac %>%
   # extract last 4 characters of the URL and save as year
   mutate(year = str_sub(url, ___, ___))

 # RETURN DATAFRAME
 pac

}

## STEP #2 test function ----------------------------------------------------------------

url_2022 <- "___" # what's the URL for the 2022 data table?
pac_2022 <- scrape_pac(___) 

url_2020 <- "___" # for 2020?
pac_2020 <- scrape_pac(___)

url_2000 <- "___" # for 2000?
pac_2000 <- scrape_pac(___)

## STEP #3 list of urls -----------------------------------------------------------------

# FIRST PART OF URL
root <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/"

# SECOND PART OF URL (election years as a sequence, skipping odd years: start at 2000 and go to 2022 by every other year)
year <- seq(from = ___, to = ___, by = ___)

# CONSTRUCT URLS (by pasting first and second parts together)
urls <- paste0(___, ___)

## STEP #4 map the scrape_pac function over list of urls --------------------------------
pac_all <- ___(___, ___)

## STEP #5 write data -------------------------------------------------------------------

write_csv(___, file = here::here("data/pac-all.csv"))
