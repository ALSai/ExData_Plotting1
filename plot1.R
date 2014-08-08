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
png("plot1.png")
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
