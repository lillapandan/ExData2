
setwd("/Users/Qi/Downloads/")
unzip("exdata-data-NEI_data.zip")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Maryland <- NEI[NEI$fips == 24510,]

veh <- grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
list <- SCC$SCC[which(SCC$EI.Sector %in% veh)]
dat <- Maryland[Maryland$SCC %in% list,]


em <- as.table(tapply(dat$Emissions, dat$year, sum))

png('plot5.png', width=480, height=480)
plot(em,
     type = "l",
     xlab = "Year",
     ylab = "Emmisions",
     main = "Emissions from motor vehicle sources in Baltimore City"
)

dev.off()