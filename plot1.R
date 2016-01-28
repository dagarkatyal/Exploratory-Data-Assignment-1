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
par(mfrow = c(1,1))
with(powerData, hist(Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))

dev.copy(png,"plot1.png")
dev.off()
