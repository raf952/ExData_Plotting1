# Ralph A Foy
# load in data from downloaded file, converting date & time
loadHpcData <- function () {
        filename <- "data/household_power_consumption.txt"
        hpc.data <- read.csv(file=filename,sep=";", na.strings="?")
        hpc.data$Date <- as.Date(hpc.data$Date, format="%d/%m/%Y")
        hpc.data$Time <- strptime(paste(hpc.data$Date, hpc.data$Time)
                                  , format="%Y-%m-%d %H:%M:%S" )
        hpc.data[hpc.data$Date=="2007-02-01"|hpc.data$Date=="2007-02-02" ,]
}

# open png file for output
dev.on <- function(name) {
        png(name, width=480, height=480, units="px", bg="transparent")
}

# generates plot2, sending image to screen if fname is NULL, and loading data
# from file if hpcData is NULL
plot2 <- function(fname = NULL, hpcData = NULL){
        hpc.data <- if (is.null(hpcData)) {
                loadHpcData()
        } else {
                hpcData
        }       
        gap.label <-"Global Active Power"
        
        if (!is.null(fname)) {
                dev.on(fname)
                gap.label <- paste(gap.label, "(kilowatts)")
        }
        
        plot(hpc.data$Time, hpc.data$Global_active_power, type="l"
             , ylab=gap.label, xlab="")
        if (!is.null(fname)) dev.off()   
}