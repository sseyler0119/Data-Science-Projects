# from: https://www.kaggle.com/code/camnugent/introduction-to-machine-learning-in-r-tutorial/notebook


#install.packages("tidyverse")
library(tidyverse)
library(reshape2)

# Step 1: load housing dataset
housing = read.csv('https://raw.githubusercontent.com/ageron/handson-ml/master/datasets/housing/housing.csv')

head(housing) # view first fiew rows

# view data summary
# This shows a 207 NA values in total_bedrooms category
summary(housing) 

par(mfrow=c(2,5))

colnames(housing) # show column names

# Thins to consider from the following plots:
# 1) There are some housing blocks with old age homes
# 2) There is a median house value cap of 500k, this seems unreasonable for the Bay Area
# 3) All non-tree based methods should have a standardized scale, some go from 0-10, others go to 500k
# 4)Consider the affect that the housing cap can have on predictions, may want to remove the capped values
ggplot(data = melt(housing), mapping = aes(x = value)) +
  geom_histogram(bins = 30) + facet_wrap(~variable, scales = 'free_x')

# Step 2: Clean the Data

# impute missing values in total bedrooms column with median value for column
housing$total_bedrooms[is.na(housing$total_bedrooms)] = median(housing$total_bedrooms, na.rm = TRUE)

# Fix the total_rooms and total_bedrooms columns to mean_rooms, mean_bedrooms
housing$mean_bedrooms = housing$total_bedrooms/housing$households
housing$mean_rooms = housing$total_rooms/housing$households

drops = c('total_bedrooms', 'total_rooms') # drop these columns

housing = housing[, !(names(housing) %in% drops)] # add columns not in drops

head(housing) # we can see the two columns that were removed and the two new columns

# Turn categorical columns into boolean values

# get a list of all categories in the ocean_proximity column
categories = unique(housing$ocean_proximity)

# make a new empty dataframe of all 0s where each category becomes a unique column
cat_housing = data.frame(ocean_proximity = housing$ocean_proximity)

# use a for-loop to populate the appropriate columns of the df, split the data into two groups
for(cat in categories) {
  cat_housing[, cat] = rep(0, times = nrow(cat_housing))
}
head(cat_housing) # see the new columns: Near Bay <1H Ocean, Inland, Near Ocean, Island

for(i in 1:length(cat_housing$ocean_proximity)) {
  cat = as.character(cat_housing$ocean_proximity[i])
  cat_housing[, cat][i] = 1
}
head(cat_housing)

# drop the original column from the df
cat_columns = names(cat_housing)
keep_columns = cat_columns[cat_columns != 'ocean_proximity']
cat_housing = select(cat_housing, one_of(keep_columns))

tail(cat_housing)

# scale the numerical variables

colnames(housing) # view column names

drops = c('ocean_proximity', 'median_house_value')
housing_num = housing[, !(names(housing) %in% drops)]

head(housing_num)

scaled_housing_num = scale(housing_num)

head(scaled_housing_num)

# merge the altered numerical and categorical dataframes

cleaned_housing = cbind(cat_housing, scaled_housing_num, median_house_value=housing$median_house_value)

head(cleaned_housing)

# Step 3: Create a test set of data
set.seed(1738) # set a random seed so that the same sample can be reproduced in future runs

sample = sample.int(n = nrow(cleaned_housing), size = floor(.8*nrow(cleaned_housing)), replace=F)
train = cleaned_housing[sample, ] # just the sample data
test = cleaned_housing[-sample, ] # everything else 

head(train) # peek at the training data: contains the correct columns and randomized indices

nrow(train) + nrow(test) == nrow(cleaned_housing) # returns TRUE, all data has been included

# Step 4: Test some predictive models
# start with 3 predictors: median income, total rooms, and population

library('boot') # load library

?cv.glm # pull up info on cross-validation for generalized linear models, note the K option for K fold cross validation

glm_house = glm(median_house_value ~ median_income + mean_rooms + population, data = cleaned_housing) # fit the data

