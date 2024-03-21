########  brundage snowpit data

library(ggplot2)
library(readxl)


snowpit_temp = read_excel("snowpit_data_temp.xlsx")
head(Snowpit_brundage)

pit_brundage = Snowpit_brundage
pit_temp = snowpit_temp


library(gt)
library(dplyr)

pit_brundage %>%
  gt() %>%
  tab_footnote(footnote = md("Measured in cm"),
               locations = cells_column_labels(columns = Layer)) %>%
  tab_footnote(footnote = md("Measured in grams"),
               locations = cells_column_labels(columns = Weight)) %>%
  tab_footnote(footnote = md("Measured in cm"),
               locations = cells_column_labels(columns = Height)) %>%
  tab_footnote(footnote = md("Density calculated from a 100 ml tube")) %>%
  cols_hide(columns = c(Hardness))
  
pit_brundage %>%
  gt() %>%
  cols_hide(columns = c(Height, Weight, Density)) %>%
  tab_footnote(footnote = md("Measured in cm"), 
               locations = cells_column_labels(columns = Layer)) %>%
  tab_footnote(footnote = md("Measured in cm"), 
               locations = cells_column_labels(columns = SWE))









d = 0.8
k  = 0.00213
Tb = 21.6
A = 367.17
Ta = -4.6

surface = ((k*A))*((Tb-Ta)/d)
surface ##    25.61286

surface = ((0.00213 W/cm*K * 367.17 cm^2))*((21.6 C - (-4.6 C))/0.8 cm)
subniv = ((0.00213 W/cm*K * 367.17 cm^2))*((21.6 C - 0.7 C)/0.8 cm)


subnv = ((k*A))*((Tb-0.7)/d)
subnv ##      20.43163

## metabolic equation
##    Qa = (k * A) * ((Tb-Ta)/d)
##    k = thermal conductivity, A = surface area, Tb = core temp. Ta = air temp, d = insulation thickness


#### table

table()

