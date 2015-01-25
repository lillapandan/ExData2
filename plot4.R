
setwd("/Users/Qi/Downloads/")
unzip("exdata-data-NEI_data.zip")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- grep("Coal", SCC$EI.Sector[i], value = T, ignore.case = T)
list <- SCC$SCC[which(SCC$EI.Sector %in% coal)]
dat <- NEI[NEI$SCC %in% list,]


em <- as.table(tapply(dat$Emissions, dat$year, sum))

png('plot4.png', width=480, height=480)
plot(em,
     type = "l",
     xlab = "Year",
     ylab = "Emmisions",
     main = "Emissions from coal combustion-related sources"
)

dev.off()