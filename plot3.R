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

plot3 <- function(fname = NULL, hpcData = NULL){
        esm.label<-"Energy sub meeting"
        
        hpc.data <- if (is.null(hpcData)) {
                loadHpcData()
        } else {
                hpcData
        }
        
        if (is.null(fname)) {
                lwd <- 0
                xlab <- "datetime"
        } else {
                dev.on(fname)
                lwd <- 1
                xlab <- ""
        }
        plot(hpc.data$Time, hpc.data$Sub_metering_1, type="l", ylab=esm.label, xlab=xlab)
        lines(hpc.data$Time,hpc.data$Sub_metering_2, col="red" )
        lines(hpc.data$Time,hpc.data$Sub_metering_3, col="blue" )
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = c(1,1,1)
               , col=c('black','red','blue'), box.lwd=lwd )
        if (!is.null(fname)) dev.off()   
}
