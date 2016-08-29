## Plot 2 script for Exploratory Data Analysis course project

## get the data for household power consumption

if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}


data <- read.table(file, header=T, sep=';' ) 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")


## Subsetting the data
subdata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

## groom the variables to be used for eacg plot
subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage))
subdata <- transform(subdata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))


## Plot 2 
plot(subdata$timestamp,subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()


