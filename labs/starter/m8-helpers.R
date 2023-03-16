simd1 <- tibble(
  x = rnorm(50),
  y = .4*x + rnorm(50)
)


calc_rss <- function(x, y, a, b){
  ypred <- a + x*b
  sum((y-ypred)^2)
}


plot_reg_rss <- function(x, y, a, b){
  
  rss <- calc_rss(simd2$x, simd2$y, intercept2, slope2)
  
  tibble(x=x, y=y) %>% 
    ggplot(aes(x=x, y =y )) +
    geom_point() +
    geom_abline(intercept = intercept1, slope=slope1, color="red") +
    annotate("text", x = 2, y = -2, label = paste("RSS = ", round(rss, 2)))
}


