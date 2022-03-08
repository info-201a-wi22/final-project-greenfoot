euroEmissions <- read.csv("data/F1_1_TotalReleasesAtNationalLevelIntoAir.csv")

colnames(euroEmissions) <- c('country', 'pollutant', 'reportingYear', 'emissions')


# ---- Average yearly CO2 -------------------------------------

euroC02avgs <- euroEmissions %>%
  filter(pollutant == "Carbon dioxide (CO2)") %>%
  group_by(reportingYear) %>%
  mutate(yoyMeans = mean(emissions, na.rm = TRUE)) %>%
  distinct(yoyMeans)

# --- Average yearly Methane -------------------------------------

euroMethaneAvgs <- euroEmissions %>%
  filter(pollutant == "Methane (CH4)") %>%
  group_by(reportingYear) %>%
  mutate(yoyMeans = mean(emissions, na.rm = TRUE)) %>%
  distinct(yoyMeans)

# ---- Average yearly Nitrous -------------------------------------

euroNitrousAvgs <- euroEmissions %>%
  filter(pollutant == "Nitrous oxide (N2O)") %>%
  group_by(reportingYear) %>%
  mutate(yoyMeans = mean(emissions, na.rm = TRUE)) %>%
  distinct(yoyMeans)

# ---- Functions -------------------------------------
trimData <- function(table, yearVal) {
  x <- table
  x <- x %>% filter(reportingYear >= yearVal[1] & reportingYear <= yearVal[2])
  return(x)
}