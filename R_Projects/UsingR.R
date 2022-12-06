# arithmetic operators
print(class(4))
print(class(4L))
print(class(T))
print(class(1 +4i))
print(class("sample"))
print(class(charToRaw("sample")))

is.integer("sample")

sprintf("4 + 5 = %d", 4 + 5)
sprintf("4 - 5 = %d", 4 - 5)
sprintf("4 * 5 = %d", 4 * 5)
sprintf("4 / 5 = %1.3f", 4 / 5)
sprintf("5 %% 4 = %d", 5 %% 4)
sprintf("4^2 = %d", 4^2)

# vectors, vectors in R have a 1-based index not 0-based index
numbers = c(3,2,0,1,8)
numbers # prints vector contents to console
numbers[1] # prints contents of 1st vector position
length(numbers) # prints length of vector
numbers[length(numbers)] # returns contents of last vector 
numbers[-1] # returns every value except the 1st value
numbers[c(1,2)] # only return the first two values in the vector
numbers[2:3] # returns only 2nd and 3rd values
numbers[5] = 1 # replace 5th index with value of 1
numbers[c(4,5)] = 2 # replace indices 4 and 5 with value of 2
numbers

sort(numbers, decreasing=T) # sort values in descending order
sort(numbers) # sort in ascending order

oneToTen = 1:10 # create sequence from 1 to 10

add3 = seq(from=3, to=27, by=3) # create sequence from 3 to 27 and add 3 at a time
add3

evens = seq(from=2, by=2, length.out = 10) # create sequence of 10 starting from 2 counting by 2's
evens

sprintf("4 in evens %s", 4 %in% evens) # is 4 in the sequence evens

# repeat value or values
rep(x=2, times=5, each=2) # repeat 2 5 times in a row, do this twice
rep(x=c(1,2,3), times=2, each=2) # repeat each value 2 times, do this twice: 1 1 2 2 3 3 1 1 2 2 3 3

# relational operators
sprintf("4 == 5 : %s", 4 == 5)
sprintf("4 != 5 : %s", 4 != 5)
sprintf("4 > 5 : %s", 4 > 5)
sprintf("4 < 5 : %s", 4 < 5)
sprintf("4 >= 5 : %s", 4 >= 5)
sprintf("4 <= 5 : %s", 4 <= 5)

# check to see if any of the following nubmers in the sequence are even
oneTo20 = c(1:20)
isEven = oneTo20 %% 2 == 0 # create 
isEven

justEvens = oneTo20[oneTo20 %% 2 == 0] # create array of just even values
justEvens

# Logical Operators
cat("TRUE && FALSE = ", T && F, "\n")
cat("TRUE || FALSE = ", T || F, "\n")
cat("!TRUE = ",  !T , "\n")

# if statements
age = 18
if(age >= 18)
{
  print("Drive and Vote")
}else if(age >= 16)
{
  print("Drive")
}else {
  print("Wait")
}

# switch statements
grade = "C"
switch(grade,
       "A" = print("Great"),
       "B" = print("Good)"),
       "C" = print("Ok"),
       "D" = print("Bad"),
       "F" = print("Terrible"),
       print("No Such Grade"))


# strings
str1 = "This is a string"
nchar(str1) # number of chars in string
sprintf("Dog > Egg: %s", "Dog" > "Egg")
sprintf("Dog == Egg: %s", "Dog" == "Egg")

str2 = paste("Owl", "Bear", sep="") # concatenates Owl and Bear as OwlBear
str2

substr(x=str2, start=4, stop=7) # returns Bear
sub(pattern="Owl", replacement = "Hawk", x=str2) # replace Owl with Hawk becomes HawkBear

gsub(pattern="Egg", replacement="Chicken", 
     x="Egg Egg") # gsub allows for replacing multiple strings at a time

strVect = strsplit("A dog ran fast", " ") # split string at spaces, store in vector
strVect

# factors
direction = c("Up", "Left","Right", "Down","Left", "Up")
factorDir = factor(direction)
is.factor(factorDir)
factorDir # duplicates are removed, it just shows Down Left Right Up

