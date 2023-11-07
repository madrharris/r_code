#############################################

#### Assignment 4, M Harris

#### programmer: madison harris
#### harr8597@vandals.uidaho.edu

#### purpose: download and manipulate NEON data. use ggplot to make a density plot

#### updated sept 17, 2023

#############################################

install.packages("neonUtilities")
install.packages("neonOS")
install.packages("cowplot")

library(cowplot)
library(lubridate)
library(neonUtilities)
library(readr)



##### Secchi depth for Lake Barco (NEON). DP1.20252.001, BARC, Jan 2014-Jan 2021
##      loadByProduct(dpID = "DP1.20252.001", site = "BARC", startdate = "2014-01", enddate = "2021-01")

options(stringsAsFactors=F)

setwd("~/Downloads/NEON_data/")

### pull apart zip file and combine date files into one mega-document
stackByTable("NEON_depth-secchi.zip")

### convert csv to dataframe

dep_secchi <- read.csv("NEON_depth-secchi/stackedFiles/dep_secchi.csv")
dim(dep_secchi)
names(dep_secchi)
head(dep_secchi)


###### Plot DataFrames
plot_mean = ggplot(dep_secchi, aes(secchiMeanDepth)) + geom_density()
plot_max = ggplot(dep_secchi, aes(maxDepth))+
  geom_density()
plot_euphotic = ggplot(dep_secchi, aes(euphoticDepth))+
  geom_density()


###### Style Theme  
figure_theme <- theme(
  axis.title = element_text(family = "Helvetica", size = (13), colour = "steelblue4"),
  axis.text = element_text(family = "Courier", colour = "cornflowerblue", size = (11))
) 

##### Figure Plots + labels

mean = plot_mean + figure_theme + labs(y = "Density", x = "Secchi Mean Depth (m)")
max = plot_max + figure_theme + labs(y = "Density", x = "Secchi Max Depth (m)")
euphotic = plot_euphotic + figure_theme + labs(y = "Density", x = "Euphotic Depth (m)")


##### Combine all graphs into one figure (requires cowplot)

all_in_one <- plot_grid(mean, euphotic, max,
                       ncol = 3, nrow = 1)
all_in_one


##### 4) average and stdev of values of interest. 

mean(dep_secchi$secchiMeanDepth, na.rm = TRUE)
mean(dep_secchi$maxDepth, na.rm = TRUE)
mean(dep_secchi$euphoticDepth, na.rm = TRUE)

sd(dep_secchi$secchiMeanDepth, na.rm = TRUE)
sd(dep_secchi$maxDepth, na.rm = TRUE)
sd(dep_secchi$euphoticDepth, na.rm = TRUE)


