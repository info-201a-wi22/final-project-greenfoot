library(shiny)

source("tabs/tabPanVisual.R")

ui <- navbarPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styling.css")
  ),
  
  title = "European Greenhouse Gas Emissions",
  position = "fixed-top",
  
  header = list(
    tags$style(type = "text/css", "body {padding-top: 50px;}", "body {padding-left: 10px;}"),
    hr(),
    hr()
    ),
  
  footer = list(
    tags$style(type = "text/css", "body {padding-top: 50px;}", "body {padding-left: 10px;}"),
    hr(),
    HTML("Author: put finalized info here"),
    hr()
  ),
  
  tabPanVisual
  
  
)


