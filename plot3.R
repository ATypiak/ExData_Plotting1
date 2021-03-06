#makes a plot and writes it to plot3.png


#read sample of file to check how it looks like
sample <- read.table("household_power_consumption.txt", header=TRUE, nrows = 50)
sample2 <- read.table("household_power_consumption.txt", header=TRUE, nrows = 50, sep =";")
col_numb <- ncol(sample2)

#read only Date column
date <- read.table("household_power_consumption.txt", header=TRUE, as.is=TRUE, 
                   sep =";", colClasses = c(NA, rep("NULL", col_numb - 1)))

#convert format of Date column to date
date2 <- as.Date(date$Date, format ="%d/%m/%Y")

#read how many rows is in needed date and from which row I should start read
days <- which(date2 == "2007-02-01" | date2 == "2007-02-02") 

#read only needed rows from the whole file
epc <- read.table("household_power_consumption.txt", header=TRUE, nrows= 2880, skip=66636, sep =";")

#put names to the data.frame
names(epc) <- names(sample2)

#clean data and conver Date and Time to date format
time <- paste(epc$Date, epc$Time, sep= " ")
DateTime <- as.POSIXct(time, format = "%d/%m/%Y %H:%M:%S")
new_epc <- cbind(DateTime, epc[3:9])

#change location to English
Sys.setlocale("LC_TIME", "English")

#write plot to plot3.png
png(filename = "plot3.png", width = 480, height = 480, units = "px")

par(xaxs="r")

plot(new_epc$DateTime, new_epc$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = " ", col="black")
lines(new_epc$DateTime, new_epc$Sub_metering_2, col="red")
lines(new_epc$DateTime, new_epc$Sub_metering_3, col="blue")
legend("topright", legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col=c("black", "red", "blue"), lty = c(1,1,1), cex=0.75)

dev.off()