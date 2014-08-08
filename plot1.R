library(data.table)
# Read in data
data <- fread("household_power_consumption.txt")
data$Date1 <-strftime(strptime(data$Date,"%d/%m/%Y"),"%Y/%m/%d")

#Create dummy date variables for subsetting
x <- as.Date(paste("2007/02/01", format = "%Y/%m/%d"))
y <- as.Date(paste("2007/02/02", format = "%Y/%m/%d"))

#subset over 2 days
data1 <- subset(data, Date1 == x | Date1 == y)
data1$Global_active_power <- as.numeric(data1$Global_active_power)

#create plot in png file - # Initialize png graphics device
png(file = "plot1.png")
hist(data1$Global_active_power, xlab = "Global Active Power (Kilowatts)", main = "Global Active Power", col = "red")
dev.off()

