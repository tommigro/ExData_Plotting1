library(dplyr)
options(scipen=999)

plot1 <- function(file){
  table <- read.table(file, sep=";", header = TRUE, na.strings = '?')
  table$Date <- as.Date(table$Date, format="%d/%m/%Y")
  table$Global_active_power <- as.numeric(as.character(table$Global_active_power))
  sel <- table %>% filter(Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
  plot1 <- hist(sel$Global_active_power, col ="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
  
  dev.copy(png,'Plot1.png', width=480, height=480)
  dev.off()
}
