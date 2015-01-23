library(dplyr)
library(ggplot2)

##downloaded file from assignment page "Data for Peer Assessment [29Mb]" to directory below

setwd("C:/Users/jb/Documents/Analytics course/coursera Exploratory Data Analysis/project 2/data")
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

# Across the United States, how have emissions from coal
# combustion-related sources changed from 1999–2008?
#plot4 
# search SCC$Level.One for "coal" .AND. "comb"(combustion) from Level.Four and merging resulting SCC codes from NEI datatable
CoalandCombust <- subset(SCC, grepl("comb",SCC.Level.One,ignore.case=TRUE) & grepl("coal",SCC.Level.Four,ignore.case=TRUE))
#pick out SCC number ans Short.NAme only
coalSCC <- select(CoalandCombust,SCC,Short.Name)
## merge based on only SCC numbers that combined coal and combustion
NEICoalCombust <- merge(NEI,CoalandCombust,by="SCC")
#aggregate for total emission by year
NEICoalCombsum <- aggregate(Emissions~year,NEICoalCombust,sum)

## chart data
qplot(factor(year), Emissions/100000,data=NEICoalCombsum)+
geom_bar(stat="identity")+ 
  labs(title =expression("Coal Combustion Sources of PM"[2.5]*" Total U.S. Emissions by Year "), 
  x= "YEAR", y=expression("Total PM"[2.5]*" Emission (100,000 Tons)"))

##Create plot in .png format
dev.copy(png, file = "plot4.png",width = 480, height = 480, units = "px") 
dev.off()  ## Don't forget to close the PNG device!
