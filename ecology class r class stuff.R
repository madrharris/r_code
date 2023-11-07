##########################
#
#   ecology class r class stuff
#
###### Duck Lake
####    Packet stuff
        # scatterplot, linear regression models, t-test, box plots, p-values and modeling

install.packages("readr")
install.packages("ggplot2")
library(readr)
library(ggplot2)



site_id <- c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3)
conductivity <- c(5.7,5.6,5.8,5.8,5.6,6.3,6.0,7.3,6.6,6.4,6.7,6.3,6.2,6.6,6.4)
pH <- c(7.58,7.31,7.47,7.46,7.52,7.02,7.05,7.25,7.1,7.32,6.93,6.89,7.16,7.17,7.17)
DO <- c(6.5,6.3,6.6,6.6,6.8,7.96,8.33,8.08,8.44,8.27,6.8,6.7,6.7,6.6,6.2)
ducklake_data <- data.frame(site_id, conductivity, pH, DO)
View(ducklake_data)

## site id: 1 = lake, 2 = outlet, 3 = river/downstream
### OR
#ducklake_data_file = read.csv("duck_lake.csv")   ### but that's boring. made dataframe first then just copy-paste into an excel sheet.
#View(ducklake_data_file)
  # same amount of work tbh to make the file

hist(ducklake_data$conductivity) + labs
### OR
ggplot(ducklake_data, aes(x=DO))+
  geom_histogram()+
  theme_bw()
### gross plot. use hist()

summary(ducklake_data)

ggplot(ducklake_data, aes(x=site_id, y=conductivity)) +
  geom_point()+
  stat_smooth(method = "lm", formula = y ~ x, col = "red") +
  labs(x="site id", y = "conductivity") + theme(text=element_text(size=10))
# gross

################  4. Scatterplot
### air vs leaf temp

library(readr)
temp <- read_csv("air vs leaf temp.csv", col_types = cols(Timestamp = col_datetime(format = "%m/%d/%Y %H:%M")))
View(temp)

## scatterplot: x = air, y = leaf
plot(x=temp$air_temp, y=temp$leaf_temp, data = temp)

air_leaf_plot = ggplot(temp, aes(x=temp$air_temp, y=temp$leaf_temp)) +
  geom_point(shape=18) +
  stat_smooth(method="lm", formula = y ~ x, col = "red") +
  labs(x="Air Temperature (C)", y="Leaf Temperature (C)")+
  ggtitle("Air and Leaf Temperature Relationship (C)", ) +
  theme(text=element_text(size=10))+
  theme_classic()

air_leaf_plot

############### 5. fit linear regression model and show model fit statistics and model diagnostics

model1 = lm(air_temp ~  leaf_temp, data = temp)
summary(model1)
par(mfrow = c(2,2))
plot(model1)
### air temp = y

model2 = lm(leaf_temp ~  air_temp, data = temp)
summary(model2)
  #  intercept (estimate) = -1.984847
  #  slope: air_temp estimate (1.108314)
par(mfrow = c(2,2))
plot(model2)
### leaf temp = y. Air temp is x. This is the right one. 



############# 6. Paired t-test
##    boxplot & paired t-test. monthly soil moisture changes .csv. compare soilm difference between july and august

##### changes date column to datetime format
soil_m = read_csv("monthly soil moisture changes Rstudio.csv", col_types = cols(date = col_datetime(format = "%m/%d/%Y %H:%M")))
View(soil_m)
max(soil_m$date)
### boxplot: x is a grouping variable (month)
#reset plot layout
par(mfrow = c(1,1))
boxplot(soil_moisture ~ month, soil_m)


### for ggplot, must change month to character otherwise it'll stack up the values on top of each other
soil_m$month = as.character(soil_m$month)

## theme = error bars
error = stat_boxplot(geom = "errorbar", # Error bars
                     width = 0.25)    # Bars width

## ggplot
soil = ggplot(soil_m, aes(x = month, y = soil_moisture, fill = month)) + 
  geom_boxplot()+
  error +
  scale_fill_hue(labels = c("July", "August")) + ### changes names under legend 
  guides(fill = guide_legend(title = "Month")) + ### changes name OF legend
  labs(x="Month of sample", y="Soil Moisture") + ### labels of axes
  ggtitle("Soil Moisture per Month") + ### adds figure title
  theme_bw() ### theme
soil

#############     t-test. x = grouping variable
t_test = t.test(soil_moisture ~ month, soil_m, paired = TRUE) ### without paired = TRUE, it does a Welch Two Sample t-test
t_test


###################   7. Independent sample t-test (two sample t-test). t.test, paired = FALSE
##      use radial tree growth dataset. change timestamp to datetime
tree_growth <- read_csv("tree_radial_growth R Studio.csv", 
                                        col_types = cols(timestamp = col_datetime(format = "%m/%d/%Y %H:%M")))
names(tree_growth)
View(tree_growth)
head(tree_growth)
## change tree_id to character for boxplot stacking purposes
tree_growth$tree_id = as.character(tree_growth$tree_id)

## theme = error bars
error = stat_boxplot(geom = "errorbar", # Error bars
                     width = 0.25)    # Bars width

tree_radial = ggplot(tree_growth, aes(x = tree_id, y = tree_radial_growth, fill = tree_id)) + 
  geom_boxplot()+
  error +
  guides(fill = guide_legend(title = "Tree")) +
  labs(x="Tree ID", y="Radial Growth") +
  ggtitle("Radial Tree Growth") +
  theme_bw()
tree_radial
## t test: 	Welch Two Sample t-test

