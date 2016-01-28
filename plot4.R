#load the data from the file and store it in ORG file
powerDataORG <- read.table("household_power_consumption.txt",sep = ";", na.strings = "?", header = TRUE)

#create a backup and use that file
powerData <- powerDataORG

#conver date and time and add it to original table
dateTime <- paste(powerData$Date,powerData$Time)
dateTime <- strptime(dateTime , "%d/%m/%Y %H:%M:%S")
powerData$TimeStamp <- dateTime

#Change the date column from text to date
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")



#Define the start and end of data
dateFrom <- as.Date("2007-02-01", format = "%Y-%m-%d")
dateTo <- as.Date("2007-02-02", format = "%Y-%m-%d")


#Subset the data to keep only data for 2 days
powerData <- subset(powerData,Date>=dateFrom  & Date <= dateTo)

#plot the chart1
par(mfrow = c(2,2))

#first chart
plot(powerData$TimeStamp,powerData$Global_active_power, type = "l", xlab = "",ylab = "Global Active Power")
#second chart
plot(powerData$TimeStamp,powerData$Voltage, type = "l", xlab = "",ylab = "Voltage")
#third chart
plot(powerData$TimeStamp,powerData$Sub_metering_1, type = "l", xlab = "",ylab = "Energy Sub Metering")
lines(powerData$TimeStamp,powerData$Sub_metering_2, type = "l",col = "red")
lines(powerData$TimeStamp,powerData$Sub_metering_3, type = "l",col = "blue")
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#fourth chart
plot(powerData$TimeStamp,powerData$Global_reactive_power, type = "l", xlab = "datetime",ylab = "Global_reactive_power")

dev.copy(png,"plot4.png")
dev.off()
