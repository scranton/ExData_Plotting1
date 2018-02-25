library(tidyverse)
library(lubridate)

## Load Data
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

## Setup PNG file
png(filename = "plot1.png",
    width = 480,
    height = 480)

## Create histogram
hist(powerDF$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
)

## Close PNG file
dev.off()