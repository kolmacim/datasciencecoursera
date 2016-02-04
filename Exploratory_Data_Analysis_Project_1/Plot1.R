#include library
library(dplyr)

##Set WD
#setwd(".")

##Load the data first
power_cons = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

power_cons <- filter(power_cons, Date == "1/2/2007" | Date == "2/2/2007")

##Create plot 1
png("plot1.png", width=480, height=480)
hist(as.numeric(power_cons$Global_active_power)/1000,
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
