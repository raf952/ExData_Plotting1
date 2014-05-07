filename <- "data/household_power_consumption.txt"

strptime(paste(as.Date("1999/01/01"), "17:24:00"), format="%Y-%m-%d %H:%M:%S")
subset.data <- head(hpc.data)

loadHpcData <- function () {
        hpc.data <- read.csv(file=filename,sep=";", na.strings="?")
        hpc.data$Date <- as.Date(hpc.data$Date, format="%d/%m/%Y")
        hpc.data$Time <- strptime(paste(hpc.data$Date, hpc.data$Time)
                                  , format="%Y-%m-%d %H:%M:%S" )
        hpc.data[hpc.data$Date=="2007-02-01"|hpc.data$Date=="2007-02-02" ,]
}
gap.label <-"Global Active Power (kilowats)"
plot1 <- function(){
   hist(hpc.data$Global_active_power, col="red", main="Global Active Power", xlab=gap.label, ylab="Frequency")
}

plot2 <- function(){
        plot(hpc.data$Time, hpc.data$Global_active_power, type="l"
             , ylab=gap.label, xlab="")
}

esm.label<-"Energy sub meeting"
plot3 <- function(){
        plot(hpc.data$Time, hpc.data$Sub_metering_1, type="l", ylab=esm.label, xlab="")
        lines(hpc.data$Time,hpc.data$Sub_metering_2, col="red" )
        lines(hpc.data$Time,hpc.data$Sub_metering_3, col="blue" )
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = c(1,1,1)
               , col=c('black','red','blue'), box.col=NA)
}
grp.label <-"Global Reactive Power (kilowats)"

plot4b <- function(){
        plot(hpc.data$Time, hpc.data$Global_reactive_power, type="l", ylab=grp.label, xlab="")
}

plot4a <- function(){
        plot(hpc.data$Time, hpc.data$Voltage, type="l", ylab="Voltage", xlab="")
}

plot4 <- function() {
        par(mfcol=c(2,2))
        plot2()
        plot3()
        plot4a()
        plot4b()
}
