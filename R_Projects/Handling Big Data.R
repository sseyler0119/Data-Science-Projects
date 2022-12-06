# Handling Big Data

# How are petal length and petal width related?
# Can we predict new petal width values?


# set the working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") # use / instead of \ for directory

# load the ff package
library(ff)

# read a csv file as ff data frame
irisff <- read.table.ffdf( # creates a pointer to the data frame
  file = "Iris.csv",
  FUN = "read.csv")

# inspect the class
class(irisff) # returns object of type ffdf instead of the data frame

# inspect the column names
names(irisff)

# inspect the first few rows
irisff[1:5,] # can't use head function, need to use indexing operators

# load the biglm package
library(biglm)

# create linear regression model
model <- biglm(
  formula = Petal.Width ~ Petal.Length,
  data = irisff)

# summarize the model
summary(model)

# create a scatterplot
plot(
  x = iris$Petal.Length[], # [] required because this is just a pointer to the data, not the data itself
  y = iris$Petal.Width[],
  main = "Iris Petal Length vs Width",
  xlab = "Petal Length (cm)",
  ylab = "Petal Width (cm)")

# get the y-intercept from model
 b<- summary(model)$mat[1,1]
 
 # get slope from model
 m <- summary(model)$mat[2,1]
 
 # draw a regression line on plot, y = mx + b
 lines(
   x = irisff$Petal.Length[],
    y = m * irisff$Petal.Length[] + b, 
   col = "red",
   lwd = 3)
 
 # predict new values with the model
 predict(
   object = model,
   newdata = data.frame(
     Petal.Length = c(2, 5, 7),
     Petal.Width = c(0, 0, 0)))
 
 