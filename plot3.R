# Downloading and preparing data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip", "curl")
unzip("data.zip")

# Read data
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

# Subset data
data$DateObject <- as.Date(data$Date, "%d/%m/%Y")
data <-subset(data, DateObject >= as.Date("2007-02-01") & DateObject <= as.Date("2007-02-02"))

# Transform data
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Clean data
data$DateObject <- NULL
data$Date <- NULL
data$Time <- NULL

# Making the graph
png("plot3.png")
Sys.setlocale("LC_TIME", "C")
with(data, {
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  points(DateTime, Sub_metering_2, type="l", col="red")
  points(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
