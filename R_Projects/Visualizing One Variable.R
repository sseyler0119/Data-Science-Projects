# Univariate Visualizations fo a Quantitative Variable
# Base

# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

# Create a dot plot of runtime
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)),
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n")

# Create a dot plot with alpha transparency
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)),
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n",
  pch = 16, # use solid dot shape
  col = rgb(0, 0, 0, 0.1)) # black with 0.1 transparency

# add jitter to dot plot
plot( 
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
main = "Distribution of Movie Runtimes",
xlab = "Runtime (minutes)",
ylab = "",
yaxt = "n") # this plot shows a concentration around 100 minutes

# create a boxplot of runtime
boxplot(
  x = movies$Runtime,
  horizontal = TRUE,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)") # this plot shows a concentration around 100 minutes, outliers, and data that is positively skewed

# create a histogram of runtime (uses default of 20 bins)
hist(
  x = movies$Runtime,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")


# create a more course-grain histogram of runtime (10 bins)
hist(
  x = movies$Runtime,
  breaks = 10,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")


# create a more fine-grain histogram of runtime (30 bins)
hist(
  x = movies$Runtime,
  breaks = 30,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

# create a density plot of runtime
plot(
  x = density(movies$Runtime),
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

# create small multiples of all four
par(mfrow = c(4, 1)) # plot each of the next four plots in 1 column and 4 rows 

plot( # dotplot, row 1
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  xlim = c(0, 250),
  main = "Distribution of Movie Runtimes",
  xlab = "",
  ylab = "",
  yaxt = "n",
  pch = 16,
  col = rgb(0, 0, 0, 0.1))


boxplot( # boxplot, row 2
  x = movies$Runtime,
  ylim = c(0, 250),
  horizontal = TRUE)


hist( # histogram, row 3
  x = movies$Runtime,
  xlim = c(0, 250),
  main = "",
  xlab = "",
  ylab = "",
  yaxt = "n")


plot( # density plot, row 4
  x = density(movies$Runtime),
  xlim = c(0, 250),
  main = "",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n")

# reset multi-row display
par(mfrow = c(1,1))


# Using Lattice

# create dot plot for runtime
stripplot(
  x = ~Runtime, # just show Runtime by itself
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")


# create dot plot with jitter
stripplot(
  x = ~Runtime, # just show Runtime by itself
  data = movies,
  jitter = TRUE,
  amount = 0.5,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

# create a box plot with lattice
bwplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

# create histogram with lattice
histogram(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

# Create density plot with lattics
densityplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)"
)

# Create small multples of all four plots
# note, not exactly lined up

dot <- dotplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

print( 
  x = dot, 
  position = c(0, 0.75, 1, 1),
  more = TRUE)


box <- bwplot(
  x = ~Runtime,
  data = movies,
  xlab = "")


print( 
  x = box, 
  position = c(0, 0.5, 1, 0.75),
  more = TRUE)


hist <- histogram(
  x = ~Runtime,
  data = movies,
  xlab = "",
  ylab = "",
  scales = list(y = list(draw = FALSE)))


print( 
  x = hist, 
  position = c(0, 0.25, 1, 0.5),
  more = TRUE)


density <- densityplot(
  x = ~Runtime,
  data = movies,
  ylab = "",
  scales = list(y = list(draw = FALSE)))

print( 
  x = density, 
  position = c(0, 0, 1, 0.25),
  more = TRUE)

# Now let's do this all over again using ggplot2

# create a violin-style dot plot
ggplot(
  data = movies,
  aes(x = Runtime, stat = "count")) +
  geom_dotplot(binwidth = 1) +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime (minutes)")


# create a box plot of runtime
ggplot(
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("") +
  ylab("Runtime (minutes)") +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

# create a histogram
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_histogram(binwidth = 10) +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime (minutes)")


# create a density plot
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime (minutes)")


# plot small multiples of all four plots
dev.off() # clear plot window

library(grid) # load grid library

viewport <- viewport(
  layout = grid.layout(4, 1)) # create viewport with layout of 4 rows, 1 col

pushViewport(viewport) # create the viewport

# create dotplot
dot <- ggplot(
  data = movies,
  aes(x = Runtime, after_stat(count))) + # ..count.. deprecated, use after_stat(count) instead
  geom_dotplot(
    binwidth = 0.25) +
  scale_x_continuous(
    limits = c(0, 250)) +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("")

print(
  x = dot,
  vp = viewport(
    layout.pos.row = 1,
    layout.pos.col = 1))


# create box plot
box <- ggplot( # ok to have "continuos x aestetic, did you forget 'aes(group = ...)' message
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  scale_y_continuous(
    limits = c(0,250)) +
  xlab("")

print(
  x = box,
  vp = viewport(
    layout.pos.row = 2,
    layout.pos.col = 1))


# create histogram
hist <- ggplot( 
  data = movies,
  aes(x = Runtime)) +
  geom_histogram() +
  scale_x_continuous(
    limits = c(0,250)) +
  xlab("")

print( # message about 2 rows missing values
  x = hist,
  vp = viewport(
    layout.pos.row = 3,
    layout.pos.col = 1))



# Create Density Plot
density <- ggplot( 
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  scale_x_continuous(
    limits = c(0,250)) +
  xlab("Runtime (minutes)")

print( # message about 2 rows missing values
  x = density,
  vp = viewport(
    layout.pos.row = 4,
    layout.pos.col = 1))

