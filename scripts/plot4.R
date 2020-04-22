require(dplyr)
require(ggplot2)

if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

coal <- SCC[grep("[Cc]oal",SCC$Short.Name),]
coal_comb <- coal[grep("[Ff]uel [Cc]omb",coal$EI.Sector),"SCC"]

coal_yearly <-  
  select(NEI[NEI$SCC %in% coal_comb,],Year=year,Emissions,type) %>%
  group_by(Year) %>%
  summarise(Emissions = sum(Emissions)/1000)

png("plots/plot4.png")

g <- ggplot(coal_yearly,aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = FALSE) + 
#  facet_grid(type~.) + 
  ggtitle("Yearly PM2.5 Emissions Due to Coal Fuel Combustion") + 
  ylab("Emissions (thousands of tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()