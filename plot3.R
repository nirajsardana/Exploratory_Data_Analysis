if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("http://j.mp/TbC79E", "./data/power_data.zip", method = "wget")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

head -n 1 ./data/household_power_consumption.txt > ./data/feb2007data.txt

cat ./data/household_power_consumption.txt  | grep '^0\{0,1\}[12]/0\{0,1\}2/2007' >> ./data/feb2007data.txt

datafile <- "./data/feb2007data.txt"
data <- read.table(datafile, sep = ";", header = T, na.strings = "?")

data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

plot(data$Datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(data$Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(data$Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## quartz_off_screen 
##                 3
## pdf 
##   2