library(data.table)
library(ggplot2)

#read data files
pm25data <- data.table(readRDS("summarySCC_PM25.rds"))
sccdata <- data.table(readRDS("Source_Classification_Code.rds"))

baltimore<-pm25data[fips=='24510',]

# in this code, Motorcycles (MC) is considered as motor vehicles too
# get SCC code of motor vehicles

mv_SCC<-sccdata[grep("*Motorcycles*|*Vehicles", sccdata$Short.Name),]$SCC

# subset motor vehicle related data from baltimore data
#

mv_baltimore<-baltimore[SCC %in% mv_SCC,]

mv_total_baltimore<-mv_baltimore[,list(Emissions=sum(Emissions)),by=year]

#start plot data

png("plot5.png")
g<-ggplot(data=mv_total_baltimore,aes(year,Emissions))
g<-g+geom_line()
g<-g+geom_smooth(method = "lm")
g<-g+labs(title="Total emissions of motor vehicle source in Baltimore",y="Total emission")

print(g)

dev.off()

