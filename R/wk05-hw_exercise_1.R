##########################################################
##########    R for EnvSci - wk05 assignment    ##########
##########             01_weather data          ##########
##########################################################


# Load required packages --------------------------------------------------

library(tidyverse)
library(janitor) 


# Data input --------------------------------------------------------------

weather_original <- read_csv("data/weather.csv", skip = 25)


# Data clean-up ---------------------------------------------------------

weather <- weather_original %>% 
  clean_names()

glimpse(weather)  


# Data exploration and summaries ------------------------------------------

# Need to create:
# monthly_max: max of daily max
# monthly_min: min of daily min
# monthly_mean: mean of daily means


monthly_weather <- weather %>%
  group_by(month) %>%                                             # Group by month so the following stats get applied to the monthly data subsets
  summarise(monthly_max = max(max_temp_c, na.rm = TRUE),          # monthly_max: max of daily max
            monthly_min = min(min_temp_c, na.rm = TRUE),          # monthly_min: min of daily min
            monthly_mean = mean(mean_temp_c, na.rm = TRUE)) %>%   # monthly_mean: mean of daily means
  arrange(desc(monthly_max)) %>%                                  # Arrange from highest to lowest monthly max
  mutate(station = "Rowson Lake") %>%                             # Create new variable to contain the station name 
  select(station, everything())                                   # Re-order variables

monthly_weather


# Saving the data ---------------------------------------------------------


write_csv(monthly_weather, "results/monthly_weather.csv")


