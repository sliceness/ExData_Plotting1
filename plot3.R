# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")


# Unzip the data
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Shortcut to reference the path name
path_rf <- file.path("./data")

# Read the data
ElectricPowerConsumption  <- read.table(file.path(path_rf, "household_power_consumption.txt" ), header = TRUE, sep=";", na.strings="?")

#Concatenate Date and Time and add to dataframe
ElectricPowerConsumption$DateTime<-paste(ElectricPowerConsumption$Date, ElectricPowerConsumption$Time)

# Convert Date.Time to yyyy-mm-dd hh:mm:ss
ElectricPowerConsumption$DateTime<-strptime(ElectricPowerConsumption$DateTime, "%d/%m/%Y %H:%M:%S")

#Using only data from 2007-02-01 and 2007-02-02
start<-which(ElectricPowerConsumption$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(ElectricPowerConsumption$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
data<-ElectricPowerConsumption[start:end,]

#Set dates to be in English rather than Chinese
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")


#Plot3
png(filename = './plot3.png', width = 480, height = 480, units='px')
meterlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(data$DateTime, data$Sub_metering_1, type="l", col=meterlines[1], xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col=meterlines[2])
lines(data$DateTime, data$Sub_metering_3, col=meterlines[3])
legend("topright", legend=labels, col=meterlines, lty="solid")
dev.off()
