# Bivariate visualizations for both a qualitative and a quantitative variable


# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

# Using Base

# create a bivariate bar graph
average <- tapply( # apply mean function to Box Office Revenue, grouped by Rating
  movies$Box.Office,
  movies$Rating,
  mean
)

print(average)

barplot(
  height = average,
  main = "Average Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# create a bivariate box plot
plot(
  x = as.factor(movies$Rating), # as.factor prevents need finite xlim values error
  y = movies$Box.Office,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# Create a notched box plot
plot(
  x = as.factor(movies$Rating), # as.factor prevents need finite xlim values error
  y = movies$Box.Office, # notches in first three categories, overlap and is probably due to chance
  notch = TRUE, # notch in R category does not overlap, likely due to some other factor, but what?
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# Using Lattice

# load dplyr
library(dplyr)

# create table of average box office by rating
average <- movies %>%
  select(Rating, Box.Office) %>%
  group_by(Rating) %>%
  summarize(Box.Office = mean(Box.Office)) %>%
  as.data.frame()

print(average)

# Create a bivariate bar chart
barchart(
  x = Box.Office ~ Rating,
  data = average,
  main = "Average Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# Create a bivariate box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")


# Create a notched box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  notch = TRUE,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# Create a violin plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  panel = panel.violin,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab= "Box Office ($M)")

# ggplot2

# create bivariate bar chart
ggplot(
  data = average,
  aes(x = Rating, y = Box.Office)) +
  geom_bar(sta = "identity") + 
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Box Office ($M)")

# create bivariate box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot() + 
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Box Office ($M)")

# create notched box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot(notch = TRUE) + 
  ggtitle("Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Box Office ($M)")


# create violin plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_violin() + 
  ggtitle("Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Box Office ($M)")


# create violin plot, # y-axis stops at 0 vs lattice which includes values < 0
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_violin() + 
  ggtitle("Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Box Office ($M)")




