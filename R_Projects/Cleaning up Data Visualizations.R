# set working directory
setwd("C:/Users/sseyl/OneDrive/Documents/GitHub/Data-Science-Projects/R_Projects")

# load movie data from CSV file
movies <- read.csv("Movies2.csv")

# peek at the data
head(movies)

movies$Rating <- as.factor(movies$Rating) # "ylim values" error w/out converting Rating to factor, as.factor

# Create a frequency bar chart with defaults
plot(movies$Rating) 

# add context to our bar chart
plot(
  x = movies$Rating,
  main = "Count of Movies by MPAA Rating Category",
  xlab = "MPAA Rating Category",
  ylab = "Count of Movies")

# Create a color palette
install.packages("RColorBrewer")

library(RColorBrewer)

palette <- brewer.pal(9, "Pastel1") 

# clean up our bar chart
plot(
  x = movies$Rating,
  col = palette[2], # add color 2 from Pastel1 palette
  border = NA, # remove the borders
  main = "Count of Movies by MPAA Rating Category",
  xlab = "MPAA Rating Category",
  ylab = "Count of Movies")

# save as png image
png(
  filename = "Count of Movies by Rating.png",
  width = 640,
  height = 480)

plot( # render the plot into the png
   x = movies$Rating,
   col = palette[2], # add color 2 from Pastel1 palette
   border = NA, # remove the borders
   main = "Count of Movies by MPAA Rating Category",
   xlab = "MPAA Rating Category",
   ylab = "Count of Movies"
)

dev.off()

# save ggplot2 data visualization
?ggsave # ggsave file formats

?barplot # parplot

?par # parameters