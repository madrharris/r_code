#############################################

#### Assignment 3, M Harris

#### programmer: madison harris
#### harr8597@vandals.uidaho.edu

#### purpose: convert chr to date. learn basic ggplot information

#### updated sept 17, 2023

#############################################


#### install packages and load libraries
install.packages("snotelr")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("dplyr")
require(snotelr)
library(lubridate)
library(ggplot2)
library(dplyr)

###### read in file 

bird_count = read.csv('bird_count.csv')
names(bird_count)

###### convert date column from character format to date format via POSIXct 
bird_count$Date <- as.POSIXct(bird_count$Date, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")


###### bird plot: ggplot graph, line graph showing bird counts per day/time. Labs: axis labels, theme: basic color layout
bird_plot = ggplot(data = bird_count, aes(x = Date, y = Bird.count)) +
  geom_line(aes(group = 1)) +
  theme_light() + labs(x = "Date & Time", y = "Bird Count") + ggtitle("Bird counts over time") + 
  theme(plot.title = element_text(hjust = 0.5))

bird_plot

###### 2) Add a column to the bird count data set that just shows the day on which the data was collected.
bird_count$Sample_date = as.Date(bird_count$Date)
names(bird_count)
    ### check if works


###### 3) Download the Bear Basin SNOTEL dataset and randomly select 10 snow water equivalent values from the dataset
####      requires snotel ^^^
bear_basin = snotel_download(site_id = c(319), internal = TRUE)

### random seed & check names
set.seed(2126)
names(bear_basin)

#### pull random values from dataset. will display 10 random variables. 
random_values = sample(bear_basin$snow_water_equivalent, 10)
random_values
### will display different values each command of =. 