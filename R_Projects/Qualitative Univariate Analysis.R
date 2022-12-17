# Visualizing One Categorical Variable

# Base

# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

# Univariate Visualizations for One Categorical Variables

# Create a frequency bar chart of ratings
plot(
  x = as.factor(movies$Rating), # as.factor() prevents "need finite 'ylim' values error
  main = "Count of Movies by Rating",
  xlab = "Rating", 
  ylab = "Count of Movies")

# Create a horizontal bar chart
plot(
  x = as.factor(movies$Rating),
  horiz = TRUE,
  main = "Count of Moives by Rating",
  xlab = "Count of Movies", # swap axis labels
  ylab = "Rating")

# Create a Cleveland dot plot
dotchart(
  x = table(movies$Rating),
  pch = 16, # 16 = solid black point
  main = "Count of Moives by Rating",
  xlab = "Count of Movies", # swap axis labels
  ylab = "Rating")

# Create a Pie Chart of ratings
pie( 
  x = table(movies$Rating),
  main = "Count of Movies by Rating")

# Create a Pie Chart of Awards
pie(
  x = table(movies$Awards),
  clockwise = TRUE,
  main = "Proportion of Movies that Won Awards")

library(lattice)

# create frequency table of ratings
table <- table(movies$Rating)

ratings <- as.data.frame(table)

names(ratings)[1] <- "Rating" # set column 1 name to Ratings
names(ratings)[2] <- "Count" # set column 2 name to Count

print(ratings)

# create a frequency bar chart
barchart(
  x = Count ~ Rating, 
  data = ratings,
  main = "Count of Movies by Rating",
  xlab = "Rating")

# create a horizontal bar chart
barchart(
  x = Rating ~ Count, 
  data = ratings,
  main = "Count of Movies by Rating",
  ylab = "Rating")

# Create a Cleveland dot plot
dotplot(
  x = Rating ~ Count,
  data = ratings,
  main = "Count of Movies by Rating",
  ylab = "Rating")

# Create a part-of-whole frequency bar chart
histogram(
  x = ~as.factor(Rating), # w/out as.factor, this throws an error
  data = movies,
  main = "Percent of Movies by Rating")

# Using ggplot2

library(ggplot2)

# create a frequency bar chart for rating
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() + # geom_bar means we want a bar chart
  ggtitle("Count of Movies by Rating") # + means we are adding a layer


# create a horizontal frequency bar chart for rating
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() + # geom_bar means we want a bar chart
  coord_flip() + # flip the x and y orientation
  ggtitle("Count of Movies by Rating") # + means we are adding a layer


# Create a Cleaveland dot plot
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_point(stat = "count") + # geom_point means we want a dot plot
  coord_flip() +
  ggtitle("Count of Movies by Rating") # + means we are adding a layer

# Create a pie chart
ggplot(
  data = movies,
  aes(x = "", fill = Rating)) +
  geom_bar() +
  coord_polar(theta = "y") +
  ggtitle("Count of Movies by Rating") +
  ylab("")

# Create a pie chart of awards
ggplot(
  data = movies,
  aes(x = "", fill = Awards)) +
  geom_bar() +
  coord_polar(theta = "y") +
  ggtitle("Proportion of Movies that Won Awards") +
  ylab("")
