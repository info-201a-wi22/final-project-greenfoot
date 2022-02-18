library("tidyverse")
library("dplyr")
library("maps")
library("mapproj")
library("patchwork")
library("plotly")

rm(list = ls())

# setwd("C:/Users/ryanf/Desktop/Data Science 201/final-project-starter-Coevetive/source")
setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source")

source("data_access.R")

owid_emissions_data <- read_OWID_country_emission()

owid_emissions_data_2020 <- owid_emissions_data %>%
  filter(year == "2020")%>% 
  select(country, co2)

owid_emissions_data_2020 <- na.omit(owid_emissions_data_2020)%>%
  within(country[country == "United States"] <- "USA")%>%
  within(country[country == "United Kingdom"] <- "UK")
  
country_shape_data <- map_data("world") %>%
  rename(country = region)

owid_emissions_data_2020_w_shape_data <- left_join(country_shape_data, owid_emissions_data_2020, by="country")%>%
  subset(country != "Antarctica")

co2_emissions_map <- ggplot(owid_emissions_data_2020_w_shape_data)+
  geom_polygon(mapping = aes(group = group, x = long, y = lat, fill = co2), color = NA)+
  scale_fill_viridis_c()+
  theme_void() +
  labs(title = "CO2 Emissions in 2020 by Country",
       subtitle = "Million Tons of CO2",
       caption = "Our World In Data, 2021",
       fill = "Mt/yr of CO2")

ggplotly(co2_emissions_map)