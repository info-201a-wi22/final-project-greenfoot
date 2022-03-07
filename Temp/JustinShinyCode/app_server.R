library(shiny)

a_server <- function(input, output) {
    output$chart1 <- renderPlotly({
      
    

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
}



