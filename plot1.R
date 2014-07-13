source("loadData.R")

data <- load.data()

cat("Plotting plot1...\n")
png(file="plot1.png",width=480,height=480)

hist(data$Global_active_power, col = "red", ylab = "Frequency",
    xlab = "Global Active Power (kilowatts)", main = "Global Active Power ")

dev.off()

