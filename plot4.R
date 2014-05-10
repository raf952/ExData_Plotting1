loadHpcData <- function () {
        filename <- "data/household_power_consumption.txt"
        hpc.data <- read.csv(file=filename,sep=";", na.strings="?")
        hpc.data$Date <- as.Date(hpc.data$Date, format="%d/%m/%Y")
        hpc.data$Time <- strptime(paste(hpc.data$Date, hpc.data$Time)
                                  , format="%Y-%m-%d %H:%M:%S" )
        hpc.data[hpc.data$Date=="2007-02-01"|hpc.data$Date=="2007-02-02" ,]
}

dev.on <- function(name) {
        png(name, width=480, height=480, units="px" )
}

source("plot2.R")
source("plot3.R")
plot4b <- function(hpc.data){
        grp.label <-"Global Reactive Power (kilowats)"
        
        plot(hpc.data$Time, hpc.data$Global_reactive_power, type="l", ylab=grp.label, xlab="")
}

plot4a <- function(hpc.data){
        plot(hpc.data$Time, hpc.data$Voltage, type="l", ylab="Voltage", xlab="")
}

plot4 <- function(fname = NULL, hpcData = NULL) {
        hpc.data <- if (is.null(hpcData)) {
                loadHpcData()
        } else {
                hpcData
        }   
        
        if (!is.null(fname)) dev.on(fname)
        par(mfcol=c(2,2))
        plot2(NULL, hpc.data)
        plot3(NULL, hpc.data)
        plot4a(hpc.data)
        plot4b(hpc.data)
        if (!is.null(fname)) dev.off()   
        par(mfcol=c(1,1))     
}