library(dplyr)
library(ggplot2)
library(leaflet)
library(plotly)

#setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source")

source("data_access.R")

euroEmissions <- read_Euro_Manufact_Avg_by_Year()
colnames(euroEmissions) <- c('country', 'pollutant', 'reportingYear', 'emissions')


euroC02avgs <- euroEmissions %>%
  filter(pollutant == "Carbon dioxide (CO2)") %>%
  group_by(reportingYear) %>%
  mutate(yoyMeans = mean(emissions, na.rm = TRUE)) %>%
  distinct(yoyMeans)

DecreaseAvg <- (euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2007] - euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2019]) / (nrow(euroC02avgs)-1)
Decrease20192020 <- euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2019] - euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2020]
Diff1920vsAvg <- Decrease20192020 - DecreaseAvg

bar_graph <- plot_ly(
  data = euroC02avgs, 
  x = ~reportingYear,     
  y = ~yoyMeans,
  type = "bar",  
  alpha = .7,   
  hovertext = ~reportingYear 
) %>%
  layout(
    title = "Yearly Average Manufacturing C02 Emissions Across Europe",
    xaxis = list(title = "Year"),
    yaxis = list(title = "Mean C02 Emissions (Kg/year)")
  )

42902802485-36767611598
