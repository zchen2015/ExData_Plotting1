## download data file and unzip the file
print("downloading data ...")
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="exdata-data-household_power_consumption.zip", method="libcurl", quiet=TRUE)
unzip("exdata-data-household_power_consumption.zip")

## load data and get subset
print("loading data ...")
cla <- sapply(read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrow=10), class)
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=cla)

data[,"Date"] <- as.Date(data$Date, "%d/%m/%Y")
subset(data, Date=="2007-02-01" | Date=="2007-02-02") -> da1

## creat datetime column
da2 <- cbind(da1,datetime=as.POSIXct(paste(da1$Date,da1$Time, sep=" ")))

## plot4
print("make plot ...")
png("plot4.png", w=480, h=480)
par(mfcol=c(2,2))

## plot plot Global_active_power vs datetime
plot(da2$datetime, da2$Global_active_power, ylab="Global active power", type="l", xlab="")

## plot Sub_metering vs datetime
plot(da2$datetime, da2$Sub_metering_1, ylab="Energy sub metering", type="l", xlab="")
points(da2$datetime, da2$Sub_metering_2, type="l", col="red")
points(da2$datetime, da2$Sub_metering_3, type="l", col="blue")
leg = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", col=c("black","red", "blue"), legend=leg, lty=1, cex=0.7)

## plot Voltage vs datetime
plot(da2$datetime, da2$Voltage, ylab="Voltage", type="l", xlab="datetime")

## plot Global_reactive_power vs datetime
plot(da2$datetime, da2$Global_reactive_power, ylab="Global reactive power", type="l", xlab="datetime")

dev.off()
