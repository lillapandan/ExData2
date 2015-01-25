
setwd("/Users/Qi/Downloads/")
unzip("exdata-data-NEI_data.zip")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Maryland <- NEI[NEI$fips == "24510",]
California <- NEI[NEI$fips == "06037",]


veh <- grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
list <- SCC$SCC[which(SCC$EI.Sector %in% veh)]
dat1 <- Maryland[Maryland$SCC %in% list,]
dat2 <- California[California$SCC %in% list,]

em1 <- as.table(tapply(dat1$Emissions, dat1$year, sum))
em2 <- as.table(tapply(dat2$Emissions, dat2$year, sum))

em1 <- cbind(transform(em1), "Baltimore City")
em2 <- cbind(transform(em2), "Los Angeles County")
names(em1) <- names (em2) <- c("year", "Emissions", "area")
em <- rbind(em1, em2)


library(ggplot2)
png('plot6.png', width=480, height=480)
ggplot( data=em, 
        aes(x=year, y=Emissions)) + 
        geom_line(aes(colour = area, group = area)) + 
        geom_point(aes(colour = area), size = 2) +
        ggtitle("Emissions from motor vehicle sources") + 
        ylab("Emissions") + 
        xlab("Year") +
        theme(
                panel.background = element_rect(fill = 'white')
                ,panel.grid.major = element_blank()
                ,panel.grid.minor = element_blank()
                ,panel.border = element_blank()
                ,axis.line = element_line(color = 'black')
        ) 

dev.off()
