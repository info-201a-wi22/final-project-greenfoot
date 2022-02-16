# initialize libraries
library("tidyverse")
library("dplyr")
library("reshape2")
library("plotly")

# Clears memory
rm(list = ls())

# Set WD to source file
setwd("C:/Users/liama/Downloads/INFO 201 Workspace/final-project-starter-Coevetive/source")

# Link data_access.R
source("data_access.R")

# Load in data sets
GHG_realworld <- read_global_climate_budget()
GHG_model <- read_IPCC_climate_model()

# Clean real world GHG data set for graphing
GHG_realworld_filtered <- GHG_realworld%>%
  filter(Country == "Global",
         Year >= 2005)%>%
  mutate(year = Year, emissions = Total)%>%
  select(year, emissions)

# Clean model GHG data set for graphing
GHG_model_filtered <- GHG_model%>%
  filter(REGION == "World",
         VARIABLE == "Emissions|CO2",
         SCENARIO == "AMPERE3-Base")%>%
  melt(id.vars=c("MODEL", "SCENARIO", "REGION", "VARIABLE", "UNIT"))%>%
  mutate(year = variable, emissions = value)%>%
  select(MODEL, year, emissions)

GHG_model_filtered$year <- as.integer(gsub("X", "", GHG_model_filtered$year))

GHG_model_filtered <- GHG_model_filtered%>%
  filter(year <= "2020")%>%
         MODEL == "GEM-E3-ICCS" |
         MODEL == "IMAGE 2.4" |
         MODEL == "WITCH_AMPERE"

line_graph <- ggplot() +
  geom_line(data=GHG_realworld_filtered, aes(x=year, y=emissions))+
  geom_line(data=GHG_model_filtered, aes(x=year, y=emissions, color=MODEL))

ggplotly(line_graph)
