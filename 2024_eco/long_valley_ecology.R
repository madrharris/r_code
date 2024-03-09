###### Coding script for Ecology assignment 1: Spring semester



###

library(readr)
library(ggplot2)
install.packages("readr")
library(RColorBrewer)
yes

long_valley_SNOTEL_data <- read.csv("Downloads/WTEQ-value-SNWD-value-SMS-8-value-txt-csv.csv", 
                                    col_types = cols(`Date 1` = col_skip(), 
                                                     Good_date = col_date(format = "%Y/%m/%d"), 
                                                     date = col_skip(), `Date 2` = col_skip()))
head(long_valley_SNOTEL_data)
colnames(long_valley_SNOTEL_data) = c("date", "SWE", "snow_depth", "soil_moisture")
na.omit(long_valley_SNOTEL_data)


ggplot(long_valley_SNOTEL_data, aes(x=date, y=soil_moisture, group = SWE, color = snow_depth))+
  geom_line()


  
  
  

ggplot(long_valley_SNOTEL_data) +
  geom_line(aes(x=date, y=soil_moisture, color = "Soil Moisture % -8 in"))+
  geom_line(aes(x=date, y=snow_depth, color = "Snow Depth (in)"))+
  scale_color_manual(values=c("black", "red"))+
  labs(color = "")+
  labs(x = "Date", y = "Measured value at start of month")+
  ggtitle("SNOTEL Values for Long Valley, 2001-2024")+
  theme_bw()



 
ggplot(long_valley_SNOTEL_data) +
  geom_line(aes(x=date, y=snow_depth, color = "Snow Depth (in)"))+
  geom_line(aes(x=date, y=SWE, color = "SWE (in)"))+
  scale_color_manual(values=c("blue", "red"))+
  labs(color = "")+
  labs(x = "Date", y = "Measured value at start of month, inches")+
  theme_bw()



long_valley_SNOTEL_data %>%
  ggplot() +
  geom_line(aes(x=date, y=soil_moisture, color = "Soil Moisture % -8 in"))+
  scale_color_manual(values=c("black"))+
  labs(color = "")+
  labs(x = "Date", y = "Percentage Measured")+
  ggtitle("SNOTEL Values for Long Valley, 2001-2024")+
  theme_bw()


######## Tests and analyses

aov(SWE ~ snow_depth, long_valley_SNOTEL_data)
t.test(snow_depth ~ soil_moisture, long_valley_SNOTEL_data, paired = F, na.rm = TRUE)



write.csv(long_valley_SNOTEL_data, "/Users/madisonharris/Documents/long_valley.csv")

summary(long_valley_SNOTEL_data, na.rm = TRUE)

### linear regression output stuff
lm(formula = mean_temp ~ year, data = bb_temp)


mapply(function(SWE, snow_depth) {
  if(all(is.na(SWE)) || all(is.na(soil_moisture))) NULL else t.test(SWE, snow_depth, na.action=na.omit)
}, long_valley_SNOTEL_data)

mean(long_valley_SNOTEL_data$soil_moisture, na.rm = TRUE)

### run unpaired. its two different values, not a before and after. 
t.test(long_valley_SNOTEL_data$snow_depth, long_valley_SNOTEL_data$SWE, paired=F, na.rm = T)

t.test(long_valley_SNOTEL_data$soil_moisture, long_valley_SNOTEL_data$snow_depth, paired = F, na.rm = T)

t.test(long_valley_SNOTEL_data$soil_moisture, long_valley_SNOTEL_data$SWE, paired = F, na.rm = T)


### log

model1 = lm(formula = soil_moisture ~ snow_depth, data = long_valley_SNOTEL_data)
summary(model1)
plot(model1)
model1

ggplot(long_valley_SNOTEL_data, aes(snow_depth, soil_moisture)) +
  geom_point() +
  stat_smooth(method = lm)+
  scale_color_manual(values=c("black"))+
  labs(color = "")+
  labs(x = "Snow Depth (in)", y = "Soil Moisture (%)")+
  theme_bw()
  
mean(long_valley_SNOTEL_data$soil_moisture, na.rm = T)
12.49/16.80502


lm(formula = mean_temp ~ year, data = bb_temp)

ggplot(long_valley_SNOTEL_data, aes(x=date, y=snow_depth))+
  geom_point()+
  geom_smooth(method = "lm", se = F)

##### linear regression

all_model = lm(soil_moisture ~ snow_depth + SWE, data = long_valley_SNOTEL_data)
summary(all_model)
all_model

##### multiple regression analysis

short_model = lm(soil_moisture ~ snow_depth, data = long_valley_SNOTEL_data)
summary(short_model)

plot(all_model)
par(mfrow=c(2,2))


ggplot(data = long_valley_SNOTEL_data, aes(x=snow_depth, y=soil_moisture))+
  geom_line()
