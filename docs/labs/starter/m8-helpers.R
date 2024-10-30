simd1 <- read_csv("data/simd1.csv")
simd2 <- read_csv("data/simd2.csv")


calc_rss <- function(x, y, a, b){
  ypred <- a + x*b
  sum((y-ypred)^2)
}


plot_reg_rss <- function(x, y, a, b){
  
  rss <- calc_rss(x, y, a, b)
  
  tibble(x=x, y=y) %>%
    ggplot(aes(x=x, y =y)) +
    geom_point() +
    geom_abline(intercept = a, slope = b, color="red") +
    annotate("text", x = 2, y = -2, label = paste("RSS = ", round(rss, 2))) +
    xlim(-3, 3)
}

