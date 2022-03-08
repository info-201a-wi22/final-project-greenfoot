# ---------------- Shiny Widgets -----------------

# BAR PLOT WIDGETS

time_input_bar_plot <- sliderInput(
  inputId = "yearSelect",
  label = "Select Year",
  min = 2007,
  max = 2020,
  value = c(2007, 2020),
  sep = "",
  ticks = FALSE
)

pollutant_type_input <- radioButtons(inputId ="dataSet",
             label = "Select Pollutant",
             choices = list("CO2" = 1, "Methane (CH4)" = 2, "Nitrous oxide (N2O)" = 3),
             selected = 1)


# LINE PLOT WIDGETS

model1_input <- selectInput(
  "chosen_model1",
  label = "Choose a model: ",
  choices = c("DNE21 V.12", "GCAM 3.0", "GEM-E3-ICCS", "IMACLIM v1.1", "IMAGE 2.4", "MERGE-ETL_2011", "MESSAGE V.4", "POLES AMPERE", "REMIND 1.5", "WITCH_AMPERE", "WorldScan2"),
  selected = "GCAM 3.0"
)

model2_input <- selectInput(
  "chosen_model2",
  label = "Choose a model: ",
  choices = c("DNE21 V.12", "GCAM 3.0", "GEM-E3-ICCS", "IMACLIM v1.1", "IMAGE 2.4", "MERGE-ETL_2011", "MESSAGE V.4", "POLES AMPERE", "REMIND 1.5", "WITCH_AMPERE", "WorldScan2"),
  selected = "GEM-E3-ICCS"
)

# MAP PLOT WIDGETS

time_input_map_plot <- sliderInput(
  "time_var_map_plot",
  label = "Choose year:",
  min = 2000,
  max = 2020,
  value = "2020",
  sep = "",
  ticks = FALSE
)

emission_type_input <- selectInput(
  "chosen_emission_type",
  label = "Choose a emission type: ",
  choices = c("CO2 Emissions" = "co2",
              "Cement CO2 Emissions" = "cement_co2",
              "Coal CO2 Emissions" = "coal_co2",
              "Flaring CO2 Emissions" = "flaring_co2",
              "Gas CO2 Emissions" = "gas_co2"),
  selected = "CO2 Emissions"
)

# ---------------- Shiny Page Layout -----------------

ui <- fluidPage(
  
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
    HTML("Authors: Justin Rhinehart @ jjrhine@uw.edu, Ryan Friesz @ ref7@uw.edu, Tom Jubin @ tomjubin@uw.edu, Liam Dale @ liamdale@uw.edu"),
    hr()
  ),
  
  navbarPage("COVID-19 and GHG Emissions, What Can We Learn?",
    
    # --- INTRO ---
             
    tabPanel("Intro",
    
      p("INTRO WRITING GOES HERE..."),
    
    ),
    
    # --- BAR PLOT ---
    
    tabPanel("Bar Plot",
             
      sidebarLayout(
       
        sidebarPanel(
         
          time_input_bar_plot,
         
          pollutant_type_input,
          
          textOutput("yearSelect")
         
        ),
       
        mainPanel(
         
        plotlyOutput("bar_plot")
         
        )
       
      )       
             
    ),
    
    # --- MAP PLOT ---
    
    tabPanel("Line Plot", 
    
      sidebarLayout(
    
        sidebarPanel(
    
          model1_input,
          
          model2_input
    
        ),
    
        mainPanel(
    
          plotlyOutput("line_plot")
    
        )
    
      )
    
    ),
    
    
    # --- MAP PLOT ---
    
    tabPanel("Map Plot",
    
      sidebarLayout(
    
        sidebarPanel(
    
          time_input_map_plot,
    
          emission_type_input
    
        ),
    
        mainPanel(
    
          plotlyOutput("map"),
          
          verbatimTextOutput("temp")
    
        )
    
      )       
    
    ),
    
    
    # --- SUMMARY ---
    
    tabPanel("Summary",
    
      p("SUMMARY GOES HERE...")
    
    ),
    
    # --- REPORT ---
    
    tabPanel("Report",
    
      p("REPORT GOES HERE...")
    
    )
  )
)