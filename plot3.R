### project 1 ExData_Plotting1

#read data
# please ensure file is in working directory

data <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#setting local settings in English
Sys.setlocale("LC_TIME", "English")

#Converting Date to Date type
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#Subsetting relevant data
low <- as.Date("2007-02-01")
up <- as.Date("2007-02-02")
selection <- data[data$Date>=low&data$Date<=up,]
#clean up memory
rm(data)   

# coerce date and time to character, then paste it together as POSIXct and format as day of week
i <- sapply(selection,is.factor)
selection[i] <- lapply(selection[i],as.character)
selection$DateTime <- as.POSIXct(paste(selection$Date,selection$Time,format="%u"))

#plotting 
with(selection,plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n"))
with(selection,lines(DateTime,Sub_metering_1))
with(selection,lines(DateTime,Sub_metering_2,col="red"))
with(selection,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pt.cex=2,cex=0.7,lwd=1)

# printing to png
dev.copy(png,"plot3.png",width=480,height=480)

dev.off()