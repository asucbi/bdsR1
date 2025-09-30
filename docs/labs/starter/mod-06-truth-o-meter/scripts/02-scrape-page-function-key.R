# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# Exercise 7: function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape statements
  statements <- page %>%
    html_nodes(".m-statement__quote") %>%
    html_text2()
  
  # scrape links
  links <- page %>%
    html_nodes(".m-statement__quote") %>%
    html_element("a") %>%
    html_attr("href") %>%
    str_c("https://www.politifact.com", .)
  
  # scrape sources 
  sources <- page %>%
    html_nodes(".m-statement__name") %>%
    html_text2()
  
  # scrape descriptions 
  descriptions <- page %>%
    html_nodes(".m-statement__desc") %>%
    html_text2()
  
  # create and return tibble
  tibble(
    source = sources,
    statement = statements,
    description = descriptions,
    link = links
  ) 
  
}
