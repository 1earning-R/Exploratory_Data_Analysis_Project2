require(dplyr)

## Read in RDS files if not done previously
if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

## Filter to relevant data: year, Emissions
## Group by year
## Sum over all emission sources
total_yearly <- select(NEI,year,Emissions) %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions)/1000000)

png("plots/plot1.png")

# Plot emissions
plot(total_yearly$year,
     total_yearly$Emissions,
     ylab = "Emissions (millions of tons)",
     xlab = "Year",
     main = "Total PM2.5 Emissions by Year")

## Fit linear model
model <- lm(Emissions ~ year, data=total_yearly)

## Plot linear model
abline(model)

dev.off()