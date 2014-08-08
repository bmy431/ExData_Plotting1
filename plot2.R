library(data.table)
# Read in data
data <- fread("household_power_consumption.txt")
data$Date1 <-strftime(strptime(data$Date,"%d/%m/%Y"),"%Y/%m/%d")

#Create dummy date variables for subsetting
x <- as.Date(paste("2007/02/01", format = "%Y/%m/%d"))
y <- as.Date(paste("2007/02/02", format = "%Y/%m/%d"))

#subset over 2 days
data1 <- subset(data, Date1 == x | Date1 == y)

#reformat date and time in one POSIXct object
data1$truedate <- as.POSIXct(strptime(paste(data1$Date,data1$Time), "%d/%m/%Y %H:%M:%S"))

#create plot in png file - # Initialize png graphics device
png(file = "plot2.png")
with(data1, plot(truedate, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()