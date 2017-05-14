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

#Plot4
png(filename = './plot4.png', width = 480, height = 480, units='px')
par(mfcol = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
plot(data$DateTime, as.numeric(as.character(data$Global_active_power)),type='l',ylab="Global Active Power", xlab="")
plot(data$DateTime, as.numeric(as.character(data$Sub_metering_1)),type='l', xlab="",ylab ="Energy sub metering")
lines(data$DateTime, as.numeric(as.character(data$Sub_metering_2)),type='l', col='red')
lines(data$DateTime, data$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))
plot(data$DateTime, as.numeric(as.character(data$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )
plot(data$DateTime, as.numeric(as.character(data$Global_reactive_power)),type='l', 
     ylab="Global_reactive_power",xlab="datetime" )
dev.off()