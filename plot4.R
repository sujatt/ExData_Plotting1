# These are the packages required to run this code.
require(data.table)
require(lubridate)

# Check if the data file exists in the local directory. If not, download the .zip file and unzip it.

if (!file.exists('household_power_consumption.txt')) {
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,'power_consumption.zip',method="curl")
unzip('power_consumption.zip',overwrite=TRUE)
}

# Read in the file, with the right separator (;) and treat "?' as NA

power.consumption<-read.table('household_power_consumption.txt',header=TRUE,sep=';',na.strings='?')

# Only use the data from the dates 2007-02-01 and 2007-02-02
power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
# Convert the date/time fields
power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
 power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)

# Now we are ready to proceed with the plotting.
# Plot 4: 4x4 plot of the plots 1,2, and 3, along with Voltage by date/time

png(filename='plot4.png',width=480,height=480,units='px')

par(mfrow=c(2,2))
plot(power.consumption$DateTime,power.consumption$Global_active_power,type='l',xlab='',ylab='Global Active Power')
plot(power.consumption$DateTime,power.consumption$Voltage,xlab='datetime',ylab='Voltage',type='l')
plot(power.consumption$DateTime,power.consumption$Sub_metering_1,xlab='',ylab='Energy sub metering',type='l')
lines(power.consumption$DateTime,power.consumption$Sub_metering_2,xlab='',col='red',type='l')
lines(power.consumption$DateTime,power.consumption$Sub_metering_3,xlab='',col='blue',type='l')
leg_names <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
  line_color<-c('black','red','blue')
 legend('topright',leg_names,col=line_color,lty='solid',cex=0.75,bty='n')
plot(power.consumption$DateTime,power.consumption$Global_reactive_power,xlab='datetime',ylab='Global_reactive_power',type='l')


x<-dev.off()
