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

# plot in multiple parts to get three different lines
# Initialize png graphics device
png(file = "plot3.png")
with(data1, plot(truedate, Sub_metering_1, type ="n", xlab ="", ylab = "Energy sub metering" ))
with( data1, lines(truedate, Sub_metering_1, col = "black", type = "l"))
with( data1, lines(truedate, Sub_metering_2, col = "red", type = "l"))
with( data1, lines(truedate, Sub_metering_3, col = "blue", type = "l"))

  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"))
dev.off()