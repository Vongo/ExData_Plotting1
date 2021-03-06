source("loadData.R")

data <- load.data()

cat("Plotting plot3...\n")
png(file="plot3.png",width=480,height=480)

par(mfrow = c(1,1))
plot(data$DateTime, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")

lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col= "red")
lines(data$DateTime, data$Sub_metering_3, col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black","red", "blue"))

dev.off()