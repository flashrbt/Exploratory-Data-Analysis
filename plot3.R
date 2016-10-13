library(data.table)
library(ggplot2)
pm25data <- readRDS("summarySCC_PM25.rds")

# Here we convert the baltimore data to data table, instead of using tapply(). tapply() resurns a matrix. in order to plot data per type, we have to convert matrix to data table again. 

baltimore<-data.table(subset(pm25data,pm25data$fips=='24510'))

baltimore_total_type <- baltimore[, list(Emissions = sum(Emissions)), by = c('year', 'type')]


# Here I show the code using tapply and gather() to get same data as baltimore_total_type
#baltimore<-subset(NEI,NEI$fips=='24510')
#baltimore_total_type2<-tapply(baltimore$Emissions,list(baltimore$year,baltimore$type),sum)
#year<-as.numeric(rownames(baltimore_total_type2))
#baltimore_total_type2<-cbind(year,baltimore_total_type2)
#baltimore_total_type2<-data.table(baltimore_total_type2)
#library(tidyr)
#baltimore_total_type2<-gather(baltimore_total_type2,type,Emissions, `NON-ROAD`:POINT)
#
#


# start to plot data

png("plot3.png")
g<-ggplot(data=baltimore_total_type,aes(year,Emissions))
g<-g+geom_line()+facet_grid(.~type)+geom_smooth(method = "lm")
g<-g+labs(title="Total emission of different type",y="Total emissions")
print(g)

dev.off()
