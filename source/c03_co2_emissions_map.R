# initialize libraries
library("tidyverse")
library("dplyr")
library("maps")
library("mapproj")
library("patchwork")
library("plotly")

# Clears memory
# rm(list = ls())

# Set WD to source file
# setwd("C:/Users/ryanf/Desktop/Data Science 201/final-project-starter-Coevetive/source")
setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source")

# Link data_access.R
source("data_access.R")

# Load in data sets
owid_emissions_data <- read_OWID_country_emission()

# CLEANING!

owid_emissions_data_2020 <- owid_emissions_data %>%
  filter(year == "2020")%>% 
  select(country, co2)

owid_emissions_data_2020 <- na.omit(owid_emissions_data_2020)%>%
  within(country[country == "United States"] <- "USA")%>%
  within(country[country == "United Kingdom"] <- "UK")%>%
  within(country[country == "Democratic Republic of Congo"] <- "Democratic Republic of the Congo")%>%
  within(country[country == "Congo"] <- "Republic of Congo")%>%
  within(country[country == "Cote d'Ivoire"] <- "Ivory Coast")%>%
  within(country[country == "Czechia"] <- "Czech Republic")

  
  
  
country_shape_data <- map_data("world") %>%
  rename(country = region)

owid_emissions_data_2020_w_shape_data <- left_join(country_shape_data, owid_emissions_data_2020, by="country")%>%
  subset(country != "Antarctica")

# CHARTS!

co2_emissions_map <- ggplot(owid_emissions_data_2020_w_shape_data)+
  geom_polygon(mapping = aes(group = group, x = long, y = lat, fill = co2), color = NA)+
  scale_fill_continuous(low = "#caf0f8", high = "#03045e")+
  theme_void() +
  labs(title = "CO2 Emissions in 2020 by Country",
       subtitle = "Million Metric Tons of CO2",
       caption = "Our World In Data, 2021",
       fill = "MMT/yr of CO2")

ggplotly(co2_emissions_map)

##Significant Figures
German_co2_2020 <- owid_emissions_data_2020 %>%
  filter(country == "Germany")%>%
  pull(co2)

Brazil_co2_2020 <- owid_emissions_data_2020 %>%
  filter(country == "Brazil")%>%
  pull(co2)

Venezuela_co2_2020 <- owid_emissions_data_2020 %>%
  filter(country == "Venezuela") %>%
  pull(co2)