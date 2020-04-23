require(dplyr)
require(ggplot2)

## Read in RDS files if not done previously
if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

## Select for Baltimore and "ON-ROAD" since those will be vehicular emissions
## Group by year
## Sum over all sources of emissions
Balt_MV <- 
  select(NEI[NEI$fips =="24510" & NEI$type == "ON-ROAD",],
         Year=year,Emissions) %>%
  group_by(Year) %>%
  summarise(Emissions = sum(Emissions))

png("plots/plot5.png")

##Plot Emissions
g <- ggplot(Balt_MV,aes(Year,Emissions))
g <- g + 
  geom_point() + 
  geom_smooth(method="lm",se = TRUE) + 
  ggtitle("Yearly Baltimore PM2.5 Emissions from Motor Vehicles") + 
  ylab("Emissions (tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()