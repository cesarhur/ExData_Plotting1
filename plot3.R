
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink (temp)

#df <- read.csv("kk/household_power_consumption.txt", sep=";", header=TRUE)

d <- df[df$Date=="1/2/2007" | df$Date=="2/2/2007",]
d$timestamp <- strptime(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S")
d <- transform(d, Sub_metering_1=as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3=as.numeric(Sub_metering_3))

dev.cur()
png(file="plot3.png")
plot(d$timestamp, d$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
points(d$timestamp, d$Sub_metering_2, col="red", type="l")
points(d$timestamp, d$Sub_metering_3, col="blue", type="l")
legend("topright", lty="solid", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

