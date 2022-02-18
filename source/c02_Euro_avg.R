library(dplyr)
library(ggplot2)
library(leaflet)
library(plotly)

setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source")

source("data_access.R")

euroEmissions <- read_Euro_Manufact_Avg_by_Year()
colnames(euroEmissions) <- c('country', 'pollutant', 'reportingYear', 'emissions')


euroC02avgs <- euroEmissions %>%
  filter(pollutant == "Carbon dioxide (CO2)") %>%
  group_by(reportingYear) %>%
  mutate(yoyMeans = mean(emissions, na.rm = TRUE)) %>%
  distinct(yoyMeans)

Decrease20192020 <- euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2019] - euroC02avgs$yoyMeans[euroC02avgs$reportingYear == 2020]

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

