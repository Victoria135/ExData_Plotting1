# Downloading data and uzipping file, assigning data

setwd("C:/Users/rikig/OneDrive/Рабочий стол/Exploratory Data Analysis - project 1/")
getwd()

filename <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = file.path("C:/Users/rikig/OneDrive/Рабочий стол/Exploratory Data Analysis - project 1/", "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
                , method="curl")
}

list.files()

if (file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")) { 
  unzip(filename) 
}

data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
names(data) <- data[1,]
data <- data[-1,]

# Editing data
# All columns' data type is character so we need to change it accordingly

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(paste(data$Date,data$Time),
                      format = "%Y-%m-%d %H:%M:%S")
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])

filtered_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")


# Plot 1

with(filtered_data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power"))
dev.copy(device = png, width = 480, height = 480, file = "Plot 1.png")
dev.off()

# Plot 2

with(filtered_data, plot(Time, Global_active_power, type = "l"), col = "black")
dev.copy(device = png, width = 480, height = 480, file = "Plot 2.png")
dev.off()

# Plot 3

with(filtered_data, plot(Time, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering"), col = "black", )
with(filtered_data, lines(Time, Sub_metering_2, col = "red"))
with(filtered_data, lines(Time, Sub_metering_3, col = "blue"))


legend("topright",lty = 1, col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(device = png, width = 480, height = 480, file = "Plot 3.png")
dev.off()

# Plot 4

par(mfrow = c(2,2))

with(filtered_data, plot(Time, Global_active_power, type = "l"), col = "black")

with(filtered_data, plot(Time, Voltage, type = "l", ylab = "datetime"), col = "black")

with(filtered_data, plot(Time, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering"), col = "black", )
with(filtered_data, lines(Time, Sub_metering_2, col = "red"))
with(filtered_data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright",lty = 1, col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(filtered_data, plot(Time, Global_reactive_power, type = "l", ylab = "datetime"), col = "black")

dev.copy(device = png, width = 480, height = 480, file = "Plot 4.png")
dev.off()