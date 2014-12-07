#download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "powercons.zip", method = "curl")
#unzip("powercons.zip")

dates <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", rep("NULL", 8)))
dates <- as.Date(dates[ ,1], "%d/%m/%Y")

index <- which(dates > "2007-01-31" & dates < "2007-02-03")

data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c(rep("character", 2), rep("numeric", 6)), nrows = length(index), skip = index[1] - 1, na.strings = c("?"))
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data$DateTime <-  paste(data$Date, data$Time, sep = " ")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- as.Date(data$Time, format = "%H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

png("plot2.png")
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = NA, type = 'l')
dev.off()
