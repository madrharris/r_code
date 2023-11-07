#############################################

#### Assignment 5, M Harris

#### programmer: madison harris
#### harr8597@vandals.uidaho.edu

#### purpose: download and manipulate SNOTEL data. learn more in-depth ggplot skills

#### updated sept 22, 2023

#############################################

## Read in the data from the Secesh Summit (id 740) and Santa Fe (id 922) SNOTEL site
## x = date, y = daily mean temperature C

install.packages("snotelr")
install.packages("ggplot2")
install.packages("lubridate")
require(snotelr)
library(lubridate)
library(ggplot2)
library(dplyr)
library(snotelr)


### Load in the two data sets using snotel_download

### bear_basin = snotel_download(site_id = c(319), internal = TRUE)

secesh = snotel_download(site_id = c(740), internal = TRUE)
santafe = snotel_download(site_id = c(922), internal = TRUE)

head(secesh)
View(secesh)

##### convert date CHR to date via posixct
secesh$date <- as.POSIXct(secesh$date, format = "%Y-%m-%d", tz = "UTC")
santafe$date <- as.POSIXct(santafe$date, format = "%Y-%m-%d", tz = "UTC")

###### creating data frames for ease of access with the ggplots
#colors <- c("Secesh Summit (id 740)" = "blue", "Santa Fe (id 922)" = "red")
####  labeling command for names
labeling = labs(x = "Date", y = "Daily Temperature Mean (C)", color = "SNOTEL Site Name", linewidth = 15)

###
# theme for axis labels size = 15
label_size = theme(axis.text=element_text(size=15),
                   axis.title=element_text(size=15))

#######     GGPLOT command. geom_line for the two data frames combined into one. + labeling list (with font size). 
####            ylim for limiting the y axis. scale_color_manual makes the legend using the labeling and coors environment
####            theme_bw() for basic colors and shading of background
####            font size of the axis labels in your script is set to 15 

main_plot = ggplot() + 
  geom_line(data=secesh, aes(x=date, y=temperature_mean, color='Secesh Summit (id 740)'), size = 0.5) + 
  geom_line(data=santafe, aes(x=date, y=temperature_mean, color='Santa Fe (id 922)'), size = 0.5) +
  labeling +
  ylim(-30,25) + 
  scale_color_manual(values = c("Secesh Summit (id 740)" = "blue", "Santa Fe (id 922)" = "red")) +
  theme_bw()
main_plot

main_plot + label_size
# adding label_size to main plot directly in the code results in no effect

  
## not necessary for final graph, but a fun experiment
#colors <- c("Secesh Summit (id 740)" = "blue", "Santa Fe (id 922)" = "red")


######## Figure 2


site_data = rbind(secesh, santafe)
## rbind layers data together and splits by site_name
View(site_data)

## box label code to keep the big one short. Axis and title id's
box_label = labs(x = "SNOTEL id", y = "Daily Temperature Mean (degrees Celsius)")


#### boxplot code.

ggplot(site_data, aes(x=site_name, y = temperature_mean, fill = site_name)) +  # ggplot function. x & y axes, fill according to site name
  geom_boxplot() +
  box_label +
  theme(legend.position="none", axis.text=element_text(size=15), axis.title=element_text(size=15)) +     # removes the automatic legend created by the boxplot
  scale_fill_manual(values = c("red", "blue")) +      ## assigns color, matches the graph above, figure 1. 
  scale_x_discrete(labels=c("Santa Fe (id 922)", "Secesh Summit (id 740)"))     ### changes axis label from data. 
  







###### alternative boxplot code, no color

#ggplot(site_data, aes(x = site_name , y = temperature_mean)) +
#  stat_summary(colour="red", geom="point") +
#  geom_boxplot (aes(fill=site_name), alpha=.5, outlier.colour = "dark gray", 
#                outlier.size = 1) +
#  geom_boxplot(data=site_data, aes(x = site_name , y = temperature_mean)) +
#  scale_x_discrete(limits=c(levels(site_data$site_name))) +
#  box_label

###### alternative tries. stacks on top of each other
#ggplot() +
#  geom_boxplot(data=secesh, aes(y=temperature_mean, color='Secesh Summit (id 740)')) +
#  geom_boxplot(data=santafe, aes(y=temperature_mean, color='Santa Fe (id 922)'))




