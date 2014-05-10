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

plot2 <- function(fname = NULL, hpcData = NULL){
        hpc.data <- if (is.null(hpcData)) {
                loadHpcData()
        } else {
                hpcData
        }       
        gap.label <-"Global Active Power (kilowats)"
        
        if (!is.null(fname)) {
                dev.on(fname)
        }
        
        plot(hpc.data$Time, hpc.data$Global_active_power, type="l"
             , ylab=gap.label, xlab="")
        if (!is.null(fname)) dev.off()   
}