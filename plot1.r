library(dplyr)


##downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

# Have total emissions from PM2.5 decreased in the United States from
# 1999 to 2008? Using the base plotting system, make a plot showing
# the total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.
# PLOT1
YearlyEmissions<- aggregate(Emissions~year,NEI, sum)

barplot(
  YearlyEmissions$Emissions/10^6,names.arg=YearlyEmissions$year,
  main="Total PM 2.5 Emissions by Year",col = "gray",
  ylab= "Emissions (100,000 tons)",
  xlab = "YEAR"
)
##Create plot in .png format
dev.copy(png, file = "plot1.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!
