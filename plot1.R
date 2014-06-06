plot1 <- function() {
  
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
  
  #set mfrow and plot histogram
  par (mfrow=c(1, 1))
  hist (as.numeric(p1table$Global_active_power), cex.lab=0.75, cex.axis=0.75, cex.main=0.75, col=2, main="Global Active Power", xlab="Global Active Power (kilowatts)")
  
  #copy to file
  dev.copy(png, file="plot1.png")
  dev.off()
}