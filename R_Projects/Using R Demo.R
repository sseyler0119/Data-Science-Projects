# Assignment Operators 
x <- "Hello World!" # preferred assignment operator
y = "Hello World!"
"Hello World" -> z # rarely ever used, best to avoid

#implicit printing
print(x)
x

# Creating variables
l <- TRUE # logical var
i <- 123L # integer value L stands for Long integer 32 bit
n <- 1.23 # numeric variable
c <- "ABC 123" # character string
d <- as.Date("2001-02-03") # date variable

# Displaying Variables
l
i
n
c
d

# Creating a function
f <- function(x) { x + 1}

# invoking a function
f(2)

# creating a vector
v <- c(1,2,3);
v

# Creating a sequence
s <- 1:5 # sequence operator is : 
s

# Creating a Matrix
m <- matrix(
  data = 1:6,
  nrow = 2,
  ncol = 3)
m

# Creating an array
a <- array(
  data = 1:8,
  dim = c(2,2,2))
a

# Creatign a list
l <- list(True, 123L, 2.34, "abc") # a list can hold different data types 
l

# Creating a Factor, factors are similar to enums in C
categories <- c("Male", "Female", "Male", "Male", "Female") # vector of char strings
factor <- factor(categories)
factor
levels(factor) # the unique values in alphabetical order
unclass(factor) # this shows the underlying integer array that maps to these values


# creating a dataframe
df <- data.frame(
  Name = c("Cat", "Dog", "Cow", "Pig"),
  HowMany = c(5, 10, 15, 20),
  IsPet = c(TRUE, TRUE, FALSE, FALSE))

df

# indexing data frames by row and column
df[1,2]

# indexing data frames by row
df[1, ]

# indexing data frames by column
df[, 2]
df[["HowMany"]]
df$HowMany

# subsetting data frames
df[c(2, 4), ] # pass in vector of integers to get rows 2 and 4
df[2:4, ] # pass in a sequence of integers to get rows 2-4
df[c(TRUE, FALSE, TRUE, FALSE), ] # pass in vector of logical arguments to determine which rows to return, 1 and 3 not 2 and 4
df[df$IsPet == TRUE, ] # use equality operator to find rows with matching criteria
df[df$HowMany > 10,  ] # use > operator to find rows where the values is > 10
df[df$Name %in% c("Cat", "Cow"),] # find all rows with matching values Cat and Cow

# R is a vectorized language
 1 + 2 # returns a vector containing 3
 c(1,2,3) + c(2,4,6) # returns a vector with the values 3,6,9
 
 # named vs ordered arguments
m <- matrix(data = 1:6, nrow = 2, ncol = 3)
n <- matrix(1:6, 2, 3)
m == n
identical(m, n)

# installing packages
install.packages("dplyr")

# loading libraries
library("dplyr")

# viewing help
?data.frame