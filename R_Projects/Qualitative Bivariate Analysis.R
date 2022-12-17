# Bivariate visualizations for two qualitative variables

# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

# create a contingency table
awards <- table(
  movies$Awards,
  movies$Rating)

# display table
print(awards)

# Create a grouped frequency bar chart
barplot(
  height = awards,
  beside = TRUE, # group along side one another
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = "topleft",
    title = "Awards"))

# Create a stacked frequency bar chart
barplot( # either set beside to FALSE or exclude it
  height = awards,
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = "topleft",
    title = "Awards"))

# Create a proportional frequency table
# use apply command to apply a function to the columns of the awards table
# specify table: awards, 2 indicates that we want to apply the function to the columns (1 = rows)
proportions <- apply(awards, 2, function(x){ x / sum(x)})

head(awards) # original table

head(proportions) # proportional contingency table

# Create a 100% stacked frequency bar chart
barplot(
  height = proportions,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = "topleft",
    title = "Awards"))

# Create a contingency table, pivot the table
# Note: x and y are correct
awards <- table(
  movies$Rating, # rows
  movies$Awards) # columns

colnames(awards) <- c("No", "Yes")

print(awards)

# Create a spineplot
spineplot(
  x = awards,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies")

# Create a mosaic plot
mosaicplot(
  x = awards,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies")


# using Lattice

# create a grouped frequency bar chart
barchart(
 x = awards,
 stack = FALSE,
 horizontal = FALSE,
 main = "Count of Movies by Rating and Awards",
 xlab = "Rating",
 ylab = "Count of Movies",
 auto.key = list(
   x = 0.05,
   y = 0.95,
   title = "Awards",
   text = c("No", "Yes")))


# create a stacked frequency bar chart
barchart(
  x = awards,
  stack = TRUE,
  horizontal = FALSE,
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = "Awards",
    text = c("No", "Yes")))

# Create a proportional frequency table
matrix <- apply(awards, 1, function(x) {x / sum(x)}) # apply the function to the rows of the awards table

# transpose the matrix
proportions <- t(matrix)

head(awards)

head(proportions)

# create a 100% stacked frequency bar chart
barchart(
  x = proportions,
  stack = TRUE,
  horizontal = FALSE,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies",
  auto.key = list(
    x = 0.70,
    y = 1.05,
    title = "Awards",
    columns = 2,
    text = c("No", "Yes"),
    background = "white"))

# Note NO spine plot or mosaic plot in lattice


# using ggplot2

# create a grouped frequency bar chart
ggplot(
  data = movies,
  aes( x = Rating, fill = Awards)) +
  geom_bar(position = "dodge") + # dodge places bars side-by-side
  ggtitle("Count of Movies by Rating and Awards") +
  scale_fill_discrete(labels = c("No", "Yes"))




# create a stacked frequency bar chart
ggplot(
  data = movies,
  aes( x = Rating, fill = Awards)) +
  geom_bar() +
  ggtitle("Count of Movies by Rating and Awards") +
  scale_fill_discrete(labels = c("No", "Yes"))


# create a 100% stacked frequency bar chart
ggplot(
  data = movies,
  aes( x = Rating, fill = Awards)) +
  geom_bar(position = "fill") +
  ggtitle("Proportion of Movies by Rating and Awards") +
  ylab("Proportion of Movies") +
  scale_fill_discrete(labels = c("No", "Yes"))

# Note: No spine plot or mosaic plot



