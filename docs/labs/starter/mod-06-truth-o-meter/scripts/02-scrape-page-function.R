# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# question 7: function: scrape_page --------------------------------------------------------

___ <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape statements
  statements <- ___
  
  # scrape links
  links <- ___
  
  # scrape sources 
  sources <- ___
  
  # scrape descriptions 
  descriptions <- ___
  
  # create and return tibble
  tibble(
    ___
  )
  
}
