library(dplyr)
library(ggplot2)

##downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

# Of the four types of sources indicated by the type (point, nonpoint,
# onroad, nonroad) variable, which of these four sources have seen
# decreases in emissions from 1999–2008 for Baltimore City? Which have
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting
# system to make a plot answer this question.
# PLOT3

balt <- filter(NEI,fips=="24510") ## select only Baltimore location

qplot(factor(year),Emissions,data=balt,facets=type~.) + 
  geom_bar(stat="identity")+ 
  labs(title =expression("Baltimore PM"[2.5]*" Emissions by Year for the Four Sources"), 
       x= "YEAR", y=expression("Total PM"[2.5]*" Emission (Tons)"))

##Create plot in .png format
dev.copy(png, file = "plot3.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!
