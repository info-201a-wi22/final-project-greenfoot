rm(list = ls())
setwd("C:/Users/ryanf/Desktop/Data Science 201/final-project-starter-Coevetive/source")
source("data_access.R")
owid_emissions_data <- read_OWID_country_emission()


library("tidyverse")
library("dplyr")
library("maps")
library("mapproj")
library("patchwork")


country_shape <- map_data("world") %>%
  rename(country = region)
  
owid_emissions_data_2020 <- merge(owid_emissions_data, country_shape, by="country")

owid_emissions_data_2020 <- owid_emissions_data %>%
  filter(year == "2020")%>% 
  select(country, co2)


blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

co2_emissions_map <- ggplot(owid_emissions_data_2020)+
  geom_polygon(mapping = aes(group = group, x = long, y = lat, fill = co2), color = "gray", size = 0.3)+
  coord_map()+
  scale_fill_continuous(limits = c(0, max(owid_emissions_data_2020$co2)), na.value = "white", low = "yellow", high = "red")+
  blank_theme


print(co2_emissions_map)  

dev.off()
