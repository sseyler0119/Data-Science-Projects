# Creating Statistical Models

# 1) How are petal length and petal width related?
# 2) Can we predict new petal width values?

# load the data
data(iris)

# peark at the data
head(data)

# create a scatterplot
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  main = "Iris Petal Length vs. Width",
  xlab = "Petal Length (cm)",
  ylab = "Petal Width (cm)")


# create a linear regression model using lm function
model <- lm(
  formula = Petal.Width ~ Petal.Length,
  data = iris)

# sumarize the model
summary(model)

# draw a regression line on plot
lines(
  x = iris$Petal.Length,
  y = model$fitted,
  col = "red",
  lwd = 3) # increase width of line to 3 pixels

# get the correlation coefficient
cor(
  x = iris$Petal.Length,
  y = iris$Petal.Width)

# predict new values from the model
predict(
  object = model,
  newdata = data.frame(
    Petal.Length = c(2, 5, 7))) # testing 2cm, 5cm, and 7cm petal lengths



