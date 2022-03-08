library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(RColorBrewer)
library(reshape2)

setwd("C:/Users/liama/Downloads/INFO 201 Workspace/final-project-starter-Coevetive/source")

source("data_access.R")

# Load in data sets
GHG_realworld <- read_global_climate_budget()
GHG_model <- read_IPCC_climate_model()

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)