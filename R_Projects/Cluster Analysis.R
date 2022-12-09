# load the iris data
data(iris)

# peek at the data
head(iris)

# look at the unique species
unique(iris$Species)

# create a scatterplot matrix colored by species
plot(
  x = iris[1:4],
  col = as.integer(iris$Species))

# view scatterplot of petal length vs width
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width
)

# color scatterplot by species
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  col = as.numeric(iris$Species))

# create k-means cluseters
clusters <- kmeans(
  x = iris[, 1:4],
  centers = 3, # set to 3 (because we have 3 species)
  nstart = 10) # number of algorithm re-starts with different random starting location

# plot each cluster as a shape
# we can see that all of the setosa were correctly identified (black triangles)
# most of the versicolor were predicted correctly (red circles), some are incorrectly identified (green circles)
# most of the virginica were predicted correctly (green crosses), some are incorrectly identified (red crosses)
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  col = as.numeric(iris$Species),
  pch = clusters$cluster) # plot character

# plot centroid of clusters
points(
  x = clusters$centers[, "Petal.Length"],
  y = clusters$centers[, "Petal.Width"],
  pch = 4, # plot char to 4 = x char
  lwd = 4,
  col = "blue")

# view a table of the clusters to show which were correctly identified
# all 50 setosa were correct
# 48 versicolor were correct, 2 incorrect
# 36 correct, 14 virginica were incorrect
table(
  x = clusters$cluster,
  y = iris$Species)
