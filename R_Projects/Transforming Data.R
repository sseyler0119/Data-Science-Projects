# Transforming Data


# What do we need to fix?

# column with wrong name, Tomato.Meter should be Critic.Score
# rows with missing values
# runtime column has units
# revenue is in multiple scales (millions, thousands, etc)
# file uses tabs instead of commas to separate values

# set the working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load data from tab-delimited file
movies <- read.table(
  file = "Movies.txt",
  sep = "\t",
  header = TRUE,
  quote = "\"")

# peek at the data
head(movies)

# look at the column names
names(movies)

# Problem #1: Column Name is incorrect
names(movies)[5] 

# Rename the column
names(movies)[5] <- "Critic.Score" # careful of arrow direction

# Problem 1 is solved
names(movies) 

# Problem 2: Missing values
# count missing values
sum(is.na(movies)) # 4 missing values

# inspect rows with missing values (intentionally placed at the end of the file)
tail(movies)

# Exclude observations with missing values
movies <- na.omit(movies)

# Problem # 2 is solved
sum(is.na(movies)) # 0 missing values

# Problem 3: Units in Runtime column
# Peek at the raw interest rate data
head(movies$Runtime)

# this line will throw an error because there are non-numerical values in the column
mean(movies$Runtime)

# Determine data type
class(movies$Runtime) # returns character

# cast to character strings
runtimes <- as.character(movies$Runtime)
head(runtimes)
class(runtimes)

# eliminate the unit of measure
runtimes <- sub(" min", "", runtimes)
head(runtimes)

# cast the character string to integer
movies$Runtime <-as.integer(runtimes)
head(movies$Runtime)
class(movies$Runtime)

# now we can perform mathematical functions on Runtime
mean(movies$Runtime)

# Problem 4: Box Office uses three units of measure
head(movies$Box.Office)

# create a function to convert box office revenue to millions
convertBoxOffice <- function(boxOffice)
{
  stringBoxOffice <- as.character(boxOffice) # convert Box Office factor to character string
  
  replacedBoxOffice <- gsub("[$|k|M]", "", stringBoxOffice) # replace any $, k, M with empty string
  
  numericBoxOffice <- as.numeric(replacedBoxOffice) # convert Box Office to numerical value
  
  if (grepl("M", boxOffice)) 
  {
    numericBoxOffice # value is already in millions
  } 
  else if(grepl("k", boxOffice))
  {
    numericBoxOffice * 0.001 # scale thousands to millions
  }
  else
  {
    numericBoxOffice * 0.000001 # scale $ to millions
  }
}

# convert box office to single unit of measure (millions)
movies$Box.Office <- sapply(movies$Box.Office, convertBoxOffice) # sapply function allows us to apply a function to each element in a collection of values

# Problem # 4 is solved
head(movies$Box.Office)
class(movies$Box.Office)
mean(movies$Box.Office)

# save data to a CSV file
write.csv(movies, "Movies.csv")