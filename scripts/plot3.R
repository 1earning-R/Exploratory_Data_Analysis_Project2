require(dplyr)
require(ggplot2)

if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

Balt_source <- 
  select(NEI[NEI$fips =="24510",],Year=year,Emissions,type) %>%
  group_by(Year,type) %>%
  summarise(Emissions = sum(Emissions))

png("plots/plot3.png")

g <- ggplot(Balt_source,aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = FALSE) + 
  facet_grid(type~.) + 
  ggtitle("Yearly Baltimore PM2.5 Emissions by Type") + 
  ylab("Emissions (tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()