create_data_directory <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
}

download_and_unzip <- function(url, destfile) {
    if (!file.exists(destfile)) {
        download.file(url, destfile, method = "curl")
    }
    unzip(zipfile = destfile, exdir = "data")
}

plot3 <- function() {
    create_data_directory()
    download_and_unzip(
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile = "data/exdata-data-household_power_consumption.zip")
    data_file <- "data/household_power_consumption.txt"
    column_names <- read.delim(
        file = data_file,
        header = TRUE,
        nrows = 1,
        sep = ";")
    household_power_consumption <- read.delim(
        col.names = names(column_names),
        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
        file = data_file,
        header = FALSE,
        nrows = 2880,
        sep = ";",
        skip = 66637)
    
    household_power_consumption$DateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), format = "%e/%m/%Y %T")
    
    png(file = "plot3.png")
    
    with(
        household_power_consumption, {
            plot(
                x = DateTime,
                y = Sub_metering_1,
                type = "l",
                xlab = "",
                ylab = "Energy sub metering")
            lines(
                x = DateTime,
                y = Sub_metering_2,
                col = "red",
                type = "l")
            lines(
                x = DateTime,
                y = Sub_metering_3,
                col = "blue",
                type = "l")
        }
    )
    
    legend(
        x = "topright",
        col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = c(1,1)
        )
    
    dev.off()
}
