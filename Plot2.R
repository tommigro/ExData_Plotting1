library(dplyr)
options(scipen=999)

Sys.setlocale("LC_TIME", "English")

plot2 <- function(file){
  table <- read.table(file, sep=";", header = TRUE, na.strings = '?')
  table$Date <- as.Date(table$Date, format="%d/%m/%Y")
  table$Global_active_power <- as.numeric(as.character(table$Global_active_power))
  sel <- table %>% filter(Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% mutate(weekday = as.POSIXct(paste(Date, Time))) %>% select(weekday, Global_active_power)
  
  with(sel, plot(weekday, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
  
  dev.copy(png,'Plot2.png', width=480, height=480)
  dev.off()
}
