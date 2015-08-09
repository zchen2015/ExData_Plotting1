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

## plot2
print("make plot ...")
png("plot2.png", w=480, h=480)
plot(da2$datetime, da2$Global_active_power, ylab="Global active power (kilowatts)", type="l", xlab="")
dev.off()
