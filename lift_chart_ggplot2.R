
# generating the dataset
df <- data.frame(factors = rep(1:4, each = 25),
                 values = rlnorm(100))
# Ordering the dataset
df <- df[order(df$values, decreasing = TRUE), ]

# Creating the cumulative density
df$cum_density <- cumsum(df$values) / sum(df$values)

# Creating the % of population
df$percent_population <- (seq(nrow(df)) / nrow(df)) * 100

# Ploting % of Population vs % of values
plot(df$percent_population, df$cum_density, 
     type = "l", xlab = "% of Population", ylab = "% of values")

### Plotting lift chart with GGPLOT2
ggplot(df, aes(x = percent_population)) + 
  geom_line(aes(y = cum_density), col = "cornflowerblue") + 
  xlab("% of Population") + ylab("% of values") +
  annotate("text", x = 38, y = 0.75, label = "X", col = "red2", size = 6) +
  annotate("text", x = 40, y = 1, label = "almost 75% of values", col = "black", size = 5) +
  annotate("text", x = 40, y = 0.95, label = "from almost 40% of population",
           col = "black", size = 5) +
  annotate("rect", xmin = 0, xmax = 40, ymin = 0, ymax = 1, alpha = 0.2, 
           fill = "yellow") 
