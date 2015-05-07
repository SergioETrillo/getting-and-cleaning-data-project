### project 1 ExData_Plotting1

#read data
# please ensure file "household_power_consumption.txt" is in working directory

data <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#Converting Date to Date type
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#Subsetting relevant data
low <- as.Date("2007-02-01")
up <- as.Date("2007-02-02")
selection <- data[data$Date>=low&data$Date<=up,]

# memory clean up
rm(data)   

#selecting relevant data
selection$Weekday <- weekdays(selection$Date)

#plotting
hist(selection$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="")
title(main="Global Active Power",font.main=1)

#printing to png
dev.copy(png,"plot1.png",width=480,height=480)

dev.off()