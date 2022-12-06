# Creating Data Visualizations

# set the working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") # use / instead of \ for directory

# read in a CSV data file
cars <- read.csv("Cars.csv")

# load library
library(ggplot2)

# create a frequency bar chart
ggplot(
  data = cars,
  aes(x = Transmission)) +
  geom_bar() +
  ggtitle("Count of Cars by Transmission Type") +
  xlab("Transmission Type") +
  ylab("Count of Cars")

# create a histogram
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_histogram(bins = 10) +
  ggtitle("Distribution of Fuel Economy") +
  xlab("Fuel Econonomy (mpg)") +
  ylab("Count of Cars")


# create a density plot
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_density() +
  ggtitle("Distribution of Fuel Economy") +
  xlab("Fuel Economy (mpg)") +
  ylab("Density")

# create a scatter plot
ggplot(
  data = cars,
  aes(
   x = Cylinders,
   y = Fuel.Economy)) +
  geom_point() +
  ggtitle("Fuel Economy by Cylinders") +
  xlab("Number of Cylinders") +
  ylab("Fuel Economy (mpg")

