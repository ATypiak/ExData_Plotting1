#makes a histogram and writes it to plot1.png


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

#write histogram to plot1.png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(epc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
dev.off()

