## The funtion plot1 creates an histogram of global active power (column 3)
## The data is retrieved from file "household_power_consumption.txt"
## The whole table could be loaded to memory (variable powerdata)
## The subset data contains only the rows where the date is "2007-02-01" or "2007-02-02"
plot1 <- function() {
    
    ## Check if the file exists, otherwise try to download it
    ## If the file could neither be found nor downloaded, stop program before reading data
    if (!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile="exploratorydata.zip")
        if (file.exists("exploratorydata.zip")) {
            unzip("exploratorydata.zip")
        } else
        {
            stop("Power consumption file was not found and could not be downloaded")
        }
    }
    
    ## Read power consumption data, where the missing values are coded as "?",
    ## the columns are separated by ";", the first row is the name of columns,
    ## the columns should be read as character, character, numeric, numeric,
    ## numeric, numeric, numeric, numeric, numeric classes
    powerdata <- read.table("household_power_consumption.txt", na.strings="?" , 
                            sep=";", header=TRUE, stringsAsFactors=FALSE,
                            colClasses=c(rep('character', 2), rep('numeric', 7)))
    
    ## Convert Date column read as "character" to Date class
    powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
    
    ## Subset table to get rows where date is equal to 2007-02-01 or 2007-02-02
    data <- powerdata[powerdata$Date == "2007-02-01" | powerdata$Date == "2007-02-02", ]
    
    ## Create png file device with 480x480
    png("plot1.png", width=480, height=480, bg="transparent")
    
    ## Construct the plot 1 using "hist" function
    hist(data$Global_active_power, main = "Global Active power", xlab = "Global Active Power (kilowatts)",
         col = "red")
    
    ## Close PNG file device
    dev.off()
    
}