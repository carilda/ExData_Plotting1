#!/usr/bin/Rscript

## plot2.R
## date: 09/13/2015
## author:  Carilda A Thomas
## system: Linux 3.19.8-100.fc20.x86_64 #1 SMP Tue May 12 17:08:50 UTC 2015
##      x86_64 x86_64 x86_64 GNU/Linux



library(data.table)

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
png("plot2.png")

plot(df$Datetime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## close the device
dev.off()