levels(x=factorDir) # factor objects store all possible levels
dow = c("Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", 
        "Sunday") # days of the week

wDays = c("Tuesday", "Thursday", "Monday") # work days

wdFact =factor(x=wDays, levels=dow, ordered=T)
wdFact


# data frames
custData = data.frame(name=c("Tom", "Sally", "Sue"),
                      age=c(43,28,35),
                      stringsAsFactors=F)

custData # displays as table

custData[1,1] # display row 1, column 1
custData[1,1:2] # display both columns from row1
custData[1:3,2] # rows 1-3, only column 2

dim(custData) # dimension of dataframe 3 rows 2 columns

# add new record to data frame
recordMark = data.frame(name="Mark", age=33)
custData = rbind(custData, recordMark)
custData

# add new column to the df, make sure to include values for each row
debt = c(0, 25.50, 36, 48.19)
custData = cbind(custData, debt)
custData

owesMoney = custData[custData$debt > 0,] # show every person that owes money
owesMoney

# loops
num = 1

repeat{
  print(num)
  num = num + 1
  if(num> 5) {
    break
  }
}

num = 5
while(num > 0) {
  num = num - 1
  if(num %% 2 == 0) # even num
  {
    next # next skips the rest of the loop, goes back to the top
  }
  print(num) # prints odd values
}

oneTo5 = 1:5
for(i in oneTo5) # can also say for(i in 1:5)
{
  print(i)
}

# matrices

matrix1 = matrix(data=c(1,2,3,4)) # matrix with 1 column
matrix1

matrix2 = matrix(data=c(1,2,3,4), nrow=2, ncol=2) # matrix with 2 rows and 2 columns
matrix2 # starts by filling columns then rows

matrix3 = matrix(data=c(1,2,3,4), nrow=2, ncol=2,byrow=T) # starts by filling rows then columns
matrix3

dim(matrix3)

matrix3[1,2] # get value from row 1 column 2
matrix3[1,] # get all values for row 1
matrix3[,2] # get all values for column 2

matrix4 = rbind(1:3, 4:6, 7:9)
matrix4

matrix4[2:3,] # rows 2 and 3
matrix4[-1,] # also shows rows 2 and 3

matrix4[1,1] = 0 # change row 1 column 1 value to 0
matrix4

matrix4[1,] = 0 # change all values in row 1 to 0
matrix4

matrix4[2,] = c(6,1,3) # change all values in row 2 
matrix4

# arrays
array1 = array(data=1:8, dim=c(2,2,2))
array1 

array1[1,2,2]

# functions
getSum = function(num1, num2) {
  return(num1 +num2)
}

sprintf("5 + 6 = %d", getSum(5,6))

getDifference = function(num1=1, num2=1) # assign default values for num1 and num2
{
  num1 -num2 # this will return without a return statement when it's called
}

sprintf("5 - 6 = %d", getDifference(5,6))

makeList = function(thestring) # return multiple values as a list
{ 
  return(strsplit(thestring, " "))
}

makeList("Random words to test")

missFunc = function(x)
{
  if(missing(x))
  {
    return("Missing argument")
  } 
  else
  {
    return(x)  
  }
}

missFunc()
missFunc(5)

# accept variable number of arguments using elipses ...
getSumMore = function(...)
{
  numList = list(...)
  sum = 0
  for(i in numList)
  {
    sum = sum + i
  }
  sum
}

getSumMore(1,2,3,4)
getSumMore(1,2,3,4,5,6,7)

# anonymous function
numList = 1:10 # create list of 10 numbers 1-10
dblList = (function(x) x* 2)(numList) # use anonymous function, double evrey number in the list
dblList

# closures are functions created by functions
# create a function that finds x to a user defined power
power = function(exp)
{
  function(x)
  {
    x ^ exp
  }
}

cubed = power(3)
cubed(2) # cube 2
cubed(1:5) # cube values 1-5


# store functions in list
addFunc = list(
  add2 = function(x) x + 2,
  add3 = function(x) x+ 3
)
addFunc$add2(5) # call addFunc list and add2 function

# exception handling

