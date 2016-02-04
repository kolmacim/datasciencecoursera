#include library
library(dplyr)

##Set WD
#setwd(".")

##Load the data first
power_cons = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

power_cons <- filter(power_cons, Date == "1/2/2007" | Date == "2/2/2007")

##Create plot 3
power_cons <- mutate(power_cons, DateTime = paste(Date, Time, sep = " "))
power_cons_datetime <- strptime(power_cons$DateTime, format="%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)


plot(power_cons_datetime,
     as.numeric(power_cons$Sub_metering_1),
     type="l",
     ylab="Energy Submetering",
     xlab="")

lines(power_cons_datetime, 
      as.numeric(power_cons$Sub_metering_2), 
      type="l", 
      col="red")

lines(power_cons_datetime, 
      as.numeric(power_cons$Sub_metering_3), 
      type="l", 
      col="blue")

legend("topright", 
       c("Sub metering 1", "Sub metering 2", "Sub metering 3")
       ,lty=1
       ,lwd=2
       ,col=c("black", "red", "blue"))

dev.off()


