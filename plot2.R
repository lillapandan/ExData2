setwd("./")
unzip("exdata-data-NEI_data.zip")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Maryland <- NEI[NEI$fips == 24510,]
em <- as.table(tapply(Maryland$Emissions, Maryland$year, sum))

png('plot2.png', width=480, height=480)
plot(em,
     type = "l",
     xlab = "Year",
     ylab = "Emmisions",
     main = "Total PM2.5 Emmisions in Maryland from 1999 to 2008"
)
dev.off()

