source("loadData.R")

data <- load.data()

cat("Plotting plot4...\n")
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2))

plot(data$DateTime, data$Global_active_power, pch=NA, main="", ylab = "Global Active Power", xlab = "")
lines(data$DateTime, data$Global_active_power)

plot(data$DateTime, data$Voltage, pch=NA, main="", ylab = "Voltage", xlab = "datetime")
lines(data$DateTime, data$Voltage)

plot(data$DateTime, data$Sub_metering_1, pch=NA, main="", ylab = "Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       lwd=c(1,1,1), col=c("black", "red", "blue"), bty="n")

plot(data$DateTime, data$Global_reactive_power, pch=NA, main="", ylab = "Global_reactive_power", xlab = "datetime")
lines(data$DateTime, data$Global_reactive_power)

dev.off()