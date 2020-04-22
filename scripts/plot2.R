require(dplyr)

if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

Balt_yearly <- 
  select(NEI[NEI$fips =="24510",],year,Emissions) %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

png("plots/plot2.png")

plot(Balt_yearly$year,
     Balt_yearly$Emissions,
     ylab = "Emissions (tons)",
     xlab = "Year",
     main = "Total Baltimore PM2.5 Emissions by Year")

model <- lm(Emissions ~ year, data=Balt_yearly)

abline(model)

dev.off()