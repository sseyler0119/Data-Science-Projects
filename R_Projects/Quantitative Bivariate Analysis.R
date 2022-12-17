#Quantitative Bivariate Visualizations

# Base

# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

# Create a scatterplot
plot(
  x = movies$Runtime,
  y = movies$Box.Office,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")


# Create a linear regression model
model <- lm(movies$Box.Office ~ movies$Runtime) # Box Office as a linear function of Runtime

# Draw the Linear Regression Line on the Plot, We see a positive correlation between revenue and runtime
lines(
  x = movies$Runtime,
  y = model$fitted, # line of best fit using linear regression model
  col = "red",
  lwd = 3) # width of the line

# Let's examine this relationship further

# install hexbin
#install.packages("hexbin")
library(hexbin)

# Create a hexagonal binned frequency heatmap
hexbin <- hexbin(
  x = movies$Runtime,
  y = movies$Box.Office,
  xbins = 30,
  xlab = "Runtime (minutes)", 
  ylab = "Box Office ($M)")

# plot the hexbin
plot(
  x = hexbin,
  main = "Runtime vs. Box Office Revenue")


# Create a 2D kernal density estimate using MASS
install.packages("MASS")

library(MASS)

# Create a 2d kernal density estimation
density2d <- kde2d(
  x = movies$Runtime,
  y = movies$Box.Office,
  n = 50)

# create a contour plot of density, this is not a good visualization for this data set
contour(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)", 
  ylab = "Box Office ($M)")

# Create a level plot of density (density heat map)
image(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = topo.colors(100),
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)", 
  ylab = "Box Office ($M)")

# Create mesh plot of density
persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)", 
  ylab = "Box Office ($M)",
  zlab = "Density")

# Create a surface plot of density
palette(topo.colors(100))

persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = cut(density2d$z, 100),
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)", 
  ylab = "Box Office ($M)",
  zlab = "Density")

# reset palette 
palette("default")

# Load time series data
timeSeries <- read.csv("Timeseries.csv")

# Display the time series data
head(timeSeries)

# Create a step chart
plot(
  x = timeSeries,
  type = "s",
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)") # spike in 2015 is due to incomplete data

# Create a line chart
plot(
  x = timeSeries,
  type = "l", # line chart
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

# Using Lattice

# Create a scatterplot
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")

# add a linear regression line
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  type = c("p", "r"), # p = points as plot char (default char), r = regression
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")

# using hexbin library

# create hexagonal binned frequency heatmap
hexbinplot(
  x = Box.Office ~ Runtime,
  data = movies,
  xbins = 30,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")

# Create a grid from our 2d kernel density estimate
grid <- expand.grid(
  x = density2d$x,
  y = density2d$y)

grid$z = as.vector(density2d$z) # density for each x and y

# display the data frame
head(grid)

# create a contour plot of density
contourplot(
  x = z ~ x * y, # z as a function of every combination of x and y
  data = grid,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")


# create a level plot of density
levelplot(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)")

# Create a mesh plot of density
wireframe(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)",
  zlab = "Density")

# Create surface plot of density
wireframe(
  x = z ~ x * y,
  data = grid,
  drape = TRUE,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Box Office ($M)",
  zlab = "Density")

# Create a step chart
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  type = "s", # step chart
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

# create a line chart
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  type = "l", # line chart
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

# install and load lattice extra package
install.packages("latticeExtra")

library(latticeExtra)

# create an area chart
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  panel = panel.xyarea,
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

# using ggplot 2

# create scatterplot
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() + 
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# Add a linear regression line
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() + 
  geom_smooth(method = "lm") +
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# Add a frequency heatmap
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_bin2d() + 
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# create a hexagonal binned frequency heatmap
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_bin_hex() + 
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# create a contour plot of density
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_density_2d() + 
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# create a level plot of density
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_density2d(aes(fill = ..level..), geom = "polygon") + # .. .. means the variable is not present in the original data set, but has been computed by stat_density2d
  ggtitle("Runtime vs. Box Office Revenue") +
  xlab("Runtime (minutes)") +
  ylab("Box Office ($M)")

# Note 3D visualizations do not exist in ggplot2

# Create a step chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_step() + 
  expand_limits(y = 0) +
  ggtitle("Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Box Office ($M)")


# Create a line chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_line() + 
  expand_limits(y = 0) +
  ggtitle("Average Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Box Office ($M)")


# Create a area chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_area() + 
  ggtitle("Average Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Box Office ($M)")

