library(tidyverse)
library(lubridate)

powerDF <- read_delim("household_power_consumption.txt",
                      delim = ";",
                      na = c("?", "NA"),
                      col_types = cols(
                          Date = col_date(format = "%d/%m/%Y"),
                          Time = col_time(format = "%H:%M:%S"),
                          Global_active_power = col_double(),
                          Global_reactive_power = col_double(),
                          Voltage = col_double(),
                          Global_intensity = col_double(),
                          Sub_metering_1 = col_double(),
                          Sub_metering_2 = col_double(),
                          Sub_metering_3 = col_double()
                      )
    ) %>%
    filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02")) %>%
    mutate(DateTime = ymd_hms(paste(Date, Time)))
    
png(filename = "plot4.png",
    width = 480,
    height = 480)

par(mfcol = c(2, 2))

plot(powerDF$DateTime, powerDF$Global_active_power, 
     type = "l",
     ylab = "Global Active Power",
     xlab = ""
)

plot(powerDF$DateTime, powerDF$Sub_metering_1,
     ylim = range(powerDF$Sub_metering_1, powerDF$Sub_metering_2, powerDF$Sub_metering_3),
     type = "l",
     ylab = "Energy sub metering",
     xlab = ""
)
lines(powerDF$DateTime, powerDF$Sub_metering_2, col = "red")
lines(powerDF$DateTime, powerDF$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n"
)

plot(powerDF$DateTime, powerDF$Voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime"
)

plot(powerDF$DateTime, powerDF$Global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime"
)

dev.off()
