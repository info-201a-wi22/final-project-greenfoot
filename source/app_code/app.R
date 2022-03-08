library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
library(reshape2)
library(RColorBrewer)

setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source/app_code")

source("backend/calcs.R")
source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)