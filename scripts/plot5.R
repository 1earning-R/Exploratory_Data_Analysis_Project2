require(dplyr)
require(ggplot2)

if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

Balt_MV <- 
  select(NEI[NEI$fips =="24510" & NEI$type == "ON-ROAD",],
         Year=year,Emissions) %>%
  group_by(Year) %>%
  summarise(Emissions = sum(Emissions))

png("plots/plot5.png")

g <- ggplot(Balt_MV,aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = FALSE) + 
  ggtitle("Yearly Baltimore PM2.5 Emissions from Motor Vehicles") + 
  ylab("Emissions (tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()