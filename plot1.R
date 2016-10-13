# read data from rdf file
pm25data <- readRDS("summarySCC_PM25.rds")

#using tapply() function to calculate the sum of Emissions
totalemissions<-tapply(pm25data$Emissions,pm25data$year,sum)


#x-axis data
x_total<-as.numeric(names(totalemissions))


#start plot data

png("plot1.png")
plot(x_total,totalemissions,xlab = "Year",ylab="Total emission",col="red")
lines(x_total,totalemissions,col="blue")
title(main="Total emissions")
dev.off()
