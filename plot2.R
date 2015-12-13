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

#open png device and set filename
png("plot2.png")

#create specified plot
with(file,plot(datetime,Global_active_power,type='l',xlab=""
                ,ylab = "Global Active Power (kilowatts)"))

#close device to create output
dev.off()