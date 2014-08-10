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

plot1 <- function() {
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
        file = data_file,
        header = FALSE,
        nrows = 2880,
        sep = ";",
        skip = 66637)
    
    png(file = "plot1.png")
    
    hist(
        x = household_power_consumption$Global_active_power,
        col = "red",
        xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power")
    
    dev.off()
}
