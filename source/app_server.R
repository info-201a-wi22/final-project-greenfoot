server <- function(input, output) {
  
# ---------------- LINE PLOT -----------------
  
  output$line_plot <- renderPlotly({

    # ---------------- Data Cleaning -----------------

    # Clean real world GHG data set for graphing
    GHG_realworld_filtered <- GHG_realworld%>%
      # filter for global data and year range
      filter(Country == "Global",
             Year >= input$time_var_line_plot[1])%>%
      # rename and create new columns for easier plotting
      mutate(year = Year, emissions = Total, MODEL = "REAL WORLD")%>%
      # clean out unneeded data
      select(year, emissions, MODEL)

    # Clean model GHG data set for graphing
    GHG_model_filtered <- GHG_model%>%
      # filters for REGION, VARIABLE, and SCENARIO
      filter(REGION == "World",
             VARIABLE == "Emissions|CO2",
             SCENARIO == "AMPERE3-Base")%>%
      # 'melts' off the year values for easy plotting
      melt(id.vars=c("MODEL", "SCENARIO", "REGION", "VARIABLE", "UNIT"))%>%
      # rename columns for easier reference
      rename(year = variable, emissions = value)%>%
      # clean out unneeded data
      select(MODEL, year, emissions)

    # fix variable type and formatting for year columns
    GHG_model_filtered$year <- as.integer(gsub("X", "", GHG_model_filtered$year))

    # grab year range and specific models
    GHG_model_filtered <- GHG_model_filtered%>%
      filter(year <= input$time_var_line_plot[2] & year >= input$time_var_line_plot[1], MODEL == input$chosen_model)

    # combine data sets for easier plotting
    GHG_filtered_complete <- bind_rows(GHG_realworld_filtered, GHG_model_filtered)

    # NOTE: both of the data set's emissions values are measured in MT/yr of Co2

    # ---------------- Plotting -----------------

    title <- paste0("TITLE GOES HERE")

    p <- plot_ly(GHG_filtered_complete, x = ~year, y = ~emissions, type = 'scatter', mode = 'lines', color = ~MODEL)

    p <- p %>% layout(title = title,
                      xaxis = list(title = "Years"),
                      yaxis = list (title = "CO2 in Million Tons"))
  })
  
# ---------------- MAP PLOT -----------------
  
  output$map <- renderPlotly({

    # ---------------- Data Cleaning -----------------

    owid_emissions_data <- read_OWID_country_emission()
    
    owid_emissions_data_filtered <- owid_emissions_data %>%
      filter(year == input$time_var_map_plot) %>% 
      rename(emission_type = input$chosen_emission_type)

    # ---------------- Plotting -----------------

    title <- paste0("Global Map of ", input$chosen_emission_type, " in ", input$time_var_map_plot)

    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    fig <- plot_geo(owid_emissions_data_filtered)
    fig <- fig %>% add_trace(
      z = emission_type, color = emission_type, colors = 'Blues',
      text = ~country, locations = ~iso_code, marker = list(line = l),
    )
    fig <- fig %>% colorbar(title = 'CO2 Emissions')
    fig <- fig %>% layout(
      title = title,
      geo = g
    )

    fig

  })
  
}

