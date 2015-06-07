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
# Plot 3: Plot of the different energy sub metering types by day (date/time)
png(filename='plot3.png',width=480,height=480,units='px')


plot(power.consumption$DateTime, power.consumption$Sub_metering_1,xlab='',ylab='Energy sub metering',type='l')
lines(power.consumption$DateTime, power.consumption$Sub_metering_2,xlab='',col='red',type='l')
lines(power.consumption$DateTime, power.consumption$Sub_metering_3,xlab='',col='blue',type='l')

line_color<-c('black','red','blue')

leg_names <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
 line_color<-c('black','red','blue')
legend('topright',leg_names,col=line_color,lty='solid')

x<-dev.off()
