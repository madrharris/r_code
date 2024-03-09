###########################
## ecology class, climate data

## tree core data
## 

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
getwd()

tree_core = read.csv("homework/bear_basin_snotel_tree_width.csv")
View(tree_core)
names(tree_core)

## graph to compare core width and cum precip
precip = ggplot(tree_core, aes(x=ring_width, y=cum_precip))+
  geom_point(size=2)+
  labs(x="Core Width (mm)", y="Cumulative Precipitarion (cm)")+
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


## axis switched

## graph to compare core width and cum precip
precip = ggplot(tree_core, aes(y=ring_width,x=cum_precip))+
  geom_point(size=2)+
  labs(y="Core Width (mm)", x="Cumulative Precipitarion (cm)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
precip

## graph to compare core width and max swe
swe = ggplot(tree_core, aes(y=ring_width, x=max_swe))+
  geom_point(size=2)+
  labs(y="Core Width (mm)", x="Maximum SWE (cm)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
swe

## graph to compare core width and temperature
temp = ggplot(tree_core, aes(y=ring_width, x=mean_temp))+
  geom_point(size=2)+
  labs(y="Core Width (mm)", x="Temperature Mean, Annual (C)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
temp

head(tree_core)


# ggplotRegression(lm(Y value ~ X value, data = dataframe))
ggplotRegression(lm(ring_width ~ cum_precip, data = tree_core))

library(ggplot2)

ggplotRegression <- function (fit) {
  
  require(ggplot2)
  
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       "Intercept =",signif(fit$coef[[1]],5 ),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)))
}









citation(package = "ggplot2")

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
model_2 = lm(ring_width ~ mean_temp + cum_precip + max_swe, data = tree_core)
summary(model_2)
summary(model_3)

plot(model_2, 5)

View(tree_core)
## the later the snow melts, the more growth we see. Slope of 4.174e-03

snow_disap_core = ggplot(tree_core, aes(x=ring_width, y = snow_disap))+
  geom_point(size=2)+
  labs(x="Snow Disap", y="Ring width (mm)")+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic()
snow_disap_core
plot(model_3)

par(mfrow=c(2,2))
plot(model_2)
