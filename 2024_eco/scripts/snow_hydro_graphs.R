####### snow hydrology graphs
View(snow_hydro)

library(ggplot2)
library(RColorBrewer)
library(cowplot)
ggplot(snow_hydro, aes(x=Year, y=`% Av StF`, color = Year))+
  geom_point()+
  geom_line()+
  theme_bw()

ggplot(snow_hydro, aes(x=Year, y=Value, col = Type))+
  geom_line()+geom_point()+
  labs(x="Year", y = "Percent Average")+
  guides(colour = guide_legend(title = "Data Type"))+
  scale_color_discrete(labels = c("Precipitation %", "Streamflow %", "SWE %"))+
  theme_bw()

ggplot(snow_swe, aes(x=Year, y=Value, col = Type))+
  geom_line()+geom_point()+
  labs(x="Year", y = "Percent Average")+
  guides(colour = guide_legend(title = "Data Type"))+
  scale_color_discrete(labels = c("Streamflow %", "SWE %"))+
  theme_bw()

precip_stream = snow_hydro[!snow_hydro$Type=='swe',]
snow_swe = snow_hydro[!snow_hydro$Type=='precip',]
  
p = ggplot(precip_stream, aes(x=Year, y=Value, col = Type))+
  geom_line()+
  labs(x="Year", y = "Percent Average")+
  #scale_fill_discrete(name = "Data Type", labels = c("Precipitation %", "Streamflow %"))+
  theme_bw()
p

stream = read.csv("better_streamflow.csv")
return = read.csv("salmon_return.csv")
head(stream)

ggplot(stream, aes(x=year, y=Average, color = Station))+
  geom_line()

ggplot() + 
  geom_line(data=stream, aes(x=year, y=Average, color = Station)) + 
  geom_line(data=return, aes(x=Year, y=trout_count), color=)


ggplot(return, aes(x=Year, y=trout_count, color = fish_type))+
  geom_line()


##### dual y-axis graph
# the x will be year cause its the same between the two
# the y will be fish count & % median

coeff <- 200

ggplot() +
  
  geom_line(data=stream, aes(x=year, y=Average, color = Station)) + 
  geom_line(data=return, aes(x=Year, y=trout_count / coeff, color=fish_type), linetype = "longdash") + # Divide by 10 to get the same range than the temperature
  labs(shape = "Split legend")+
  scale_y_continuous(
    
    # Features of the first axis
    name = "% of Median of Streamflow",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*coeff, name="Trout Count")
  )+
  guides(color = guide_legend(nrow = 5))+
  theme_bw()

fixed_salmon = read.csv("fixed_salmon_count.csv")
fixed_stream = read.csv("spread_out_streamflow.csv")
View(fixed_salmon)


## Steelhead
model1 <- lm(Steelhead ~ Snake, data = fixed_salmon)
summary(model1)
model2 <- lm(Steelhead ~ Salmon, data = fixed_salmon)
summary(model2)
model3 <- lm(Steelhead ~ Clearwater, data = fixed_salmon)
summary(model3)


## Chinook

model4 <- lm(Chinook ~ Snake, data = fixed_salmon)
summary(model4)
model5 <- lm(Chinook ~ Salmon, data = fixed_salmon)
summary(model5)
model6 <- lm(Chinook ~ Clearwater, data = fixed_salmon)
summary(model6)

## Total
model7 <- lm(total_trout ~ Snake, data = fixed_salmon)
summary(model7)

