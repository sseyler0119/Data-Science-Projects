# Predicting with Machine Learning

# load the data
data(iris)

# set a seed to make randomness reproducable
set.seed(42)

# split into training and test data set
# randomly sample 100 of 150 row indexes, training data
indexes <- sample(
  x = 1:150,
  size = 100)

# inspect the random indexes
print(indexes)

# create a training set from indexes 
train <- iris[indexes,]

# create a test set from remaining indexes
test <- iris[-indexes, ] # -indexes says to include all rows except those listed in the row indexes variable (the remaining data)

# load the decision tree package
library(tree)

# train a decision tree model
#model <- tree(
# formula = Species ~ ., # . says to include all other variables in the data frame as the explanatory variable
#data = train) # Species ~ . is equivalent to formula = Species ~ Petal.Length + Petal.Width + Sepal.Length + Sepal.Width

# use two predictors, using the above model to train the decision tree causes an error with
#     the partition.tree() command, "tree can only have one or two predictors", this is the workaround
model <- tree(
  formula = Species ~ Petal.Length + Petal.Width,
  data = train)

# inspect the model
summary(model)

# visualize the decision tree model
plot(model)
text(model)

# Load color brewer library
library(RColorBrewer)

# create color palette
palette <- brewer.pal(3, "Set2") # color blind friendly

# Create a scatterplot colored by species
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  pch = 19,
  col = palette[as.numeric(iris$Species)],
  main = "Iris Petal Length vs. Width",
  xlab = "Petal Length (cm)",
  ylab = "Petal Width (cm)")

# plot the decision tree boundaries
partition.tree(
  tree = model,
  label = "Species",
  add = TRUE)

# predict with the model
predictions <- predict(
  object = model,
  newdata = test,
  type = "class")

# create a confusion matrix
table(
  x = predictions,
  y = test$Species)

# load the caret package
library(caret)

# evaluate the prediction results
confusionMatrix(
  data = predictions,
  reference = test$Species)

# set wording directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") # use / instead of \ for directory

# save the tree model
save(model, file= "Tree.RData")
