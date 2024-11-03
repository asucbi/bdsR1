# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here)

# STEP #1 function: scrape_pac() ---------------------------------------------------------

# NOTE: you might want to try doing each part of the function in Step 1 outside of
# the function to make sure it works on one URL
# and then convert it to a function when you know each section works

scrape_pac <- function(static_url) {
  
  # READ THE PAGE
  page <- ___(here("static-pages-opensecrets", static_url)) # HINT: what's the rvest function for reading an html page?

  # EXTRACT THE TABLE (calling it "pac")
  pac <-  page %>%
   # select node .component-wrap (I already identified the right CSS selector using the SelectorGadget given these are static HTML pages)
   html_nodes(".component-wrap") %>% 
   html_table(header=___) %>% # HINT: set this to TRUE or FALSE?
   # extract table
   pluck(2)
  
 # RENAME VARIABLES
 pac <- pac %>%
   # rename columns 
   rename(
     name = ___ , # HINT: the names need to be written exactly as they are displayed on the website
     country_parent = ___,
     total = ___,
     dems = ___,
     repubs = ___
   )

  # ADD YEAR
 pac <- pac %>%
   # extract the 4 characters of the URL and save as year
   mutate(year = str_sub(static_url, ___, ___))

 # RETURN DATAFRAME
 pac

}

## STEP #2 test function ----------------------------------------------------------------

static_url_2022 <- "___" # what's the URL for the 2022 data table?
pac_2022 <- scrape_pac(___) 

static_url_2020 <- "___" # for 2020?
pac_2020 <- scrape_pac(___)

static_url_2000 <- "___" # for 2000?
pac_2000 <- scrape_pac(___)

## STEP #3 list of urls -----------------------------------------------------------------

# first part of static url filename
prefix <- ___

# middle part of static url filename (election years as a sequence, skipping odd years: start at 2000 and go to 2024 by every other year)
year <- seq(from = ___, to = ___, by = ___)

# last part of static url filename
suffix <- ___

# reconstruct static URL filenames (by pasting first, middle, and last parts together)
urls <- paste0(___, ___, ___)

## STEP #4 map the scrape_pac function over list of urls --------------------------------
pac_all <- ___(___, ___)

## STEP #5 write data -------------------------------------------------------------------

write_csv(___, file = here("data", "pac-all.csv"))
