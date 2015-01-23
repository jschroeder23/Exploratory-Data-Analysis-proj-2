library(dplyr)
library(ggplot2)

##downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

##5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
 

#Select on-road vehicles
VehicleOnroad <- subset(SCC, grepl("vehicle",EI.Sector,ignore.case=TRUE) & grepl("on-road",EI.Sector,ignore.case=TRUE))
#merge by SCC
VehicleSCC <- merge(NEI,VehicleOnroad,by="SCC")
## select only Baltimore location
BaltimoreOnly <- filter(VehicleSCC,fips=="24510") 
#aggregate for total emission by year
VehicleSCCsum <- aggregate(Emissions~year,BaltimoreOnly,sum)

########################################################
## plot data
qplot(factor(year), Emissions,data=VehicleSCCsum)+
  geom_bar(stat="identity")+ 
  labs(title =expression("Motor Vehicle  Sources of PM"[2.5]*" Baltimore Emissions by Year "), 
       x= "YEAR", y=expression("Total PM"[2.5]*" Emission (Tons)"))

##Create plot in .png format
dev.copy(png, file = "plot5.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!