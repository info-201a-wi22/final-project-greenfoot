server <- function(input, output) {
  
# ---------------- BAR PLOT -----------------
  
  output$bar_plot <- renderPlotly({
    
    # ---- CO2 Chart ----
    
    if(input$dataSet == 1){
      
      yearlyData <- trimData(euroC02avgs, input$yearSelect)
      
      ggplotly(ggplot(data=yearlyData, aes(x=reportingYear, y=yoyMeans)) +
                 geom_bar(stat="identity", fill="lightblue") + 
                 labs(title = paste("Yearly Average Manufacturing Co2 Emissions Across Europe (", input$yearSelect[1], " - ", input$yearSelect[2], ")", sep = ""),
                      x = "Year",
                      y = "Mean C02 Emissions (Kg/year)"))}  
    
    # ---- Methane Chart ----
    
    else if(input$dataSet == 2){
      
      yearlyData <- trimData(euroMethaneAvgs, input$yearSelect)
      
      ggplotly(ggplot(data=yearlyData, aes(x=reportingYear, y=yoyMeans)) +
                 geom_bar(stat="identity", fill="palegreen3") + 
                 labs(title = paste("Yearly Average Manufacturing Methane Emissions Across Europe (", input$yearSelect[1], " - ", input$yearSelect[2], ")", sep = ""),
                      x = "Year",
                      y = "Mean Methane Emissions (Kg/year)"))}  
    
    # ---- Nitrous Oxide Chart ----    
    
    else if(input$dataSet == 3){
      
      yearlyData <- trimData(euroNitrousAvgs, input$yearSelect)
      
      ggplotly(ggplot(data=yearlyData, aes(x=reportingYear, y=yoyMeans)) +
                 geom_bar(stat="identity", fill="coral2") + 
                 labs(title = paste("Yearly Average Manufacturing Nitrous Oxide Emissions Across Europe (", input$yearSelect[1], " - ", input$yearSelect[2], ")", sep = ""),
                      x = "Year",
                      y = "Mean Nitrous Oxide Emissions (Kg/year)"))}  
  })
  
# ---------------- LINE PLOT -----------------
  
  GHG_realworld <- read.csv("data/global_carbon_budget_data.csv")
  GHG_model <- read.csv("data/IPCC_Climate_Models.csv")
  
  output$line_plot <- renderPlotly({

    # ---------------- Data Cleaning -----------------

    year_range <- c(2005, 2020)
    
    # Clean real world GHG data set for graphing
    GHG_realworld_filtered <- GHG_realworld%>%
      # filter for global data and year range
      filter(Country == "Global",
             Year >= year_range[1])%>%
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
      filter(year <= year_range[2] & year >= year_range[1], MODEL == input$chosen_model1 | MODEL == input$chosen_model2)

    # combine data sets for easier plotting
    GHG_filtered_complete <- bind_rows(GHG_realworld_filtered, GHG_model_filtered)

    # NOTE: both of the data set's emissions values are measured in MT/yr of Co2

    # ---------------- Plotting -----------------

    title <- paste0("Real World CO2 Emissions vs IPCC climate models: ", input$chosen_model1, " and ", input$chosen_model2)

    p <- plot_ly(GHG_filtered_complete, x = ~year, y = ~emissions, type = 'scatter', mode = 'lines', color = ~MODEL)

    p <- p %>% layout(title = title,
                      xaxis = list(title = "Years"),
                      yaxis = list (title = "CO2 in Million Tons"))
  })
  
# ---------------- MAP PLOT -----------------
  
  owid_emissions_data <- read.csv("data/owid-co2-data.csv")
  
  output$map <- renderPlotly({

    # ---------------- Data Cleaning -----------------
    
    owid_emissions_data_filtered <- owid_emissions_data %>%
      filter(year == input$time_var_map_plot)

    # ---------------- Plotting -----------------

    emission_type <- parse(text = input$chosen_emission_type)
    
    if(input$chosen_emission_type == "co2"){
      
      title <- paste0("Global Map of CO2 Emissions in ", input$time_var_map_plot) 
      
    } else if(input$chosen_emission_type == "cement_co2"){
      
      title <- paste0("Global Map of Cement CO2 Emissions in ", input$time_var_map_plot)
      
    } else if(input$chosen_emission_type == "coal_co2"){
      
      title <- paste0("Global Map of Coal CO2 Emissions in ", input$time_var_map_plot)
      
    } else if(input$chosen_emission_type == "flaring_co2"){
      
      title <- paste0("Global Map of Flaring CO2 Emissions in ", input$time_var_map_plot)
      
    } else if(input$chosen_emission_type == "gas_co2"){
      
      title <- paste0("Global Map of Gas CO2 Emissions in ", input$time_var_map_plot)
      
    }
    

    l <- list(color = toRGB("grey"), width = 0.5)

    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    fig <- plot_geo(owid_emissions_data_filtered)
    fig <- fig %>% add_trace(
      z = ~eval(emission_type), color = ~eval(emission_type), colors = 'Blues',
      text = ~country, locations = ~iso_code, marker = list(line = l)
    )
    fig <- fig %>% colorbar(title = 'CO2 Emissions in Million Tons')
    fig <- fig %>% layout(
      title = title,
      geo = g
    )

    fig

  })
  
}

