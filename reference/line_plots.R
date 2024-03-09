#################################
#
#       ggplot
#     Line Graphs
#
# install.packages("ggplot2")
#################################

install.packages("ggplot2")
library(ggplot2)
# make data

data = data.frame(bottom=seq(10,100), side=seq(10,100)/2+rnorm(90))

################      make y logarithmic      #################
# make plot

ggplot(data, aes(x=bottom, y=side))+
  geom_line()+
  scale_y_log10(breaks=c(1,5,10,15,20,50,100), limits=c(1,100))

################      how to do grouped line data     ################

# input data frame has 3 columns:
  
# An ordered numeric variable for the X axis
# Another numeric variable for the Y axis
# A categorical variable that specify the group of the observation

# ggplot(data, aes(x=x, y=y, fill = categorical data, color = categorical data))


################      linear model and confidence interval       ################  

# using geom_smooth(). add condifence interval with (se=TRUE)

ggplot(data, aes(x=x, y=y))+
  geom_point(color='red4')+
  geom_smooth(method=lm, color="black", fill="#69b3a2", se=TRUE)      # method= logarithmic

# etc


### Line annotation ###

## required libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)

data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T)
data$date <- as.Date(data$date)

#### Annotation

## annotate(geom="text", x=as.Date("2017-01-01"), y=20089,        ### select a point to have the annotation at
#     label="Text here, etc") +
## annotate(geom="point", x=as.Date("2017-12-17"), y=20089, size=10, shape=21, fill="transparent") +  ## adds circle at point

ggplot(data, aes(x=date, y=value)) +
  geom_line(color="#69b3a2") +
  ylim(0,22000) +
  annotate(geom="text", x=as.Date("2017-01-01"), y=20089, 
           label="Bitcoin price reached 20k $\nat the end of 2017") +
  annotate(geom="point", x=as.Date("2017-12-17"), y=20089, size=10, shape=2, fill="transparent") +
  geom_hline(yintercept=5000, color="orange", size=.5) +
  theme_ipsum()






