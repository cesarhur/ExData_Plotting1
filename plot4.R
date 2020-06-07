
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink (temp)

#df <- read.csv("kk/household_power_consumption.txt", sep=";", header=TRUE)

d <- df[df$Date=="1/2/2007" | df$Date=="2/2/2007",]
d$timestamp <- strptime(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S")
d <- transform(d, Global_active_power=as.numeric(Global_active_power), Global_reactive_power=as.numeric(Global_reactive_power), Voltage=as.numeric(Voltage), Sub_metering_1=as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3=as.numeric(Sub_metering_3))


#Get file ready to draw
dev.cur()
png(file="plot4.png")

#Set 2 x 2 matrix of charts, where charts are filled rows first
par(mfrow=c(2,2))

#Top left chart
plot(d$timestamp, d$Global_active_power, xlab="", ylab="Global Active Power", type="l")

#Top right chart
plot(d$timestamp, d$Voltage, xlab="datetime", ylab="Voltage", type="l")

#Bottom left chart
plot(d$timestamp, d$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
points(d$timestamp, d$Sub_metering_2, col="red", type="l")
points(d$timestamp, d$Sub_metering_3, col="blue", type="l")
legend("topright", lty="solid", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

#Bottom right chart
plot(d$timestamp, d$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l", col="black")

dev.off()
