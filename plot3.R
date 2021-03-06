#Read table and assign it to a variable.
hhpowcons <- read.table("C:/Users/Owner/Documents/R/ExploratoryDA/household_power_consumption.txt", header=TRUE, sep=";")

#Remove rows containing missing values from the dataset.
hhpowcons <- subset(hhpowcons, 1:ncol(hhpowcons) != "?")

#Convert factor class in Date column to Date class.
hhpowcons$Date = as.Date(hhpowcons$Date, '%d/%m/%Y')

#Convert Time column to POSIXct while adding in Date.
hhpowcons$Time = as.POSIXct(paste(hhpowcons$Date, hhpowcons$Time), format="%Y-%m-%d %H:%M:%S")

#Create subsets of the data for 2/1/2007 and 2/2/2007 and combine them in one dataset.
febonepow <- subset(hhpowcons, Date == "2007-02-01")
febtwopow <- subset(hhpowcons, Date == "2007-02-02")
febpow <- bind_rows(febonepow, febtwopow)

#Convert the remaining 7 columns to numeric data.  Since data is in the factor class, it must first be converted to the character class.
febpow$Global_active_power = as.character(febpow$Global_active_power)
febpow$Global_reactive_power = as.character(febpow$Global_reactive_power)
febpow$Voltage = as.character(febpow$Voltage)
febpow$Global_intensity = as.character(febpow$Global_intensity)
febpow$Sub_metering_1 = as.character(febpow$Sub_metering_1)
febpow$Sub_metering_2 = as.character(febpow$Sub_metering_2)
febpow$Sub_metering_3 = as.character(febpow$Sub_metering_3)

#Then it is converted to the numeric class.
febpow$Global_active_power = as.numeric(febpow$Global_active_power)
febpow$Global_reactive_power = as.numeric(febpow$Global_reactive_power)
febpow$Voltage = as.numeric(febpow$Voltage)
febpow$Global_intensity = as.numeric(febpow$Global_intensity)
febpow$Sub_metering_1 = as.numeric(febpow$Sub_metering_1)
febpow$Sub_metering_2 = as.numeric(febpow$Sub_metering_2)
febpow$Sub_metering_3 = as.numeric(febpow$Sub_metering_3)

#Plot each sub metering with different colors.
plot(febpow$Time, febpow$Sub_metering_1, xlab="", ylab="Energy sub meeting", type="l", col="dark green")
points(febpow$Time, febpow$Sub_metering_2, col="red", type="l")
points(febpow$Time, febpow$Sub_metering_3, col="blue", type="l")

#Create the legend.
legend("topright", col=c("dark green", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6, lty=1)
