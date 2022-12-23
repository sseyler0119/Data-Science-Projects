iris  %>%
  group_by(iris$Species)  %>%
  summarize( min = min(iris$Petal.Width),
             q1 = quantile(iris$Petal.Width),
             median = median(iris$Petal.Width),
             mean = mean(iris$Petal.Width),
             q3 = quantile(iris$Petal.Width),
             max = max(iris$Petal.Width))



data("iris") # import data

head(iris)
summary(iris) # summary data

dim(iris) # 150 rows, 5 columns, shape of the data

names(iris) # column names colnames(iris) does the same thing


View(iris) # displays data in spreadsheet view

class(iris) # data types, dataframe

str(iris) # structure of data

irisData <- iris

irisData

missing_data <- sum(is.na(irisData)) # number of missing values, 0 missing
print(missing_data)

duplicated(irisData) # find any duplicate data, none present


table(irisData$Species) # frequency count of species

PL <- iris$Petal.Length 
PW <- iris$Petal.Width

plot(PL, PW) # basic scatter plot

df <- iris[,1:4] # store columns 1-4 in dataframe
df

stars(df) # star diagram

stars(df, key.loc=c(17,0))

stars(df, key.loc = c(20,0.5), draw.segments = TRUE) # colored in segments

hist(iris$Sepal.Length, col='steelblue', main='histogram', xlab='length', ylab="frequency") # histogram for sepal length

boxplot(Sepal.Length ~ Species, data = irisData, main = "Sepal.Length", xlab="Species", ylab="Sepal Length", col="steelblue", border="black")

corr <- cor(df) # correlation, default is pearson method

cor(df, method = "kendall")
cor(df, method = "spearman")
cor.test(df$Sepal.Length, df$Sepal.Width)

install.packages("corrplot") # correlation plot
library(corrplot)
corrplot(corr) # default method is circle

corrplot(corr, method="pie")

corrplot(corr, method="color") # similar to heatmap


corrplot(corr, method="number") # includes correlation numbers

corrplot(corr, method="shade") # similar to color

corrplot(corr, method="ellipse")


corrplot(corr, type="upper") # upper part of chart

corrplot(corr, type="lower") # lower part of chart


print(irisData)

setosa <- irisData[irisData$Species == "setosa",]
versicolor <- irisData[irisData$Species == "versicolor",]
virginica <- irisData[ irisData$Species == "virginica",]

setosa
versicolor
virginica


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


newTable <- merge(x = setosa_sum, y =versicolor_sum, all=TRUE )

final <- merge(x = newTable, y = virginica_sum, all=TRUE)
final