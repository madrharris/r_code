###########################
## ecology class, climate data

####

## is there a significant change in mean annual temperature between 1990-2005 & 2006-2021

bb_temp = read.csv("bb_temp_r.csv")
View(bb_temp)
bb_temp$id = factor(bb_temp$id)

t.test(mean_temp ~ id, bb_temp, paired = TRUE)

### linear regression output stuff
lm(formula = mean_temp ~ year, data = bb_temp)


### statistically sig relationship between CO2 & Temperature

ice = read.csv("Vostok_interp.csv")
names(ice)

ggplot(ice, aes(x=temp, y=co2))+
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)
  


####### tree core data

tree_core = read.csv("bear_basin_snotel_tree_width.csv")
View(tree_core)
names(tree_core)

## graph to compare core width and cum precip
precip = ggplot(tree_core, aes(x=ring_width, y=cum_precip))+
  geom_point(size=2)+
  labs(x="Core Width (mm)", y="Cumulative Precipitarion")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
precip

## graph to compare core width and max swe
swe = ggplot(tree_core, aes(x=ring_width, y=max_swe))+
  geom_point(size=2)+
  labs(x="Core Width (mm)", y="Maximum Snow Water Equivalent")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
swe

## graph to compare core width and temperature
temp = ggplot(tree_core, aes(x=ring_width, y=mean_temp))+
  geom_point(size=2)+
  labs(x="Core Width (mm)", y="Temperature Mean, Annual (C)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
temp

head(tree_core)

library(cowplot)
all_together = plot_grid(temp, swe, precip, ncol=3, nrow = 1)
all_together


year_core
core_temp
core_precip
precip_core
snow_core


#### histogram
hist(tree_core$ring_width)


##### linear regression

model = lm(ring_width ~ mean_temp, data = tree_core)
summary(model)

##### multiple regression analysis
model_3 = lm(ring_width ~ mean_temp + cum_precip + snow_disap, data = tree_core)
summary(model_3)

## the later the snow melts, the more growth we see. Slope of 4.174e-03

snow_disap_core = ggplot(tree_core, aes(x=ring_width, y = snow_disap))+
  geom_point(size=2)+
  labs(x="Snow Disap", y="Ring width (mm)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
snow_disap_core
plot(model_3)

par(mfrow=c(2,2))
