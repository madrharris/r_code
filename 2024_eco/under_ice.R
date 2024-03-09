######### Ecology2 assignment 2: Life under the ice

### depth on Y

##### ##### 
library(ggplot2)
install.packages("ggpubr")
library(ggpubr)
install.packages("forcats")
library(forcats)
##### #####

depth = c(-0.5, -1.5, -2.5, -3, -4)
temp = c(1.8, 2.2, 3.2, 3.5, 2.5)
do = c(12.8, 12.3, 11.5, 11.8, 11.6)

ice = data.frame(depth, temp, do)
head(ice)

day = data.frame(morning, afternoon)
day
t.test(afternoon, morning, data = day, paired = T)

#### Basic Plots

temp_plot = ggplot(ice, aes(x=depth, y=temp))+
  geom_point()+
  geom_line()+
  #scale_y_reverse()+
  scale_x_continuous(position="top")+
  labs(x = "Temperature (C)", y = "Depth (m)", color = "") +
  theme_bw()

temp_plot
do_plot = ggplot(ice, aes(x=depth, y=do))+
  geom_point()+
  geom_line()+
  #scale_y_reverse()+
  scale_x_continuous(position="top")+
  labs(x = "Dissolved Oxygen (mg/L)", y = "Depth (m)", color = "") +
  theme_bw()
do_plot


max(temp)

ggplot(ice,aes(do,temp))+
  geom_point()+
  
do_plot

together <- ggarrange(temp_plot, do_plot,
                      ncol = 2, nrow = 1)
together

################ Attempt at dual x axis

p = ggplot(ice, aes(x = temp, y = depth)) +
  geom_point(aes(color = "Temperature (C)")) +
  geom_point(aes(y = do, color = "Dissolved Oxygen (mg/L)")) + ### including the extra data
  labs(x = "Temperature (C)", y = "Depth (m)", color = "") +
  scale_color_manual(values = c("red", "gray30"))+
  theme_bw()

p

p + scale_x_continuous(sec.axis = sec_axis(~.+9, name = "Dissolved Oxygen (mg/L)"))+
  theme(legend.position="bottom")


#################################

#     zooplankton movement

#############

morning = c(7,12,9,7)
afternoon = c(16,20,76,36)

count = c(7,12,9,7,16,20,76,36)
time = c("M", "M", "M", "M", "A", "A", "A", "A")

mean(16, 20, 76, 36)


depth = c(-0.5, -1.5, -2.5, -3, -4)
temp = c(1.8, 2.2, 3.2, 3.5, 2.5)
do = c(12.8, 12.3, 11.5, 11.8, 11.6)

ggplot(water, aes(x=temp, y=depth))+
  geom_point()

var(temp)
var(do)

t.test(afternoon, morning, data = day, paired = F)

var(morning)
var(afternoon)

quantile(afternoon)

water = data.frame(depth, temp, do)
head(water)

zoopl = data.frame(count, time)
head(zoopl)

ggplot(zoopl, aes(x=reorder(time, count), y=count, fill = time))+
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.25)+
  scale_fill_hue(labels = c("Afternoon", "Morning"))+
  guides(fill = guide_legend(title = "Time of Day"))+
  labs(x="Time of Sample", y = "Zooplankton Count")+
  theme_bw()+
  theme(legend.position = "bottom")

model = lm(time ~ count, data = zoopl)
summary(model)
model

afternoon

t.test(depth, do, data = water, paired = T)
# t.test(mean_temp ~ id, bb_temp, paired = TRUE)

