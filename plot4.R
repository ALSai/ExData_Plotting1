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
png("plot4.png")
Sys.setlocale("LC_TIME", "C")
par(mfrow = c(2,2))
with(data, {
  # Graph 1
  plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  # Graph 2
  plot(DateTime, Voltage, type="l", xlab="datetime")
  
  # Graph 3
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  points(DateTime, Sub_metering_2, type="l", col="red", ylab="datetime")
  points(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # Graph 4
  plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()

