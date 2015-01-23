library(dplyr)


##downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))


# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.
#PLOT2
# subset of NEI for Baltimore
BaltimoreOnly <- filter(NEI,fips=="24510") 
#sum of Emissions by year for Balt.
BaltEmYrly<-  aggregate(Emissions ~ year,BaltimoreOnly,sum) 

barplot(
  BaltEmYrly$Emissions/10^3,names.arg=BaltEmYrly$year,
  main="Total PM 2.5 Baltimore Emissions by Year",col = "gray",
  ylab= "Emissions (1000 tons)",
  xlab = "YEAR"
)
##Create plot in .png format
dev.copy(png, file = "plot2.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!