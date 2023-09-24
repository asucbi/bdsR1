library(tidyverse)
library(rvest)
library(lubridate)

scrape_speech <- function(url_to_scrape) {
  
  Sys.sleep(runif(1)) 
  
  speech_page <- read_html(url_to_scrape)
  
  title <- speech_page %>%
    html_node(".news") %>%
    html_text2()
  
  date <- speech_page %>%
    html_node(".updated") %>%
    html_text() %>%
    mdy()
  
  location <- speech_page %>%
    html_node(".has-text-align-center") %>%
    html_text2()
  
  text <- speech_page %>%
    html_nodes("p") %>%
    html_text2() %>%
    list()
  
  tibble(
    title = title, date = date, location = location,
    text = text, url= url_to_scrape
  )
}

all_speeches_page1 <- read_html("https://www.whitehouse.gov/briefing-room/speeches-remarks/")
all_speeches_page2 <- read_html("https://www.whitehouse.gov/briefing-room/speeches-remarks/page/2/")
all_speeches_page3 <- read_html("https://www.whitehouse.gov/briefing-room/speeches-remarks/page/3/")

wh_speech_urls1 <- all_speeches_page1 %>%
  html_nodes(".news-item__title") %>%
  html_attr("href")

wh_speech_urls2 <- all_speeches_page2 %>%
  html_nodes(".news-item__title") %>%
  html_attr("href")

wh_speech_urls3 <- all_speeches_page3 %>%
  html_nodes(".news-item__title") %>%
  html_attr("href")

wh_speech_urls = vctrs::vec_c(wh_speech_urls1, wh_speech_urls2, wh_speech_urls3)

wh_speeches <- map_dfr(wh_speech_urls, scrape_speech)

write_rds(wh_speeches, "wh_speeches.rds")

