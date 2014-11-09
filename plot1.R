if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("http://j.mp/TbC79E", "./data/power_data.zip", method = "wget")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

head -n 1 ./data/household_power_consumption.txt > ./data/feb2007data.txt

cat ./data/household_power_consumption.txt  | grep '^0\{0,1\}[12]/0\{0,1\}2/2007' >> ./data/feb2007data.txt

datafile <- "./data/feb2007data.txt"
data <- read.table(datafile, sep = ";", header = T, na.strings = "?")

data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

hist(data$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, ylim = c(0,1200), xlim = c(0, 6), xaxp = c(0, 6, 3))