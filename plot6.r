library(dplyr)
library(ggplot2)

#downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

##6. Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California (fips == "06037").
##Which city has seen greater changes over time in motor vehicle emissions?

#Select on-road  motor vehicles
VehicleOnroad <- subset(SCC, grepl("vehicle",EI.Sector,ignore.case=TRUE) & grepl("on-road",EI.Sector,ignore.case=TRUE))
#merge by SCC so only selecting from 'motor vehicles'
VehicleSCC <- merge(NEI,VehicleOnroad,by="SCC")
## select only Los Angeles location
LAOnly <- filter(VehicleSCC,fips=="06037") 
## select only Baltimore location
BaltimoreOnly <- filter(VehicleSCC,fips=="24510") 
#########################

#aggregate for total emission by year for LA vs Balt
BaltVehicleSCCsum <- aggregate(Emissions~year,BaltimoreOnly,sum)
names(BaltVehicleSCCsum)[2] <- "Baltimore"
LAVehicleSCCsum <- aggregate(Emissions~year,LAOnly,sum)
names(LAVehicleSCCsum)[2] <- "LA"
VehicleCombo <-merge(BaltVehicleSCCsum,LAVehicleSCCsum, by ="year")
###############
library(tidyr)
## rearrange so that LA and Baltimore are gathered into vector named 'location'
VehicleCombo <- VehicleCombo %>% 
  gather(Location, Emissions, 2:3)

################ plot data
ggplot(VehicleCombo,aes(x=factor(year),y=Emissions,fill=Location))+
  geom_bar(stat="identity",position="dodge")+
  labs(title =expression("Motor Vehicle  Sources of PM"[2.5]*" Baltimore vs. Emissions by Year "), 
      x= "YEAR", y=expression("Total PM"[2.5]*" Emission (Tons)"))
  
  
##Create plot in .png format
dev.copy(png, file = "plot6.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!