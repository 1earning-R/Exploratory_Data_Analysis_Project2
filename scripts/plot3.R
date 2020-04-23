require(dplyr)
require(ggplot2)

## Read in RDS files if not done previously
if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

## Filter for Baltimore County, keep *type* variable
## Group by Year and type
## Sum over emission sources by year and type
Balt_source <- 
  select(NEI[NEI$fips =="24510",],Year=year,Emissions,type) %>%
  group_by(Year,type) %>%
  summarise(Emissions = sum(Emissions,na.rm = TRUE))

png("plots/plot3.png")

# Plot emissions using facet_grid to separate by type
g <- ggplot(Balt_source,aes(Year,Emissions))
g <- g + 
  coord_cartesian(ylim = c(0,2600))+
  geom_point() + 
  geom_smooth(method="lm",se = TRUE) + 
  facet_grid(type~.) + 
  ggtitle("Yearly Baltimore PM2.5 Emissions by Type") + 
  ylab("Emissions (tons)") +
  theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()