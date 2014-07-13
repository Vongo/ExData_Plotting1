source("loadData.R")

data <- load.data()

cat("Plotting plot2...\n")
png(file="plot2.png",width=480,height=480)

plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()