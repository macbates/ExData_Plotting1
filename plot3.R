#
# Coursera EDA course project 1 - plot3.R
#

#
# Since the data file is so large and the project uses only a small subset, a subset of the main file
# will be used. If it does not exist, the large file will be read in, subset appropriately, and the
# subset written out. This code is duplicated for all 4 exercises (plot1.R through plot4.R).
# Note that the original data file must be in the same directory as this code.
#

fileName <- "subset_data"
# If the subset file is already there, just read it in
if (file.exists(fileName)) load(fileName) else {
  
  # No file, so we have to read in the full one and create a subset
  message("Reading full data and subsetting, please wait...")
  full <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                     colClasses = c(rep("character", 2), rep("numeric", 7)))
  
  # Construct a POSIX date from the (European) date and time fields
  full$newDate <- strptime(paste(full$Date, full$Time), "%d/%m/%Y %H:%M:%S")
  loDate <- strptime("2007-02-01", "%Y-%m-%d")
  hiDate <- strptime("2007-02-03", "%Y-%m-%d")
  d <- subset(full, full$newDate >= loDate & full$newDate < hiDate)
  save(d, file=fileName)
}

# Arrive here with data frame 'd' loaded with the correct dates (d$newDate), so now we can do the plot
png(filename = "plot3.png")
plot(d$newDate, d$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(d$newDate, d$Sub_metering_2, col = "red")
lines(d$newDate, d$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()
