# CODE FOR USING OWID DATA SET (they have the same values)
# ---------------------------------------------------------------------------
# load in dataset:
# ---------------------------------------------------------------------------
# OWID_GHG_realworld <- read_OWID_climate_budget()
# ---------------------------------------------------------------------------
# clean dataset for use:
# ---------------------------------------------------------------------------
# OWID_GHG_realworld_filtered <- OWID_GHG_realworld%>%
#   filter(country == "World", 
#          year >= year_range[1])%>%
#   select(year, co2)
# ---------------------------------------------------------------------------
# graphing dataset:
# ---------------------------------------------------------------------------
# line_graph <- ggplot() +
#   geom_line(data=OWID_GHG_realworld_filtered, aes(x=year, y=co2))+
#   geom_line(data=GHG_model_filtered, aes(x=year, y=emissions, color=MODEL))
# ---------------------------------------------------------------------------

# initialize libraries
library("ggplot2")
library("dplyr")
library("reshape2")
library("plotly")

# Clears memory
rm(list = ls())

# Set WD to source file
setwd("C:/Users/liama/Downloads/INFO 201 Workspace/final-project-starter-Coevetive/source")

# Link data_access.R
source("data_access.R")

year_range <- c(2005, 2020)

# Load in data sets
GHG_realworld <- read_global_climate_budget()
GHG_model <- read_IPCC_climate_model()

# Clean real world GHG data set for graphing
GHG_realworld_filtered <- GHG_realworld%>%
  filter(Country == "Global",
         Year >= year_range[1])%>%
  mutate(year = Year, emissions = Total, MODEL = "REAL WORLD")%>%
  select(year, emissions, MODEL)

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
  filter(year <= year_range[2] & year >= year_range[1],
         MODEL == "GEM-E3-ICCS" | MODEL == "IMAGE 2.4" | MODEL == "WITCH_AMPERE")

# combine datasets

GHG_filtered_complete <- bind_rows(GHG_realworld_filtered, GHG_model_filtered)

# NOTE: both of the data set's emissions values are measured in MT/yr of Co2

cols <- c(# GEM-E3-ICCS
          "#1d3557",
          # IMAGE 2.4
          "#457b9d",
          # REAL WORLD
          "#e63946",
          # WITCH_AMPERE
          "#a8dadc")

line_graph <- ggplot(data=GHG_filtered_complete, aes(x=year, y=emissions, color=MODEL)) +
  geom_area(position = "identity", aes(fill=MODEL))+
  geom_line()+
  scale_color_manual(values = cols)+
  scale_fill_manual(values = cols)+
  labs(title = "Real CO2 Emissions vs. Model C02 Emissions", x = "Years", y = "Mt/yr of CO2")

ggplotly(line_graph)

# Specific value questions:

GEM_model_2020_co2_value <- GHG_model_filtered%>%
  filter(year == "2020",
         MODEL == "GEM-E3-ICCS")%>%
  pull(emissions)

IMAGE_model_2020_co2_value <- GHG_model_filtered%>%
  filter(year == "2020",
         MODEL == "IMAGE 2.4")%>%
  pull(emissions)

WITCH_model_2020_co2_value <- GHG_model_filtered%>%
  filter(year == "2020",
         MODEL == "WITCH_AMPERE")%>%
  pull(emissions)

real_world_2020_co2_value <- GHG_realworld_filtered%>%
  filter(year == "2020")%>%
  pull(emissions)

GEM_vs_real_world <- abs(GEM_model_2020_co2_value - real_world_2020_co2_value)

IMAGE_vs_real_world <- abs(IMAGE_model_2020_co2_value - real_world_2020_co2_value)

WITCH_vs_real_world <- abs(WITCH_model_2020_co2_value - real_world_2020_co2_value)
  