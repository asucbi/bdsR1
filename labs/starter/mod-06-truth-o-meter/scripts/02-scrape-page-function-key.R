# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# Exercise 7: function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape statements
  statements <- page %>%
    html_nodes(".pf-statement-quote-pants-fire") %>%
    html_text2()
  
  # scrape links
  links <- page %>%
    html_nodes(".pf-statement-quote-pants-fire") %>%   
    html_attr("href") 
  
  # scrape sources 
  sources <- page %>%
    html_nodes(".pf-statement-person") %>%
    html_text2()
  
  # scrape descriptions 
  descriptions <- page %>%
    html_nodes(".pf-statement-date") %>%
    html_text2()
  
  # create and return tibble
  tibble(
    source = sources,
    statement = statements,
    description = descriptions,
    link = links
  ) 
  
}
