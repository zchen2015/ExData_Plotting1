##

## download data file and unzip the file
print("downloading data ...")
url1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1, destfile="exdata-data-household_power_consumption.zip", method="libcurl", quiet=TRUE)
unzip("exdata-data-household_power_consumption.zip")

## load data and get subset
print("loading data ...")
cla <- sapply(read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrow=100), class)
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=cla)

data[,"Date"] <- as.Date(data$Date, "%d/%m/%Y")
subset(data, Date=="2007-02-01" | Date=="2007-02-02") -> da1

## creat datetime column
da2 <- cbind(da1,datetime=as.POSIXct(paste(da1$Date,da1$Time, sep=" ")))

## plot1
print("make plot ...")
png("plot1.png", w=480, h=480)
hist(da2$Global_active_power, xlab="Global active power (kilowatts)", main="Global active power", col="red")
dev.off()

