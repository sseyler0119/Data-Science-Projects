# Creating Descriptive Statistics

# set the working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") # use / instead of \ for directory

# read in a CSV data file
cars <- read.csv("Cars.csv")

# peek at the data
head(cars)

# create a frequency table
table(cars$Transmission) # use categorical data in Transmission column to find # of cars of each type

# get the minimum value of Fuel Economy column
min(cars$Fuel.Economy)

# get the maxium value of Fuel Economy column
max(cars$Fuel.Economy)

# get the average value of Fuel Economy column
mean(cars$Fuel.Economy)

# get the median value of Fuel Economy column
median(cars$Fuel.Economy)

# get the Quartiles
quantile(cars$Fuel.Economy)

# get the standard deviation
sd(cars$Fuel.Economy)

# get the total value
sum(cars$Fuel.Economy)

# get the correlation coefficient between Cylinders and Fuel Economy
cor(
  x = cars$Cylinders,
  y = cars$Fuel.Economy) # negative correlation, higher the cylinders the lower the mpg

# summarize the entire table
summary(cars)


