library(dplyr)
options(scipen=999)

Sys.setlocale("LC_TIME", "English")

plot4 <- function(file){
  table <- read.table(file, sep=";", header = TRUE, na.strings = '?')
  table$Date <- as.Date(table$Date, format="%d/%m/%Y")
  table$Global_active_power <- as.numeric(as.character(table$Global_active_power))
  sel <- table %>% filter(Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% mutate(weekday = as.POSIXct(paste(Date, Time))) #%>% select(weekday, c(Sub_metering_1, Sub_metering_2, Sub_metering_3))
  
  par(mfrow=c(2, 2))
  with(sel,{
    # Global Active Power
    plot(sel$weekday, sel$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    #Energy Sub Metering
    plot(sel$weekday, sel$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(sel$weekday, sel$Sub_metering_2, col="red")
    lines(sel$weekday, sel$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1:1, cex=0.8)
    # Voltage
    plot(sel$weekday, sel$Voltage, type="l", ylab="Voltage", xlab="")
    # Global Reactive Power
    plot(sel$weekday, sel$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="")
    
  })
  
  dev.copy(png,'Plot4.png', width=480, height=480)
  dev.off()
}

