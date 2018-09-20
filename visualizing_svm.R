library(ggplot2)
library(e1071)

set.seed(13)
x <- matrix(rnorm(300), 150, 2)
y <- rep(c(-1, 0, 1), c(60, 50, 40))
x[y == 1, ] <- x[y == 1, ] + 4
x[y == 0, ] <- x[y == 0, ] ^ 2
x[y == -1, ] <- x[y == -1, ] + 6
data <- data.frame(x, Y = as.factor(y))
ggplot(data, aes(x = X1, y = X2, col = Y)) +
  geom_point() + theme_minimal() + 
  scale_color_brewer(palette = "Set1")

## building our SVM MODEL
svm.fit <- svm(Y ~ ., data = data, 
               kernel = "radial", cost = 10, scale = FALSE)

## building a grid
grid <- apply(x, 2, range)
x1 <- seq(grid[1, 1], grid[2, 1], length = 75)
x2 <- seq(grid[1, 2], grid[2, 2], length = 75)
xgrid <- expand.grid(X1 = x1, X2 = x2)
xgrid$ygrid <- factor(predict(svm.fit, xgrid))

## plotting the grid and store it
g <- ggplot(xgrid, aes(x = X1, y = X2, col = ygrid)) +
  geom_point(size = 2, alpha = 0.3) + theme_minimal() + 
  scale_color_brewer(palette = "Set1")

## plotting the data on the grid to assess its performance
g + geom_point(data = data, aes(x = data[, 1], y = data[, 2], col = Y)) +
  guides(alpha = FALSE, size = FALSE) + theme_minimal() + 
  scale_color_brewer(palette = "Set1")

