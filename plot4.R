#download file, unzip, and read into R
url <- paste("https://d396qusza40orc.cloudfront.net/exdata%2F",
  "data%2Fhousehold_power_consumption.zip",sep="")
download.file(url,destfile="XPA1.zip")
file <- unzip("XPA1.zip")
file <- read.table(file,header=TRUE,sep=";",na.strings="?")

#subset file on selected dates, convert date, and create a datetime variable
file <- file[which(file$Date=="1/2/2007" | file$Date=="2/2/2007"),]
file$Date <- as.Date(file$Date,"%d/%m/%Y")
file$datetime <- paste(file$Date,file$Time)
file$datetime <- strptime(file$datetime,format="%Y-%m-%d %H:%M:%S")

#select names for legend
legend_names <- names(file[,7:9])

#open png device and set filename
png("plot4.png")

#set parameters for plotting and create four specified plots
par(mfcol=c(2,2))
with(file, {
    plot(datetime,Global_active_power,type='l',xlab="",
         ylab = "Global Active Power",cex.lab=.9)
    plot(datetime,Sub_metering_1,type='l',xlab="",ylab = "Energy sub metering",
         cex.lab=.9)
    points(datetime,Sub_metering_2,type='l',col='red')
    points(datetime,Sub_metering_3,type='l',col='blue')
    legend("topright",legend=legend_names,lty=1,bty="n",
           ,col=c("black","red","blue"),cex=.95)
    plot(datetime,Voltage,type='l',cex.lab=.9)
    plot(datetime,Global_reactive_power,type='l',cex.lab=.9)    
})

#close device to create output
dev.off()