# load the iris data
data(iris)

# peek at the data
head(iris)

# look at the unique species
unique(iris$Species)

# create a scatterplot matrix using first 4 columns
plot(iris[1:4])

# create a scatterplot of petal length vs width
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width
)

# create a linear regression model
 x <- iris$Petal.Length
 
 y <- iris$Petal.Width
 
 model <-lm(y ~ x)
 
 # draw linear regression model on plot
 lines(
   x = iris$Petal.Length,
   y = model$fitted,
   col = "red",
   lwd = 3)
 
 # get correlation coefficient
 cor(
   x = iris$Petal.Length,
   y = iris$Petal.Width) # correlation of 0.9628654
 
 # summarize the model
 summary(model)
 
 # predict new unknown values from the model
 predict(
   object = model,
   newdata = data.frame(x = c(2,5,7))) # predicted widths: 0.468, 1.716, 2.547
 
 