plot4 <- function(p1table) {
  
  #construct uri
  uri <- paste(getwd(), "/exdata/", "household_power_consumption.txt", sep="")
  print(uri)
  
  #load table
  p1table <- read.csv(uri, header=TRUE, sep=";", quote="", row.names=NULL, stringsAsFactors=FALSE)
  #print(head(p1table))
  
  #subset relevant days
  p1table$Date <- as.Date(p1table$Date, format='%d/%m/%Y')
  p1table <- p1table [p1table$Date>="2007-02-01" & p1table$Date<="2007-02-02", ]
  #print(head(p1table))
  
  #create timestamp column
  p1table$Timestamp <- paste (p1table[,1], p1table[,2], sep=" ")
  #print (head(p1table))
  
  #interprete timestamp
  p1table$Timestamp <- strptime(p1table$Timestamp, format='%Y-%m-%d %H:%M:%S')
  #print (head(p1table))
  
  #set mfrow and plot
  par (mfrow=c(2, 2))
  plot (p1table$Timestamp, p1table$Global_active_power, cex.lab=0.75, cex.axis=0.75, type='l', ylab="Global Active Power", xlab="")
  plot (p1table$Timestamp, p1table$Voltage, cex.lab=0.75, cex.axis=0.75, type='l', ylab="Voltage", xlab="datetime")
  plot (p1table$Timestamp, p1table$Sub_metering_1, cex.lab=0.75, cex.axis=0.75, type='n', ylab="Energy sub metering", xlab="")
  points (p1table$Timestamp, p1table$Sub_metering_1, type='l', col="black")
  points (p1table$Timestamp, p1table$Sub_metering_2, type='l', col="red")
  points (p1table$Timestamp, p1table$Sub_metering_3, type='l', col="blue")
  legend ("topright", inset=-0.1, bty="n", lty="solid", y.intersp=0.25, cex=0.75, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot (p1table$Timestamp, p1table$Global_reactive_power, cex.lab=0.75, cex.axis=0.75, type='l', ylab="Voltage", xlab="datetime")
  
  #copy to file
  dev.copy(png, file="plot4.png")
  dev.off()
}