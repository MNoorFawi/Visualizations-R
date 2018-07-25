########## VISUALIZING DIFFERENT MOVING AVERAGE WITH TIME SERIES ###########
### define functions that calculate Moving Averages
### sma "simple moving average"
sma <- function(x, n = 15) {
  res <- x
  for (i in n:length(x)) {
    res[i] <- mean(x[(i - n + 1):i])
  }
  res
}

### ema "Exponential Moving Average" 
## EMA today = (value today × K) + (EMA yesterday × (1 - K))
## first EMA is the first Value in the series ...

ema <- function(x, n = 5) {
  res <-rep(0, length(x))
  k <- 2 / (n + 1)
  res[1] <- x[1]
  for (i in 2:length(x)) {
    res[i] <- (x[i] * k) + (res[i - 1] * (1 - k))
  }
  return(res)
}

## smoothing a two-sided moving average
wma <- function(x, k = c(0.5, 1, 1, 1, 0.5)){
  # k is the vector of weights
  k <- k / sum(k)       
  two_sided <- stats::filter(x, sides = 2, k)
  as.numeric(two_sided)
}

### preparing the data from EuStockMarkets datasets
library(lubridate)
times <- as.numeric(time(EuStockMarkets))[1:100]
cac <- as.numeric(EuStockMarkets[, 3])[1:100]
df <- data.frame(times = times, cac = cac)

### VISUALIZING ALL THESE LINES USING GGPLOT2
df$ema6 <- ema(df$cac, 6)
df$ema9 <- ema(df$cac, 9)
df$ema12 <- ema(df$cac, 12)
df$sma15 <- sma(df$cac, 15)
df$wma <- wma(df$cac)

##ggplot2
library(ggplot2)
library(reshape2)
predictions <- melt(df, id.vars = c('times', 'cac'))
ggplot(predictions, aes(x = times, y = value, color = factor(variable))) +
  geom_line(size = 1) + 
  geom_point(aes(y = cac), color = 'black') +
  geom_line(aes(y = cac), color = 'black', alpha = 0.3) +
  geom_smooth(se = FALSE, color = 'black') +
  geom_smooth(se = FALSE, method = 'lm', 
              color = 'grey80') +
  theme_bw()

