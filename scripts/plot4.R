require(dplyr)
require(ggplot2)

## Read in RDS files if not done previously
if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

## Search SCC for "Coal" or "coal" in short name
coal <- SCC[grep("[Cc]oal",SCC$Short.Name),]
## Further filter for "Fuel Combustion" in EI.Sector
coal_comb <- coal[grep("[Ff]uel [Cc]omb",coal$EI.Sector),"SCC"]

## Select relevant variables
## Group by Year
## Sum over all emission sources
coal_yearly <-  
  select(NEI[NEI$SCC %in% coal_comb,],Year=year,Emissions,type) %>%
  group_by(Year) %>%
  summarise(Emissions = sum(Emissions)/1000)

png("plots/plot4.png")

## Plot coal combustion emissions
g <- ggplot(coal_yearly,aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = TRUE) + 
  ggtitle("Yearly PM2.5 Emissions Due to Coal Fuel Combustion") + 
  ylab("Emissions (thousands of tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()