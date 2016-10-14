library(data.table)
library(ggplot2)

# read data files
pm25data <- data.table(readRDS("summarySCC_PM25.rds"))
sccdata <- data.table(readRDS("Source_Classification_Code.rds"))

baltimore<-pm25data[fips=='24510',]
LA<-pm25data[fips=='06037',]

# in this code, Motorcycles (MC) is considered as motor vehicles too
# get SCC code of motor vehicles

# mv_SCC<-sccdata[grep("*Motorcycles*|*Vehicle", sccdata$Short.Name),]$SCC
#
# If motorcycle is not condisered as motor vehicles, 
# 
#      mv_SCC<-sccdata[grep("Vehicle", sccdata$Short.Name),]$SCC

# subset motor vehicle related data from baltimore data
#

# mv_baltimore<-baltimore[SCC %in% mv_SCC,]
# use type=="ON-ROAD" for motor vehicles
mv_baltimore<-baltimore[type=="ON-ROAD",]

mv_total_baltimore<-mv_baltimore[,list(Emissions=sum(Emissions)),by=c("year")]

# subset motor vehicle related data from LA data

# mv_LA<-LA[SCC %in% mv_SCC,]
# use type=="ON-ROAD" for motor vehicles
mv_LA<-LA[type=="ON-ROAD",]
mv_total_LA<-mv_LA[,list(Emissions=sum(Emissions)),by=c("year")]

#add new col "city',then merge data

mv_total_baltimore$city<-"Baltimore"
mv_total_LA$city<-"Los Angles County"

mv_two_total<-rbind(mv_total_LA,mv_total_baltimore)

#start plot data

png("plot6.png")
g<-ggplot(data=mv_two_total,aes(year,Emissions))
g<-g+geom_line()+facet_grid(.~city)
g<-g+geom_smooth(method = "lm")
g<-g+labs(title="Total emissions of motor vehicle source in Baltimore and Los Angeles",y="Total emission")

print(g)

dev.off()


mv_baltimore2<-baltimore[type=='ON-ROAD',]

mv_total_baltimore2<-mv_baltimore2[,list(Emissions=sum(Emissions)),by=c("year")]

# subset motor vehicle related data from LA data

mv_LA2<-LA[type=='ON-ROAD',]

mv_total_LA2<-mv_LA2[,list(Emissions=sum(Emissions)),by=c("year")]

#add new col "city',then merge data

mv_total_baltimore2$city<-"Baltimore"
mv_total_LA2$city<-"Los Angles County"

mv_two_total2<-rbind(mv_total_LA2,mv_total_baltimore2)

