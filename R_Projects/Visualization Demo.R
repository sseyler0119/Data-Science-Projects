# create a data frame
df <- data.frame(
  Name = as.factor(c("a", "b", "c")), # must include as.factor to avoid "need finite xlim values error
  Value = c(1, 2, 3))

# display the data frame
print(df)

# plot the data frame using default parameters
plot(df)


# plot using default parameter order
plot(df$Name,df$Value)

# plot using named parameters
plot(
  x = df$Name, 
  y = df$Value
)

# create using a bar chart
barplot(
  names = df$Name,
  height = df$Value,
  col = "skyblue",
  main = "Hello World",
  xlab = "Name",
  ylab = "Value")

# view the help files
?plot

?barplot

?par # parameters


# using lattice

# install and load lattice package
#install.packages("lattice")

library(lattice)

# plot with defaults
dotplot(
  x = Value ~ Name, # Value as a function of Name, Y as a function of X
  data = df)

# plot with parameters
dotplot(
  x = Value ~ Name,
  data = df,
  main = "Hello World",
  xlab = "Name",
  ylab = "Value")

# create a barchart
barchart(
  x = Value ~ Name,
  data = df,
  col = "skyblue",
  main = "Hello World",
  xlab = "Name",
  ylab = "Value")

# view the help files
?barchart

?formula

# using ggplot2

library(ggplot2)

# plot with defaults
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_point()

# plot with parameters
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_point() +
  ggtitle("Hello World") +
  xlab("Name") +
  ylab("Value")


# create a bar chart
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_bar(
    stat = "identity", # identity means to set the height of the bar to the value of the y column 
    fill = "skyblue") +
  ggtitle("Hello World") +
  xlab("Name") +
  ylab("Value")

# view help files
?ggplot # ggplot

?aes # aesthetic mappings