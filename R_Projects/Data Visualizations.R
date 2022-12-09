# set wording directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects") 

# load CSV Files
movies <- read.csv("Movies.csv", quote="\"")

genres <- read.csv("Genres.csv", quote="\"")

# peek at the data

head(movies)
head(genres)

# Univariate Visualizations for a qualitative variable

# create a bar chart of rating observations
movies$Rating <- as.factor(movies$Rating) # convert rating to a factor, this line is required in newer versions of R, because of how the data is imported from the CSV
plot(movies$Rating)

# create a pie chart of rating observations
pie(table(movies$Rating))

# univariate visualizations of a quantitative variable

# create a dot plot of runtime
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)), # set y-coord to 0 for all values so that they are on a straight line using rep, repeats 0 once for each row in movies df
  ylab="", # set to empty string since there is no dimension set for the y-axis
  yaxt = "n") # set the y-axis type to n for none to suppress the plotting of the y-axis labels and tick marks

# create a boxplot of runtime
# We see that the movie runtime centers around 100 minutes with a longer tail on the right side of the distribution
boxplot(
  x = movies$Runtime, # no dimension on y-axis
  xlab = "Runtime(minutes)",
  horizontal = TRUE) # match the orientation fo the dot plot

# create a histogram of runtime
hist(movies$Runtime)

# create a more course-grain histogram
hist(
  x = movies$Runtime,
  breaks = 10)

# create a more fine-grain histogram
hist(
  x = movies$Runtime,
  breaks = 30) # the more bins, the smoother the histogram and the closer it matches the distribution

# create a density plot of runtime (matches the distribution to a curve)
# x-axis: runtime
# y-axis probability density: relative liklihood from 0-1 that an observation will be found at the corresponding location on the x-axis for this variable
plot(density(movies$Runtime)) # area under the curve integrates to 1

# add dot plot to base of density plot
points(
  x = movies$Runtime,
  y = rep(-0.0005, nrow(movies))) # set each point to -0.0005 for each row so that it displays just below the y-axis origin

# Bivariate Visualizations for Two Qualitative Variables

# create a spine plot
genres$Rating <- as.factor(genres$Rating) # w/out converting to a factor, we get an error "dependent variable should be a factor"
genres$Genre <- as.factor(genres$Genre)

spineplot(
  x = genres$Genre,
  y = genres$Rating)

# create a mosaic plot of genre and rating
# Mosaic plot places x-axis at the TOP of the chart
mosaicplot( # set x to a contigency table that contains both Genre and Rating
  x = table( # no y-argument for a mosaic plot
    genres$Genre,
    genres$Rating),
  las = 3) # label access style, rotate the labels, 0=default, 1=horizontal to axis, 2=perpendicular to axis, 3=vertical to axis


# Bivariate visualizations for two quantitative variables

# create a scatterplot of runtime and box office revenue
plot( # there is a positive correlation between runtime and box office revenue, but it is relatively weak
  x = movies$Runtime,
  y = movies$Box.Office)

# Create a scatterplot of critic score and box office revenue
plot( # relatively weak correlation between critic score and box office revenue
  x = movies$Critic.Score,
  y = movies$Box.Office)

# Plot a line of graph of count of movies by year
plot(
  x = table(movies$Year),
  type = "l") # the sharp drop off in revenue around 2013 is because many of the newer movies are not in the dataset

# Bivariate visualizations for both a qualitative and quantitative variable

# create a bar graph of average box office by rating
barplot(tapply(movies$Box.Office, movies$Rating, mean))

# create a bar graph of average box office by genre
barplot(
  height = tapply(genres$Box.Office, genres$Genre, mean),
  las=3)

# plot bivariate box plots of box office by rating
plot(
  x = movies$Rating,
  y = movies$Box.Office)

# summarize an entire table

# create a scatterplot matrix
plot(movies) # variable names on diagonal axis, each variable plotted on x and y axis

# cleaning up data visualizations
plot(movies$Rating)

# cleaning up the bar chart
plot(
  x = movies$Rating,
  main = "Count of Movies by Rating",
  xlab = "Rating Category",
  ylab =  "Count of Movies",
  col = "#b3cde3")

# view help for plots and parameters
?plot
?par

