# Libraries
require(igraph)

# CONSTANTS
DATA_PATH = "./household_power_consumption.txt"
ROWS = 2075260
START_DATE = as.Date("01/02/2007", format="%d/%m/%Y")
END_DATE = as.Date("02/02/2007", format="%d/%m/%Y")

# Operators
`%ni%` = Negate(`%in%`)

# Reading data
tab5rows <- read.table(DATA_PATH, sep=";", header=T, nrows=50, stringsAsFactors=F, dec=".")
classes <- sapply(tab5rows, class)
data <- read.table(DATA_PATH, sep=";", header=T, nrow=ROWS, colClasses=classes, stringsAsFactors=F, dec=".", na = "?")

# Formatting
data$Date <- as.Date(data$Date, format="%d/%m/%Y") 

# Filtering dates
cat("Removing outbound entries...\n")
outbound <- data[data$Date < START_DATE,]
data <- data[data$Date %ni% outbound$Date,]
cat(paste(" - Successfully removed",nrow(outbound),"early entries.\n"))
outbound <- data[data$Date > END_DATE,]
data <- data[data$Date %ni% outbound$Date,]
cat(paste(" - Successfully removed",nrow(outbound),"late entries.\n"))

# 1)
png(file="plot1.png",width=480,height=480)
hist(data$Global_active_power, col = "red", ylab = "Frequency",
    xlab = "Global Active Power (kilowatts)", main = "Global Active Power ")
dev.off()



# 2)
png(file="plot2.png",width=480,height=480)

data$DateTime = (paste(data$Date, data$Time))
data$DateTime = strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")

plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()


# 3)
png(file="plot3.png",width=480,height=480)

par(mfrow = c(1,1))
plot(data$DateTime, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")

lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col= "red")
lines(data$DateTime, data$Sub_metering_3, col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black","red", "blue"))


dev.off()


# 4)
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