# cleaned_housing data, fitted data, K = 5: training data split into 5 equal portions
# one of the five folds is put off to the side as a mini test set, model is trained on the remaining 4 folds
# The process is repeated on each of the 5 folds and the average predictions produced from the iterations fo the model is taken
k_fold_cv_error = cv.glm(cleaned_housing, glm_house, K=5)

# first component is raw cross-validation estimate of prediction error: 6993810248
# second component is the adjusted cross-validation estimate: 6983982760
k_fold_cv_error$delta

glm_cv_rmse = sqrt(k_fold_cv_error$delta)[1]
glm_cv_rmse # off by about $83,629

names(glm_house) # these are the methods we can use on the model

# call coefficients
glm_house$coefficients # Intercept 206855.814, median income: $82608.959, mean rooms: -9755.442, population: -3948.293

# Random Forest model
#install.packages("randomForest")
library('randomForest') # load library

names(train) # view column names in training data

set.seed(1738)

train_y = train[, 'median_house_value']
train_x = train[, names(train) != 'median_house_value']

head(train_y)
head(train_x)

rf_model = randomForest(train_x, y = train_y, ntree = 500, importance = TRUE)

names(rf_model) # examine all of the methods we can call on the model

rf_model$importance

# out-of-bag error estimate

oob_prediction = predict(rf_model)

train_mse = mean(as.numeric((oob_prediction - train_y)^2))

oob_rmse = sqrt(train_mse)
oob_rmse # using a random forest of 1000 decision trees, we are able to predict the mdian price of a house in a given district to w/in $49k of actual median price

# test data
test_y = test[,'median_house_value']
test_x = test[, names(test) != 'median_house_value']

y_pred = predict(rf_model, test_x)
test_mse = mean(((y_pred - test_y)^2))
test_rmse = sqrt(test_mse)
test_rmse # $47625.57, pretty close to training data





# ************* change predictors to see if we can get a better outcome ****************


glm_houseMod = glm(median_house_value ~ median_income + longitude + latitude, data = cleaned_housing) # fit the data

# cleaned_housing data, fitted data, K = 5: training data split into 5 equal portions
# one of the five folds is put off to the side as a mini test set, model is trained on the remaining 4 folds
# The process is repeated on each of the 5 folds and the average predictions produced from the iterations fo the model is taken
k_fold_cv_error = cv.glm(cleaned_housing, glm_houseMod, K=5)

# first component is raw cross-validation estimate of prediction error: 5539004010
# second component is the adjusted cross-validation estimate: 5538647949
k_fold_cv_error$delta

glm_cv_rmse = sqrt(k_fold_cv_error$delta)[1]
glm_cv_rmse # off by about $74k

names(glm_houseMod) # these are the methods we can use on the model

# call coefficients
glm_houseMod$coefficients # Intercept 206855.814, median income: $69624.10, longitude: -99947.36, latitude: -103496.59

# Random Forest model
#install.packages("randomForest")
library('randomForest') # load library

?randomForest # read about classification and regression with random Forest

names(train) # view column names in training data

set.seed(1738)

train_y = train[, 'median_house_value']
train_x = train[, names(train) != 'median_house_value']

head(train_y)
head(train_x)

rf_model = randomForest(train_x, y = train_y, ntree = 500, importance = TRUE)

names(rf_model) # examine all of the methods we can call on the model

rf_model$importance

# out-of-bag error estimate

oob_prediction = predict(rf_model)

train_mse = mean(as.numeric((oob_prediction - train_y)^2))

oob_rmse = sqrt(train_mse)
oob_rmse # using a random forest of 1000 decision trees, we are able to predict the mdian price of a house in a given district to w/in $49k of actual median price

# test data
test_y = test[,'median_house_value']
test_x = test[, names(test) != 'median_house_value']

y_pred = predict(rf_model, test_x)
test_mse = mean(((y_pred - test_y)^2))
test_rmse = sqrt(test_mse)
test_rmse # $47625.57, pretty close to training data

# Overall, using longitude/latitude seemed to get a closer prediction than using rooms and population





