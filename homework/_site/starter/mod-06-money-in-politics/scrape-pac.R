# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here)

# function: scrape_pac ---------------------------------------------------------

scrape_pac <- function(url) {
  
  # read the page
  page <- ___(___)
  
  # extract the table (THIS IS THE TRICKIEST PART, YOU GET THIS TABLE, EVERYTHING ELSE FOLLOWS)
  pac <-  page %>%
   # select nodes .component-wrap (identified using the SelectorGadget)
   html_nodes(".component-wrap") %>%
   # parse table at node "td" into a data frame 
   # table has a header 
   html_table("td", header= ___) %>%
   # using a new function, "pluck" as output appears to be a list with the relevant table as the "2nd" item in the list
   pluck(2)

 # rename variables. 
 pac <- pac %>%
   # rename columns
   rename(
     name = ___ ,
     country_parent = ___,
     total = ___,
     dems = ___,
     repubs = ___
   )

  # add year
 pac <- pac %>%
   # extract last 4 characters of the URL and save as year
   mutate(year = ___)

 # return data frame
 pac

}

## test function ----------------------------------------------------------------

url_2022 <- "___"
pac_2022 <- scrape_pac(___)

url_2020 <- "___"
pac_2020 <- scrape_pac(___)

url_2000 <- "___"
pac_2000 <- scrape_pac(___)

## list of urls -----------------------------------------------------------------

# first part of url
root <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs/"

# second part of url (election years as a sequence, skipping odd years: start at 2000 and go to 2022 by every other year)
year <- seq(from = ___, to = ___, by = ___)

# construct urls by pasting first and second parts together
urls <- paste0(___, ___)

# map the scrape_pac function over list of urls --------------------------------
pac_all <- ___(___, ___)

## write data -------------------------------------------------------------------

write_csv(___, file = here::here("data/pac-all.csv"))
