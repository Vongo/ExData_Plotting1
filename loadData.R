# This functions deals with the data :
# - Downloading
# - Unzipping
# - Reading
# - Filtering

#  I decided not to read just a specific range because in the real world, we'll have to deal with much bigger files 
# and won't be able to read it manually (ocularly ?) to check what to read.

# You might have to uncomment the following in order to run the code.
# install.packages('downloader')

# Libraries

# CONSTANTS
FILE_NAME = "household_power_consumption.txt"
ZIP_NAME = "exdata_data_household_power_consumption.zip"
ROWS = 2075260
START_DATE = as.Date("01/02/2007", format="%d/%m/%Y")
END_DATE = as.Date("02/02/2007", format="%d/%m/%Y")

# Operators
`%ni%` = Negate(`%in%`)

load.data <- function() {
	
	# Download the data from distant repo if the proper file/zip is not in the working directory
	if(sum(grepl(FILE_NAME, list.files("."))) == 0){
		if(sum(grepl(ZIP_NAME, list.files("."))) == 0){
			require(downloader)
			tmp <- tempfile(fileext = ".zip")
			url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
			download(url, tmp)
			file <- unzip(tmp)
		} else unzip(ZIP_NAME)
	}

	# Reading data
	cat("Reading data...\n")
	tab5rows <- read.table(FILE_NAME, sep=";", header=T, nrows=50, stringsAsFactors=F, dec=".")
	classes <- sapply(tab5rows, class)
	data <- read.table(FILE_NAME, sep=";", header=T, nrow=ROWS, colClasses=classes, stringsAsFactors=F, dec=".", na = "?")

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

	data$DateTime = (paste(data$Date, data$Time))
	data$DateTime = strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")

	data
}