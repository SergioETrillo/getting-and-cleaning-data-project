### project 1 ExData_Plotting1


# please ensure file "household_power_consumption.txt" is in working directory
#read data
data <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#setting local settings in English
Sys.setlocale("LC_TIME", "English")

#Converting Date to Date type
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#Subsetting relevant data
low <- as.Date("2007-02-01")
up <- as.Date("2007-02-02")
selection <- data[data$Date>=low&data$Date<=up,]

# memory clean up
rm(data)   

# coerce date and time to character, then paste it together as POSIXct and format as day of week
i <- sapply(selection,is.factor)
selection[i] <- lapply(selection[i],as.character)
selection$DateTime <- as.POSIXct(paste(selection$Date,selection$Time,format="%u"))

#plotting
plot(selection$DateTime,selection$Global_active_power,pch="",xlab="",ylab="Global Active Power(kilowatts)")
lines(selection$DateTime,selection$Global_active_power)

#printing to png
dev.copy(png,"plot2.png",width=480,height=480)

dev.off()