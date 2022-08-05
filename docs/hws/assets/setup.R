# ---
# Homework settings
# ---

# Knitr settings
knitr::opts_chunk$set(
  eval = FALSE, 
  message = FALSE,
  warning = FALSE,
  out.width = "80%",
  fig.asp = 0.618,
  fig.width = 8,
  dpi = 300
)

# ggplot settings
library(ggplot2)
theme_set(
    theme_bw(base_size = 15)
)
