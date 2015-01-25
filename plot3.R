setwd("/Users/Qi/Downloads/")
unzip("exdata-data-NEI_data.zip")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Maryland <- NEI[NEI$fips == 24510,]

Maryland$type <- as.factor(Maryland$type)

type <- split(Maryland, Maryland$type)

p <- NULL
yr <- c("1999", "2000", "2005", "2008")
for (i in 1:4){
        p[[i]] <- tapply(type[[i]]$Emissions, type[[i]]$year, sum)
        p[[i]] <- cbind(transform(p[[i]]), yr, unique(type[[i]]$type))
        
}

dat <- rbind(p[[1]],p[[2]],p[[3]],p[[4]])

names(dat) <- c("Emissions", "year", "type")





library(ggplot2)
png('plot3.png', width=480, height=480)
ggplot( data=dat, 
        aes(x=year, y=Emissions)) + 
        geom_line(aes(colour = type, group = type)) + 
        geom_point(aes(colour = type), size = 2) +
        ggtitle("Total PM2.5 Emmisions for Baltimore City") + 
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
