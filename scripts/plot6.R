require(dplyr)
require(ggplot2)

if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

LA_Balt <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
LA_Balt$County <- factor(as.integer(LA_Balt$fips),labels = c("LA","Baltimore"))

LA_Balt_MV <- 
  select(LA_Balt[LA_Balt$type == "ON-ROAD",], Year=year, Emissions, County) %>%
  group_by(Year, County) %>%
  summarise(Emissions = sum(Emissions)/1000)

png("plots/plot6.png")

g <- ggplot(LA_Balt_MV, aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = FALSE) + 
  facet_grid(County~.)+
  ggtitle("Baltimore and LA Counties: PM2.5 Emissions from Motor Vehicles") + 
  ylab("Emissions (thousands of tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()