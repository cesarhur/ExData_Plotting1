
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink (temp)

#df <- read.csv("household_power_consumption.txt", sep=";", header=TRUE)
d <- df[df$Date=="1/2/2007" | df$Date=="2/2/2007",]
d$timestamp <- strptime(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S")
d <- transform(d, Global_active_power=as.numeric(Global_active_power))

dev.cur()
png(file="plot1.png")
hist(d$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
