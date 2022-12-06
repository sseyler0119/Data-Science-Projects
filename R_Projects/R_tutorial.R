mlbPlayers = read.table(file=file.choose(),
                        header=T, sep=" ",
                        na.strings="`",
                        stringsAsFactors=F)

# Grab just RBIs and Avg for each player
# playerData is known as a data frame (Table of Data)
# We get the stats we want by passing that list in a vector
playerData = mlbPlayers[,c("RBI","AVG")]

# Create the file
png(file="player_rbi_avg.png")

# Create the plot
plot(x=playerData$RBI, y=playerData$AVG,
     xlab="RBI", ylab="AVG", main="RBIs and Average")

# Create the file
dev.off()

# regression analysis

relation = lm(playerData$RBI~playerData$AVG)
png(file="RBI_AVG_Regression.png")
plot(playerData$AVG, playerData$RBI,
    main="AVG & RBI Regression",
    abline(lm(playerData$RBI~playerData$AVG)),
    xlab="AVG", ylab="RBIs")

dev.off() # save the file