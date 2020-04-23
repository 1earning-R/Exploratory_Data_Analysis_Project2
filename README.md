# Exploratory_Data_Analysis_Project2
#### Second Project for the Class "Exploratory Data Analysis"

------------------------------------------------------

## The Assignment
The purpose of this assignment is to practice creating plots in R that can answer specific questions regarding the data.

These are six questions provided as prompts:

1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the **base plotting system**, make a plot showing the *total* PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the **base plotting system** to make a plot answering this question.

3 Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

4 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

## The Data
The data for this project come from the [National Emissions Inventory](http://www.epa.gov/ttn/chief/eiinformation.html) which publishes public data on a variety of air quality indicators from around the country. This project focuses on the air pollutant known as *fine particulate matter* with the abbreviation PM<sub>2.5</sub>. The 2.5 denotes that these airborne particles has a diameter of less than 2.5 microns (for reference, a human hair is roughly 50 microns across).<sup>[1](#footnote1)</sup> Long-term exposure to PM<sub>2.5</sub> is correlated with increased risks of a spectrum of diseases especially cardiovascular disease.<sup>[2](#footnote2)</sup> Recently, it has been shown that it may contribute to the mortality of COVID-19<sup>[3](#footnote3)</sup>

The [data provided](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) contain 6.5 million observations over six variables: **year**, **fips**, **SCC**, **Pollutant**, **Emissions**, **type**. Years of observations are 1999, 2002, 2005, and 2008. The variable **fips** is a 5 digit county code. **SCC** is an identification code that matches the emission to a particular source in accompanying data file. An in-depth explanation of the **SCC** classifications is available [here](https://ofmpub.epa.gov/sccwebservices/sccsearch/docs/SCC-IntroToSCCs.pdf). **Pollutant** is *PM25* for all observations as this is the relevant pollutant for this project. **Emissions** is an estimate of emissions from the *SCC* source in that year, and **type** is one of four character strings: *ON-ROAD*, referring to motor vehicles; *NON-ROAD*, referring to other vehicles; *POINT*, which are large, single sources such as factories or power plants; *NON-POINT*, which are emissions from smaller, distributed sources such as residential heating or road construction or maintenance.<sup>[4](#footnote4)</sup>

-----------------------------------------------------------
##### Footnotes
<a name=footnote1>1</a>: [*Particulate Matter (PM) Pollution; EPA*](https://www.epa.gov/pm-pollution/particulate-matter-pm-basics)

<a name=footnote2>2</a>: [*Health and Environmental Effects of Particulate Matter (PM); EPA*](https://www.epa.gov/pm-pollution/health-and-environmental-effects-particulate-matter-pm)

<a name=footnote3>3</a>: [*Wu, et al.; A national study on long-term exposure to air pollution and COVID-19 mortality in the United States; Harvard University*](https://projects.iq.harvard.edu/covid-pm/home)

<a name=footnote4>4</a>: [*National Emissions Inventory, EPA*](https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei)