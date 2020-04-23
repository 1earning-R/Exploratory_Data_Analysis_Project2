require(dplyr)
require(ggplot2)

## Define a function to calculate percent change from starting value
per_chng <- function(now,start) (now - start) / start

## Read RDS files if they have not been already read by other scripts
if (!exists("NEI")){NEI <- readRDS("rawdata/summarySCC_PM25.rds")}
if (!exists("SCC")){SCC <- readRDS("rawdata/Source_Classification_Code.rds")}

## Restrict our analysis to just LA and Baltimore counties
LA_Balt <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
## Create named factors for LA and Baltimore for easy reading
LA_Balt$County <- factor(as.integer(LA_Balt$fips),labels = c("LA","Baltimore"))

## Restrict our analysis to "ON-ROAD", because we want motor vehicle emissions
## Group by Year and County
## Sum over all emission types, divide by 1000 (marked in ylab)
MV <- 
  select(LA_Balt[LA_Balt$type == "ON-ROAD",], Year=year, Emissions, County) %>%
  group_by(Year, County) %>%
  summarise(Emissions = sum(Emissions)/1000)

## Create a variable for percent change since 1999
MV$per_chng <- sapply(1:dim(MV)[1],temp <- function(n) per_chng(MV$Emissions[n], 
                            MV$Emissions[MV$Year==1999&MV$County==MV$County[n]]))

## Create linear fits for each county: Emissions and percent change
Balt <- MV[MV$County == "Baltimore",]
LA <- MV[MV$County == "LA",]
Balt_raw <- lm(Emissions ~ Year,data = Balt)
LA_raw <- lm(Emissions ~ Year,data = LA)
Balt_chng <- lm(per_chng ~ Year,data = Balt)
LA_chng <- lm(per_chng ~ Year,data = LA)

## Create a color scheme
MV$color <- ""
MV$color[MV$County == "Baltimore"] <- "purple"
MV$color[MV$County == "LA"] <- "goldenrod"

png("plots/plot6.png")

par(mfrow = c(2,1))
## Plot vehicular emissions
plot(MV$Year, MV$Emissions, 
     col = MV$color, 
     ylim = c(0,5),
     xlab = "", 
     ylab = "Emissions (thousands of tons)",
     main = "LA and Baltimore PM2.5 Vehicular Emissions",
     pch = 19)
## Plot linear fits
abline(Balt_raw,
       lwd=2,
       col="purple")
abline(LA_raw,
       lwd=2,
       col="goldenrod")

## Add legend
legend("right",
       legend = c("LA","Baltimore"),
       col = c("goldenrod","purple"),
       pch = 19)

## Plot percent change
plot(MV$Year, 
     MV$per_chng, 
     col = MV$color, 
     ylim = c(-1,1),
     xlab = "Year", 
     ylab = "Percent Change since 1999",
     main = "LA and Baltimore Change in PM2.5 Vehicular Emissions",
     pch = 19)
## Plot linear fits
abline(Balt_chng,
       lwd=2,
       col="purple")
abline(LA_chng,
       lwd=2,
       col="goldenrod")
abline(h=0)
## Add legend
legend("topright",
       legend = c("LA","Baltimore"),
       col = c("goldenrod","purple"),
       pch = 19)

dev.off()