divide = function(num1, num2)
{
  tryCatch(
    num1/num2,
    error = function(e){
      if(is.character(num1) || is.character(num2)) {
        print("Can't divide with strings")
      }
    }
  )
}

divide(10, "5")

# read in files
myPeople = read.table(file=file.choose(), 
                      header=T,sep=" ",
                      na.strings="`",
                      stringsAsFactors=F)
myPeople

# add a person
lauraRecord = data.frame(fname="Laura", 
                         lname="Palmer",
                         sex="female")
myPeople = rbind(myPeople, lauraRecord)

myPeople[7,2] = "Smith"

write.table(x=myPeople, file=file.choose(),
            sep=" ", na="`", quote=F, row.names=F) # write data back to file

# head and tail of dataframe
head(myPeople, 3) # first 3 records
tail(myPeople) # everything else if no number is specified

# plotting
xy1 = matrix(data=c(1,2,3,4,5,
                    1,2,3,4,5), nrow=5, ncol=5)

plot(xy1)

x2 = c(1,2,3,4,5)
y2 = c(1,2,3,4,5)
plot(x2,y2,type="l") # plot just a line

plot(x2,y2,type="b") # plot a line and dots

# plot with title, axis labels, change color, etc
plot(x2,y2,type="o",
     main="My Plot", xlab="x axis",
     ylab="y axis", col="steelblue") 

# type colors() in console to get full color list

# plot with title, axis labels, change color, etc
plot(x2,y2,type="b", pch=2 , lty=2,
     main="My Plot", xlab="x axis",
     ylab="y axis", col="steelblue", xlim = c(-8,8), ylim = c(-8,8)) 

plot(x2,y2,type="b")
abline(h=c(2,4), col="red", lty=2) # draws dashed horizontal lines at y = 2 and y= 4
segments(x0=c(2,4), y0=c(2,2), x1=c(2,4), y1=c(4,4), col="red", lty=2) # boxes in area between (2,2) and (4,4)

arrows(x0=1.5, y0=4.5, x1=2.7, y1=3.25, col="blue") # prints blue arrow pointing at our center dot
text(x=1.25, y=4.75, labels="Center") # adds Center text just above our blue arrow

# load pre-built in data set
plot(faithful)
eruptions4 = with(faithful, faithful[eruptions > 4,])
points(eruptions4, col="red", pch=3)

# using built-in functions
sqrt(x=100)
log(x=4, base=2)
exp(x=2)
sum(c(1,2,3))
randD1 = c(1,5,6,7,10,16)
mean(randD1)
median(randD1)
min(randD1)
max(randD1)
range(randD1) # min and max
ceiling(4.5)
floor(4.5)
cumsum(c(1,2,3)) # cumulative sum
cumprod(c(1,2,3)) # cummulative product
cummax(c(7:9, 4:6, 1:3)) #cummulative max
cummin(c(7:9, 4:6, 1:3)) # cummulative min
# random number of coin flips: number of options 0 and 1, 10 coin flips
sample(0:1, 10, replace=T) 

sample(0:20, 10, replace=T) 



# pie charts
foodPref = c(15,35,10,25,15)
foodLabels = c("Spagehetti", "Pizza", "ChickenNuggets", "MacNCheese", "Tacos")
png(file="child_food_pref.png")
colors = rainbow(length(foodPref))
pie(foodPref, foodLabels, main="Food Prefs", col=colors)

legend("topright", c("Spaghetti", "Pizza", 
                     "ChickenNuggets", "MacNCheese", 
                     "Tacos"), cex=0.8, fill=colors) #cex reduces text size

dev.off()

# 3d pie chart
library(plotrix) # load plotrix library
png(file="3d_child_food_pref.png")
pie3D(foodPref, labels=foodLabels, main="Food Prefs", explode = 0.1, start = pi/2, labelcex=0.8)


dev.off()


# bar charts
png(file="food_pref_bar_chart.png")
colors=rainbow((length(foodPref)))
barplot(foodPref, names.arg=foodLabels, 
        xlab="Votes", ylab="Food Options",
        main="Food Prefs", col=colors)


dev.off()




