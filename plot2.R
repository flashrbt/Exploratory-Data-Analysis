
# read data from rdf file
pm25data <- readRDS("summarySCC_PM25.rds")

#totalemissions<-tapply(pm25data$Emissions,pm25data$year,sum)

baltimore<-subset(pm25data,pm25data$fips=='24510')

baltimore_total<-tapply(baltimore$Emissions,baltimore$year,sum)

#start plot data
png("plot2.png")
plot(as.numeric(names(baltimore_total)),baltimore_total,xlab = "Year",ylab="Total emission in Baltimore",type = "b",col="blue")

title(main = "Total PM2.5 emission in Baltimore")

dev.off()
