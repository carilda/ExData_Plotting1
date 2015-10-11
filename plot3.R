#!/usr/bin/Rscript

## plot3.R
## date: 09/13/2015
## author:  Carilda A Thomas
## system: Linux 3.19.8-100.fc20.x86_64 #1 SMP Tue May 12 17:08:50 UTC 2015
##      x86_64 x86_64 x86_64 GNU/Linux



## download exdata-data-household_power_consumption.zip
## unzip exdata-data-household_power_consumption.zip

if (!file.exists("household_power_consumption.txt")) {
    stop("file not found")
}

## pipe and grep should be available on windows in Rtools
df <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = FALSE, sep = ";", na.strings = "?")
cnames <- strsplit(readLines("household_power_consumption.txt", n = 1), ";")[[1]]
colnames(df) <- cnames
df$Datetime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

## end preparationx
## png defaults are ok for assignment (480x480 in pixels)
png("plot3.png")

plot(df$Datetime, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(df$Datetime, df$Sub_metering_1, col = "black")
lines(df$Datetime, df$Sub_metering_2, col = "red")
lines(df$Datetime, df$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

## close the device
dev.off()
