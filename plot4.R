library(data.table)
library(ggplot2)

#read data files
pm25data <- data.table(readRDS("summarySCC_PM25.rds"))
sccdata <- data.table(readRDS("Source_Classification_Code.rds"))

#get SCC code of Coal Combustion related source.

scc_comb_coal<-sccdata[grep('.*Comb.*Coal.*', sccdata$Short.Name,),]$SCC

#subset pm2.5 data of coal combustion

pm25data_coal_comb<-pm25data[SCC %in% scc_comb_coal,]

#get the total emissions of coal combustion from 1999-2008

total_coal_comb<-pm25data_coal_comb[,list(Totalemi=sum(Emissions)),by=year]


# plot data
png("plot4.png")
g<-ggplot(data=total_coal_comb,aes(year,Totalemi))
g<-g+geom_line()
g<-g+geom_smooth(method = "lm")
g<-g+labs(title="Total emissions of coal combustion related source",y="Total emission")

print(g)
dev.off()
