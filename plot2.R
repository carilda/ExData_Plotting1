#!/usr/bin/Rscript

## plot2.R
## date: 09/13/2015
## author:  Carilda A Thomas
## system: Linux 3.19.8-100.fc20.x86_64 #1 SMP Tue May 12 17:08:50 UTC 2015
##      x86_64 x86_64 x86_64 GNU/Linux



library(data.table)
library("ggplot2")

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
DT <- data.table(df)

## end preparationx
## png defaults are ok for assignment (480x480 in pixels)
png("plot2.png")

ggplot(DT, aes(x = Datetime, y= Global_active_power, group = 1), xlab = c("Thu", "Fri", "Sat")) + geom_line()

## close the device
dev.off()
