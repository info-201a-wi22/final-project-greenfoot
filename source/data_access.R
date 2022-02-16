# Example: Project Data Access Functions  ----
#----------------------------------------------------------------------------#
# These functions are used to access data sources ... 
#----------------------------------------------------------------------------#
read_global_climate_budget <- function () {
  filepath <- "../data/GLOBAL_CLIMATE_BUDGET/global_carbon_budget_data.csv"
  df <- read.csv(filepath)
  return(df)
}

read_IPCC_climate_model <- function () {
  filepath <- "../data/IPCC_CLIMATE_MODELS/IPCC_Climate_Models.csv"
  df <- read.csv(filepath)
  return(df)
}

read_OWID_climate_budget <- function () {
  filepath <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
  df <- read.csv(filepath)
  return(df)
}