ttest_tree = t.test(tree_radial_growth ~ tree_id, tree_growth, paired = FALSE)
ttest_tree


#######
# pinecone experiment during class

p_height <- c(10.5, 11.7, 10.5, 9.5, 9, 9, 11, 5.5)
p_weight <- c(31.0595, 33.51, 27.4, 23.74, 36.13, 25.6318, 30.55, 11.412)
p_diameter <- c(7, 7.5, 7.5, 6.5, 7, 7, 8.5, 4.5)

pinecone = data.frame(p_height, p_weight, p_diameter)
View(pinecone)


### plot: scatter. y=variable you want to predict, x=your predictor variable. want to predict weight, using height

diameter = ggplot(pinecone, aes(x=p_diameter, y=p_weight)) +
  geom_point(shape=18) +
  stat_smooth(method="lm", formula = y ~ x, col = "red", se=FALSE) +
  labs(x="PP Cone Diameter(cm)", y="PP Cone Weight (g)")+
  theme(text=element_text(size=10))+
  theme_classic()
diameter

plot(x = p_height, y = p_weight, data = pinecone)

model_pinecone_weight = lm(p_weight ~ p_height, data=pinecone)
summary(model_pinecone_weight)
## p value is low, reject the ho. reject null hypothesis
## how strong is relationship? quantify with adjusted r^2. 0.5898. about 60% is explained. 40% is not. moderately strong
model_pinecone_diameter = lm(p_diameter ~ p_height, data=pinecone)
summary(model_pinecone_diameter)

model_attempt <- lm(p_weight ~ p_height + p_diameter,data = pinecone)
summary(model_attempt)

y_w = 3.223*9.2 - 3.471
y_w

y_d = 0.5442*9.2 + 1.7196
y_d

plot(model_pinecone_weight)
par(mfrow = c(2,2))

citation("ggplot2")



################ Duck Lake T-test stuff

## compare lake and outflow, DO

site_id <- c(1,1,1,1,1,2,2,2,2,2)
## site id: 1 = lake, 2 = outlet, 3 = river/downstream

conductivity <- c(5.7,5.6,5.8,5.8,5.6,6.3,6.0,7.3,6.6,6.4)
pH <- c(7.58,7.31,7.47,7.46,7.52,7.02,7.05,7.25,7.1,7.32)
DO <- c(6.5,6.3,6.6,6.6,6.8,7.96,8.33,8.08,8.44,8.27)
ducklake_data_ttest <- data.frame(site_id, conductivity, pH, DO)
View(ducklake_data_ttest)

#t-test. compare dissolved oxygen per lake and outflow. 

t.test(DO ~ site_id, ducklake_data_ttest, paired = FALSE)

ducklake_data_ttest$site_id = as.character(ducklake_data_ttest$site_id)



########## just for fun ###########

ggplot(ducklake_data_ttest, aes(x = site_id, y = DO, fill = site_id)) + 
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.25) +
  #scale_fill_hue(labels = c("Lake", "Outflow")) + ### changes names under legend 
 # guides(fill = guide_legend(title = "Site")) + ### changes name OF legend
  labs(x="Site", y="Dissolved Oxygen") + ### labels of axes
 # ggtitle("Measured Dissolved Oxygen per Site", subtitle = "Duck Lake, Idaho") +
  theme(legend.position = "none")
do_plot

ph_plot = ggplot(ducklake_data_ttest, aes(x = site_id, y = pH, fill = site_id)) + 
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.25) +
  scale_fill_hue(labels = c("Lake", "Outflow")) + ### changes names under legend 
  guides(fill = guide_legend(title = "Site")) + ### changes name OF legend
  labs(x="Site", y="pH") + ### labels of axes
  theme(legend.position = "none")

  # ggtitle("Measured Dissolved Oxygen per Site", subtitle = "Duck Lake, Idaho") +
  #theme_linedraw(base_size = 10)
ph_plot

cond_plot = ggplot(ducklake_data_ttest, aes(x = site_id, y = conductivity, fill = site_id)) + 
  geom_boxplot()+
  stat_boxplot(geom = "errorbar", width = 0.25) +
  scale_fill_hue(labels = c("Lake", "Outflow")) + ### changes names under legend 
  guides(fill = guide_legend(title = "Site")) + ### changes name OF legend
  labs(x="Site", y="Conductivity") ### labels of axes
  #ggtitle("Measured Dissolved Oxygen per Site", subtitle = "Duck Lake, Idaho") +
  #theme_linedraw(base_size = 10)
cond_plot

install.packages("cowplot")
library(cowplot)

plot_grid(do_plot, ph_plot, cond_plot,
          ncol = 3, nrow = 1)


main <- plot_grid(
  do_plot + theme(legend.position="none"),
  ph_plot + theme(legend.position="none"),
  cond_plot + theme(legend.position="none"),
  align = 'vh',
  hjust = -1,
  nrow = 1
)
main

legend <- get_legend(cond_plot + theme(legend.box.margin = margin(0, 0, 0, 12)))

# now add the title
# add margin on the left of the drawing canvas,
# so title is aligned with left edge of first plot

title <- ggdraw() + 
  draw_label("Water measurements from Duck Lake, ID", fontface = 'bold', x = 0, hjust = 0) +
  theme(plot.margin = margin(0, 0, 5, 7))

# theme(plot.margin = margin(top =, right=, bottom=, left=))

#### combines all three plots WITH legend
primary = plot_grid(main, legend, rel_widths = c(3, .4)) 

#### adds title to plot
final = plot_grid(title, primary, ncol = 1,
          # rel_heights values control vertical title margins
          rel_heights = c(0.1, 1)
)
final



