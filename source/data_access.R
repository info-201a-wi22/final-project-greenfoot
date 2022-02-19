# Example: Project Data Access Functions  ----
#----------------------------------------------------------------------------#
# These functions are used to access data sources ...
#----------------------------------------------------------------------------#
read_global_climate_budget <- function () {
  filepath <- "../data/global_carbon_budget_data.csv"
  df <- read.csv(filepath)
  return(df)
}

read_IPCC_climate_model <- function () {
  filepath <- "../data/IPCC_Climate_Models.csv"
  df <- read.csv(filepath)
  return(df)
}


read_OWID_country_emission <- function () {
  filepath  <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
  df <- read.csv(filepath)
  return(df)
}

read_GHGP_data_by_year <- function () {
  filepath <- "../data/GHG_data_by_year.csv"
  df <- read.csv(filepath, na.strings = c("", "NA"))
  return(df)
}

read_Euro_Manufact_Avg_by_Year <- function () {
  filepath <- "../data/F1_1_TotalReleasesAtNationalLevelIntoAir.csv"
  df <- read.csv(filepath)
  return(df)
}
