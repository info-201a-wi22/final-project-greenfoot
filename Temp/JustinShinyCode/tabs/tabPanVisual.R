library(shiny)

source("app_server.R")

tabPanVisual <- tabPanel(
  "Data Visualization",
  sidebarLayout(
    position = "left",
    sidebarPanel(
        h2("Data Select"),
        radioButtons(inputId ="dataSet",
                     label = "Select Polutant",
                     choices = list("CO2" = 1, "Methane (CH4)" = 2, "Nitrous oxide (N2O)" = 3),
                     selected = 1),
        
        
        
        
        sliderInput(
          inputId = "yearSelect",
          label = "Select Year",
          min = 2007,
          max = 2020,
          value = c(2007, 2020)
        ),
        textOutput(outputId = "yearSelect")
    ),
  mainPanel(
    plotlyOutput(outputId = "chart1"),
    p("Space for text here, do what you want with this.")    
  )
  )
  
)