
# set wording directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") 

# load CSV data
movies <- read.csv(
  file = "Movies.csv",
  quote="\""
)

genres <- read.csv(
  file = "Genres.csv",
  quote="\""
  
)

# peek at the data
head(movies)
head(genres)

# Univariate statistics for qualitative variables
table(movies$Rating) # returns frequency of each rating

table(genres$Genre) # returns frequency of each genre

# Univariate statistics for quantitative variables

# analyze the location of a quantitative variable
mean(movies$Runtime)

median(movies$Runtime) # slighly less than mean, data will likely be positively skewed (right)

which.max(table(movies$Runtime)) # view the mode, number of runtimes most frequently occurring in the data set

# analyze the spread of a quantitative variable
min(movies$Runtime) # shortest movie run time is 38 minutes

max(movies$Runtime) # longest movie run time is 219 minutes

range(movies$Runtime) 
diff(range(movies$Runtime)) # 181 minute difference between min and max
quantile(movies$Runtime) # returns table of quantile movie run times

quantile(movies$Runtime, 0.25) # returns value at 25%
quantile(movies$Runtime, 0.90) # returns value at 90%


IQR(movies$Runtime) # interquartile range 

var(movies$Runtime) # variance of the data

sd(movies$Runtime) # standard deviation of runtime

# analyze the shape of a quantitative variable
install.packages("moments")
library(moments)

skewness(movies$Runtime) # distribution is positively skewed

kurtosis(movies$Runtime) # how sharp/flat is the peak of the data, result > 3, peak is steeper than the normal distribution

plot(density(movies$Runtime)) # peak appears stepper and tale is positively skewed to the right

# summarize a quantitative variable
summary(movies$Runtime)

# Bivariate Statistics for two qualitative variables
table(genres$Genre, genres$Rating)

# bivariate statistics for two quantitative variables
# covariance
cov(movies$Runtime, movies$Box.Office)

cov(movies$Critic.Score, movies$Box.Office)

# correlation coefficients
cor(movies$Runtime, movies$Box.Office) # 0.347748 movie run time more strongly correlates to revenue than critic score
cor(movies$Critic.Score, movies$Box.Office) # 0.1608324 # both of these values are relatively small though, so aren't good indicators of revenue

# Bivariate analysis for both a qualitative and quantitative variable
# average box office revenue across each rating category
tapply(movies$Box.Office, movies$Rating, mean) # apply mean function to the B.O. Revenue, grouped by rating, pg made the most followed by g, pg-13

tapply(genres$Box.Office, genres$Genre, mean) # adventure made the most, followed by 




