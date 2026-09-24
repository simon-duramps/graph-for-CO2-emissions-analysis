# ============================================
# CO2 EMISSIONS ANALYSIS (1960-2018)
# Author: Simon Duramps
# ============================================

# --- HOW TO USE THIS SCRIPT -----------------
#
# 1. Install R and RStudio
# 2. Write: install.packages("tidyverse")
# 3. Download the dataset from Kaggle (link in README)
# 4. Place the CSV file in the same folder as this script
# 5. Change the file path below (line "DATA IMPORT")
# 6. Select all script (ctrl + a) and 'Run' the script (Ctrl + Shift + Enter)
#
# TO CHANGE THE COUNTRY:
#   - Modify the line "your_country_here <- 'France'"
#   - Replace "France" with any country name from the dataset
#
# TO SEE BOTH PLOTS:
#   - Click the arrows ◀ ▶ in the "Plots" tab (bottom right of RStudio)
#
# ============================================

library(tidyverse)

# --- Data import ----------------------------

#!Enter the path to the CSV file (the data) here.!
data <- read_csv("C:/Users/duram/Desktop/Documents_R/CO2 Emissions 1960-2018.csv")
#[You can find the CSV file containing the data here: https://www.kaggle.com/datasets/ulrikthygepedersen/co2-emissions-by-country]

#Example for me :) (Windows) : data <- read_csv("C:/Users/duram/Desktop/Documents_R/CO2 Emissions 1960-2018.csv")

# --- Clean column names ---------------------

data <- data %>%
  rename_with(~ str_replace_all(., "\\.", " "))

# --- Plot 1: (defaulting to France. The mianbao and wine country !) ----

your_country_here <- "France"

chicken <- data %>%
  filter(`Country Name` == your_country_here) %>%
  pivot_longer(
    cols = matches("^\\d{4}$"),
    names_to = "Year",
    values_to = "CO2"
  )

ggplot(chicken, aes(x = Year, y = CO2, group = 1)) +
  geom_line(color = "steelblue") +
  labs(
    title = paste("CO2 Emissions in", your_country_here, "(1960-2018)"),
    x = "Year",
    y = "CO2 emissions (metric tons per inhabitant)"
  ) +
  theme_minimal() +
  scale_x_discrete(breaks = seq(1960, 2018, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))

# --- Plot 2: Country comparison -------------

countries <- data %>%
  filter(`Country Name` %in% c("Africa Western", "France", "China", "United States")) %>%
  pivot_longer(
    cols = matches("^\\d{4}$"),
    names_to = "Year",
    values_to = "CO2"
  )

ggplot(countries, aes(x = Year, y = CO2, color = `Country Name`, group = `Country Name`)) +
  geom_line(linewidth = 1) +
  labs(
    title = "CO2 Emissions Evolution (1960-2018)",
    x = "Year",
    y = "CO2 emissions (metric tons per inhabitant)",
    color = "Country"
  ) +
  theme_minimal() +
  scale_x_discrete(breaks = seq(1960, 2018, by = 5)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))