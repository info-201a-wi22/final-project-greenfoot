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
# rm(list = ls())

# Set WD to source file
# setwd("C:/Users/liama/Downloads/INFO 201 Workspace/final-project-starter-Coevetive/source")
setwd("D:/Downloads/INFO Workspace/final-project-starter-Coevetive/source")

# Link data_access.R
source("data_access.R")

# range of data, max = 2020, min = 1750
year_range <- c(2005, 2020)

# Load in data sets
GHG_realworld <- read_global_climate_budget()
GHG_model <- read_IPCC_climate_model()

# ---------------- Data Cleaning -----------------

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
  filter(year <= year_range[2] & year >= year_range[1],
         MODEL == "GEM-E3-ICCS" | MODEL == "IMAGE 2.4" | MODEL == "WITCH_AMPERE")

# combine data sets for easier plotting
GHG_filtered_complete <- bind_rows(GHG_realworld_filtered, GHG_model_filtered)

# NOTE: both of the data set's emissions values are measured in MT/yr of Co2

# ---------------- Graphing -----------------

# sets colors for graph lines
cols <- c(# GEM-E3-ICCS
          "#a8dadc",
          # IMAGE 2.4
          "#457b9d",
          # REAL WORLD
          "#e63946",
          # WITCH_AMPERE
          "#1d3557")

line_graph <- ggplot(data=GHG_filtered_complete, aes(x=year, y=emissions, color=MODEL))+
  geom_smooth()+
  scale_color_manual(values = cols)+
  labs(title = "Real CO2 Emissions vs. Model CO2 Emissions", 
       x = "Years", 
       y = "Mt/yr of CO2",
       color = "Model/Dataset:",
       subtitle = "Data from 2005 to 2020",
       caption = "Source: Global Carbon Budget and the IPCC")+
  theme_minimal()

ggplotly(line_graph)

# ---------------- Specific value questions -----------------

# single values

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

# differences

GEM_real_world_diff <- abs(GEM_model_2020_co2_value - real_world_2020_co2_value)

IMAGE_real_world_diff <- abs(IMAGE_model_2020_co2_value - real_world_2020_co2_value)

WITCH_real_world_diff <- abs(WITCH_model_2020_co2_value - real_world_2020_co2_value)

# average and difference percent

model_average_2020 <- mean(GEM_model_2020_co2_value, IMAGE_model_2020_co2_value, WITCH_model_2020_co2_value)

model_avg_real_world_diff <- abs(model_average_2020 - real_world_2020_co2_value)

average_percentage_change <- round((model_avg_real_world_diff / model_average_2020) * 100, digits = 2)
# 14.28% decrease in Mt/yr CO2 emissions, 
# when compared to an average of three models.
