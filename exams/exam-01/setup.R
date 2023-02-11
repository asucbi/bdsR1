# ---
# Exam settings
# ---

# Dropdowns
# source('assets/dropdowns.R')

# Knitr settings
knitr::opts_chunk$set(
    echo = TRUE,
    message = FALSE, 
    warning = FALSE,
    fig.align = 'center',
    out.width = '80%'
)

# ggplot settings
library(ggplot2)
theme_set(
    theme_bw(base_size = 15)
)

## Exam 1 specific

library(tidyverse)
library(nycflights13)

set.seed(42)

flights <- flights %>% 
  slice_sample(prop=.35)