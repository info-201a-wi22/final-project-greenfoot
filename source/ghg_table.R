library(dplyr)

emissions <- read.csv("C:\\Users\\tomju\\Copy_3_of_ghgp_data_by_year.csv", na.strings = c("", "NA"))

table_2017_sum_of_total_reported_direct_emissions <- emissions %>%
  group_by(State) %>%
  summarize(Emissions_2017=sum(as.numeric(gsub(",", "",X2017.Total.reported.direct.emissions),na.rm=TRUE),na.rm=TRUE))

table_2018_sum_of_total_reported_direct_emissions <- emissions %>%
  group_by(State) %>%
  summarize(Emissions_2018=sum(as.numeric(gsub(",", "",X2018.Total.reported.direct.emissions),na.rm=TRUE),na.rm=TRUE)) 
  
table_2019_sum_of_total_reported_direct_emissions <- emissions %>%
  group_by(State) %>%
  summarize(Emissions_2019=sum(as.numeric(gsub(",", "",X2019.Total.reported.direct.emissions),na.rm=TRUE),na.rm=TRUE)) 

table_2020_sum_of_total_reported_direct_emissions <- emissions %>%
  group_by(State) %>%
  summarize(Emissions_2020=sum(as.numeric(gsub(",", "",X2020.Total.reported.direct.emissions),na.rm=TRUE),na.rm=TRUE)) 

table <- data.frame(table_2020_sum_of_total_reported_direct_emissions, Emissions_2019=table_2019_sum_of_total_reported_direct_emissions$Emissions_2019, Emissions_2018=table_2018_sum_of_total_reported_direct_emissions$Emissions_2018, Emissions_2017=table_2017_sum_of_total_reported_direct_emissions$Emissions_2017)
View(table)

