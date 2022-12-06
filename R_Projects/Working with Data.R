# working with data
# set the working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") # use / instead of \ for directory

# read a tab-delimited data file
cars <- read.table(
  file = "Cars.txt",
  header = TRUE,
  sep = "\t",
  quote="\"")

# peek at the data
head(cars)

# install.packages("dplyr")

# load the dplyr library
library(dplyr)

# Select a subset of columns: Transmission, Cylinders, Fuel.Economy
temp <- select(
  .data = cars, 
  Transmission,
  Cylinders,
  Fuel.Economy)

# view the data
head(temp)

# Filter a subset of rows, just show Automatic transmission
temp <- filter(
        .data = temp,
        Transmission == "Automatic")

# inspect rows
head(temp)

# compute a new column called Consumption that converts U.S. mpg to European kpl
temp <- mutate(
  .data = temp,
  Consumption = Fuel.Economy * 0.425)

# insepct
head(temp) # shows new column Consumption

# Group rows of data by the number of cylinders in each engine using Cylinders column
temp <- group_by(
  .data = temp,
  Cylinders)

# inspect the resuls
head(temp) # shows grouped data frame, includes data type, size of df, and number of unique categories in Cylinders column

# aggregate based on groups, creates Avg.Consumption column with the mean consumption for each group of cars based on the number of cylinder
temp <- summarize(
  .data = temp,
  Avg.Consumption = mean(Consumption))

# inspect the results
head(temp)

# arrange the rows in descending order from most fuel efficient to least fuel efficient
temp <- arrange(
  .data = temp,
  desc(Avg.Consumption))

# inspect the results
head(temp)

# convert to data frame
efficiency <- as.data.frame(temp)

#inspect the results
head(efficiency)

# chain methods together, "method chanining" or "piping"
# The next several lines accomplish the same goal as the preceding code
efficiency <- cars %>%
  select(Fuel.Economy, Cylinders, Transmission) %>%
  filter(Transmission == "Automatic") %>%
  mutate(Consumption =  Fuel.Economy * 0.425) %>%
  group_by(Cylinders) %>%
  summarize(Avg.Consumption = mean(Consumption)) %>%
  arrange(des(Avg.Consumption)) %>%
  as.data.frame()

#inspect the results
print(efficiency)

# save the results to a CSV file
write.csv(
  x = efficiency,
  file = "Fuel Efficiency.csv",
  row.names = FALSE)