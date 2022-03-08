# ---------------- Shiny Widgets -----------------

time_input_line_plot <- sliderInput(
  "time_var_line_plot",
  label = "Date Range:",
  min = 2005, 
  max = 2100,
  value = c(2005, 2100),
  sep = "",
  ticks = FALSE
)

model_input <- selectInput(
  "chosen_model",
  label = "Choose a model: ",
  choices = c("DNE21 V.12", "GCAM 3.0", "GEM-E3-ICCS", "IMACLIM v1.1", "IMAGE 2.4", "MERGE-ETL_2011", "MESSAGE V.4", "POLES AMPERE", "REMIND 1.5", "WITCH_AMPERE", "WorldScan2"),
  selected = "GCAM 3.0"
)

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
              "Gas CO2 Emissions" = "gas_co2",
              "CO2 Emissions / GDP Ratio" = "co2_per_gdp",
              "Cumulative CO2 Emissions" = "cumulative_co2"),
  selected = "CO2 Emissions"
)

# ---------------- Shiny Page Layout -----------------

ui <- fluidPage(
  
  navbarPage("COVID-19 and GHG Emissions, What Can We Learn?",
    
    tabPanel("Intro",
    
      p("INTRO WRITING GOES HERE..."),
    
    ),
    
    tabPanel("Line Plot", 
    
      sidebarLayout(
    
        sidebarPanel(
    
          time_input_line_plot,
    
          model_input
    
        ),
    
        mainPanel(
    
          plotlyOutput("line_plot")
    
        )
    
      )
    
    ),
    
    tabPanel("Map Plot",
    
      sidebarLayout(
    
        sidebarPanel(
    
          time_input_map_plot,
    
          emission_type_input
    
        ),
    
        mainPanel(
    
          plotlyOutput("map")
    
        )
    
      )       
    
    ),
    
    tabPanel("Summary",
    
      p("SUMMARY GOES HERE...")
    
    ),
    
    tabPanel("Report",
    
      p("REPORT GOES HERE...")
    
    )
  )
)