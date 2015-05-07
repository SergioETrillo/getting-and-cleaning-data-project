### project 1 ExData_Plotting1

#read data
# please ensure file is in working directory
# please clear all objects from workspace to ensure it properly works, they could be minor
# disadjustments if not cleared memory space.

data <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#setting local system as English
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

# plotting
par(mfrow =c(2,2))     # arrange in 2x2 matrix
with(selection,{
        #plot 1 top left
        plot(DateTime,Global_active_power,xlab="",ylab="Global Active Power",type="n")
        lines(DateTime,Global_active_power,xlab="",ylab="Global Active Power")
        #plot 2 top right
        plot(DateTime,Voltage,xlab="datetime",ylab="Voltage",type="n")
        lines(DateTime,Voltage,xlab="datetime",ylab="Voltage")
        #plot 3, bottom left, using http://stackoverflow.com/questions/7136990/change-font-in-a-legend
        # and http://stackoverflow.com/questions/16905535/r-legend-trouble-how-to-change-the-text-size-in-legend
        plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
        lines(DateTime,Sub_metering_1)
        lines(DateTime,Sub_metering_2,col="red")
        lines(DateTime,Sub_metering_3,col="blue")
        legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,bty="n",cex=0.5)
        plot(DateTime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="n")
        lines(DateTime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power")
})

# printing to png
dev.copy(png,"plot4.png",width=480,height=480)

dev.off()