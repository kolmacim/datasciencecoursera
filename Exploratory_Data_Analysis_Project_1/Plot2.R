#include library
library(dplyr)

##Set WD
#setwd(".")

##Load the data first
power_cons = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

power_cons <- filter(power_cons, Date == "1/2/2007" | Date == "2/2/2007")

##Create plot 2
power_cons <- mutate(power_cons, DateTime = paste(Date, Time, sep = " "))
power_cons_datetime <- strptime(power_cons$DateTime, format="%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(power_cons_datetime, 
     as.numeric(power_cons$Global_active_power)/1000, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
