vars <- setdiff(names(iris), "Species") # store all column names for numerical data

# split data by species
setosa <- iris[iris$Species == "setosa",] 
versicolor <- iris[iris$Species == "versicolor",]
virginica <- iris[ iris$Species == "virginica",]


# Get summary data by species
setosa_sum <- setosa %>%
  group_by(Species) %>%
  summarize("Avg Sepal Width" = mean(setosa$Sepal.Width),
            "Avg Sepal Length" = mean(setosa$Sepal.Length),
            "Avg Petal Width" = mean(setosa$Petal.Width),
            "Avg Petal Length" = mean(setosa$Petal.Length))


versicolor_sum <- versicolor %>%
  group_by(Species) %>%
  summarize("Avg Sepal Width" = mean(versicolor$Sepal.Width),
            "Avg Sepal Length" = mean(versicolor$Sepal.Length),
            "Avg Petal Width" = mean(versicolor$Petal.Width),
            "Avg Petal Length" = mean(versicolor$Petal.Length))


virginica_sum <- virginica %>%
  group_by(Species) %>%
  summarize("Avg Sepal Width" = mean(virginica$Sepal.Width),
            "Avg Sepal Length" = mean(virginica$Sepal.Length),
            "Avg Petal Width" = mean(virginica$Petal.Width),
            "Avg Petal Length" = mean(virginica$Petal.Length))


# Merge the data for our summary table
newTable <- merge(x = setosa_sum, y =versicolor_sum, all=TRUE) # merge setosa and versicolor data
iris_sum <- merge(x = newTable, y = virginica_sum, all=TRUE) # final merge with virginica


corr <- cor(iris[,1:4]) # correlation of iris dataset

